//
//  YLPlayersViewModel.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/22/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "YLPlayersViewModel.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "YLReactiveDribbbleEngine.h"
#import "YLDribbbleUser.h"

@interface YLPlayersViewModel()

@property (nonatomic, copy, readwrite) NSArray *players;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) BOOL paginationFinished;

@end

@implementation YLPlayersViewModel

+ (YLPlayersViewModel*)playerFollowingViewModelWithName:(NSString*)name {
    return [[YLPlayersViewModel alloc] initWithUsername:name
                                        andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                            return [YLReactiveDribbbleEngine getPlayerFollowingWithUsername:name page:page];
                                        }];
}

+ (YLPlayersViewModel*)playerFollowerViewModelWithName:(NSString*)name {
    return [[YLPlayersViewModel alloc] initWithUsername:name
                                        andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                            return [YLReactiveDribbbleEngine getPlayerFollowerWithUsername:name page:page];
                                        }];
}

+ (YLPlayersViewModel*)playerDrafteeViewModelWithName:(NSString*)name {
    return [[YLPlayersViewModel alloc] initWithUsername:name
                                        andGetListBlock:^RACSignal *(NSString *name, NSUInteger page) {
                                            return [YLReactiveDribbbleEngine getPlayerDrafteeWithUsername:name page:page];
                                        }];
}

- (instancetype)initWithUsername:(NSString*)name andGetListBlock:(RACSignal * (^)(NSString* name, NSUInteger page))fetchBlock
{
    self = [super init];
    if (self) {
        _page = 0;
        _paginationFinished = NO;
        _players = @[];
        
        @weakify(self);
        
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            RACSignal *loadPage = [fetchBlock(name, self.page)
                                   doNext:^(YLDribbbleUserList* userList) {
                                       @strongify(self);
                                       self.page++;
                                       if (userList.pages == userList.pages) {
                                           self.paginationFinished = YES;
                                       }
                                   }];
            
            return [loadPage initially:^{
                @strongify(self);
                self.players = @[];
                self.page = 1;
                self.paginationFinished = NO;
            }];
        }];
        
        RACSignal *enabled = [RACObserve(self, paginationFinished) not];
        _loadMoreCommand = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^(id _) {
            return [fetchBlock(name, self.page)
                    doNext:^(YLDribbbleUserList* userList) {
                        @strongify(self);
                        self.page++;
                        if (userList.pages == userList.pages) {
                            self.paginationFinished = YES;
                        }
                    }];;
        }];
        
        RACSignal *newResults = [RACSignal merge:@[
                                                   [_reloadCommand.executionSignals concat],
                                                   [_loadMoreCommand.executionSignals concat],
                                                   ]];
        
        RAC(self, players) = [newResults map:^id(YLDribbbleUserList* userList) {
            @strongify(self);
            return [self.players arrayByAddingObjectsFromArray:userList.players];
        }];
    }
    return self;
}

@end
