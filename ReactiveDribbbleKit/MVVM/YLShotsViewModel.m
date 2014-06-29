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

@interface YLShotsViewModel()

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property (nonatomic, copy, readwrite) NSArray *shots;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) BOOL paginationFinished;

@end

@implementation YLShotsViewModel

+ (YLShotsViewModel*)followShotsViewModelOfPlayer:(YLDribbbleUser*)player {
    return [[YLShotsViewModel alloc] initWithPlayer:player
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getFollowingShotsWithUsername:player.userName page:page];
                                    }];
}

+ (YLShotsViewModel*)playerShotsViewModelOfPlayer:(YLDribbbleUser*)player {
    return [[YLShotsViewModel alloc] initWithPlayer:player
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getPlayerShotsWithUsername:player.userName page:page];
                                    }];
}

+ (YLShotsViewModel*)playerLikeShotsViewModelOfPlayer:(YLDribbbleUser*)player {
    return [[YLShotsViewModel alloc] initWithPlayer:player
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getLikeShotsWithUsername:player.userName page:page];
                                    }];
}

+ (YLShotsViewModel*)popularShotsViewModel {
    return [[YLShotsViewModel alloc] initWithPlayer:nil
                                    andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                        return [YLReactiveDribbbleEngine getPopularShotsWithPage:page];
                                    }];
}

- (instancetype)initWithPlayer:(YLDribbbleUser*)player andGetListBlock:(RACSignal * (^)(NSString* name, NSUInteger page))fetchBlock
{
    self = [super init];
    if (self) {
        _page = 0;
        _paginationFinished = NO;
        _shots = @[];
        
        @weakify(self);
        
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            RACSignal *loadPage = [fetchBlock(player.userName, self.page)
                                   doNext:^(YLDribbbleUserList* userList) {
                                       @strongify(self);
                                       self.page++;
                                       if (userList.page == userList.pages) {
                                           self.paginationFinished = YES;
                                       } else {
                                           self.paginationFinished = NO;
                                       }
                                   }];
            
            return [loadPage initially:^{
                @strongify(self);
                self.shots = @[];
                self.page = 1;
                self.paginationFinished = NO;
            }];
        }];
        
        RACSignal *enabled = [RACObserve(self, paginationFinished) not];
        _loadMoreCommand = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^(id _) {
            
            @strongify(self);
            return [fetchBlock(player.userName, self.page)
                    doNext:^(YLDribbbleUserList* userList) {
                        @strongify(self);
                        self.page++;
                        if (userList.page == userList.pages) {
                            self.paginationFinished = YES;
                        } else {
                            self.paginationFinished = NO;
                        }
                    }];;
        }];
        
        RACSignal *newResults = [RACSignal merge:@[
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
