//
//  YLCommentsViewModel.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/28/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "YLCommentsViewModel.h"
#import "YLReactiveDribbbleEngine.h"
#import "YLDribbbleUser.h"
#import "YLDribbbleComment.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface YLCommentsViewModel()

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property (nonatomic, copy, readwrite) NSArray *comments;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) BOOL paginationFinished;

@end

@implementation YLCommentsViewModel


+ (YLCommentsViewModel*)shotsCommentsViewModelWithShotID:(NSUInteger)shotID {
    
    return [[YLCommentsViewModel alloc] initWithShotID:shotID andGetListBlock:^RACSignal *(NSUInteger shotID, NSUInteger page) {
        return [YLReactiveDribbbleEngine getCommentsOfShot:shotID withPage:page];
    }];
}

- (instancetype)initWithShotID:(NSUInteger)shotID andGetListBlock:(RACSignal * (^)(NSUInteger shotID, NSUInteger page))fetchBlock
{
    self = [super init];
    if (self) {
        _page = 0;
        _paginationFinished = NO;
        _comments = @[];
        
        @weakify(self);
        
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            RACSignal *loadPage = [fetchBlock(shotID, self.page)
                                   doNext:^(YLDribbbleCommentList* commentList) {
                                       @strongify(self);
                                       self.page++;
                                       if (commentList.page == commentList.pages) {
                                           self.paginationFinished = YES;
                                       } else {
                                           self.paginationFinished = NO;
                                       }
                                   }];
            
            return [loadPage initially:^{
                @strongify(self);
                self.comments = @[];
                self.page = 1;
                self.paginationFinished = NO;
            }];
        }];
        
        RACSignal *enabled = [RACObserve(self, paginationFinished) not];
        _loadMoreCommand = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^(id _) {
            
            @strongify(self);
            return [fetchBlock(shotID, self.page)
                    doNext:^(YLDribbbleCommentList* commentList) {
                        @strongify(self);
                        self.page++;
                        if (commentList.page == commentList.pages) {
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
        
        RAC(self, comments) = [newResults map:^id(YLDribbbleCommentList* commentList) {
            @strongify(self);
            return [self.comments arrayByAddingObjectsFromArray:commentList.comments];
        }];
        
        RAC(self, loading) = [RACSignal combineLatest:@[_reloadCommand.executing, _loadMoreCommand.executing]
                                               reduce:^id(NSNumber* reloadBool, NSNumber* loadmoreBool){
                                                   return @(reloadBool.boolValue || loadmoreBool.boolValue);
                                               }];
    }
    return self;
}

@end
