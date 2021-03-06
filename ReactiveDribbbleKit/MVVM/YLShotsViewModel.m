//
//  YLShotsViewModel.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/26/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "YLShotsViewModel.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "YLReactiveDribbbleEngine.h"
#import "YLDribbbleUser.h"
#import "YLDribbbleShot.h"
#import "YLReactiveCoreDataManager.h"

@interface YLShotsViewModel()

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property (nonatomic, copy, readwrite) NSArray *shots;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) BOOL paginationFinished;
@property (nonatomic, copy) NSString *listName;

@end

@implementation YLShotsViewModel

+ (YLShotsViewModel*)followShotsViewModelOfPlayer:(YLDribbbleUser*)player {
    return [[YLShotsViewModel alloc] initWithPlayer:player
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getFollowingShotsWithUsername:player.userName page:page];
                                    }
                                    andWithSaveList:NO];
}

+ (YLShotsViewModel*)playerShotsViewModelOfPlayer:(YLDribbbleUser*)player {
    return [[YLShotsViewModel alloc] initWithPlayer:player
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getPlayerShotsWithUsername:player.userName page:page];
                                    }
                                    andWithSaveList:NO];
}

+ (YLShotsViewModel*)playerLikeShotsViewModelOfPlayer:(YLDribbbleUser*)player {
    return [[YLShotsViewModel alloc] initWithPlayer:player
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getLikeShotsWithUsername:player.userName page:page];
                                    }
                                    andWithSaveList:NO];
}

+ (YLShotsViewModel*)popularShotsViewModel {
    YLShotsViewModel* model = [[YLShotsViewModel alloc] initWithPlayer:nil
                                                       andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                                           return [YLReactiveDribbbleEngine getPopularShotsWithPage:page];
                                                       }
                                                       andWithSaveList:YES];
    model.listName = @"popular";
    return model;
}

- (instancetype)initWithPlayer:(YLDribbbleUser*)player
               andGetListBlock:(RACSignal * (^)(NSString* name, NSUInteger page))fetchBlock
               andWithSaveList:(BOOL)isSave
{
    self = [super init];
    if (self) {
        _page = 0;
        _paginationFinished = NO;
        _shots = @[];
        
        @weakify(self);
        
        _loadCacheCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            if (self.listName) {
                return [YLReactiveCoreDataManager loadShotsListWithName:self.listName];
            } else {
                RACSignal* signal = [RACSignal empty];
                return signal;
            }
        }];
        
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            RACSignal *loadPage = [fetchBlock(player.userName, self.page)
                                   doNext:^(YLDribbbleShotList* shotsList) {
                                       @strongify(self);
                                       self.page++;
                                       if (shotsList.page == shotsList.pages) {
                                           self.paginationFinished = YES;
                                       } else {
                                           self.paginationFinished = NO;
                                       }
                                       
                                       // save to core data
                                       if (isSave) {
                                           [[YLReactiveCoreDataManager saveShotsList:shotsList] subscribeNext:^(id x) {
                                               NSLog(@"save success!");
                                           } error:^(NSError *error) {
                                               NSLog(@"save Error: %@", error);
                                           }];
                                       }
                                   }];
            
            return [loadPage initially:^{
                @strongify(self);
//                self.shots = @[];
                self.page = 1;
                self.paginationFinished = NO;
            }];
        }];
        
        RACSignal *enabled = [RACObserve(self, paginationFinished) not];
        _loadMoreCommand = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^(id _) {
            
            @strongify(self);
            return [fetchBlock(player.userName, self.page)
                    doNext:^(YLDribbbleShotList* shotsList) {
                        @strongify(self);
                        self.page++;
                        if (shotsList.page == shotsList.pages) {
                            self.paginationFinished = YES;
                        } else {
                            self.paginationFinished = NO;
                        }
                    }];;
        }];
        
        RACSignal *newResults = [RACSignal merge:@[
                                                   [_loadCacheCommand.executionSignals concat],
                                                   [_reloadCommand.executionSignals concat],
                                                   [_loadMoreCommand.executionSignals concat],
                                                   ]];
        
        RAC(self, shots) = [newResults map:^id(YLDribbbleShotList* shotsList) {
            @strongify(self);
            return [self.shots arrayByAddingObjectsFromArray:shotsList.shots];
        }];
        
        RAC(self, loading) = [RACSignal combineLatest:@[_reloadCommand.executing, _loadMoreCommand.executing]
                                               reduce:^id(NSNumber* reloadBool, NSNumber* loadmoreBool){
                                                   return @(reloadBool.boolValue || loadmoreBool.boolValue);
                                               }];
    }
    return self;
}


@end
