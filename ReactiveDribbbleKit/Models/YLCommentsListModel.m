//
//  YLCommentsListModel.m
//  Dribbb7e
//
//  Created by Yong Li on 14-1-14.
//  Copyright (c) 2014年 YongLi. All rights reserved.
//

#import "YLCommentsListModel.h"

@implementation YLCommentsListModel


- (void)processShotsList:(YLDribbbleCommentList *)commentsList
{
    switch (self.status) {
        case YLListModelUnInit:
        {
            if(commentsList.page == 1 && commentsList.pages > 0) {
                [self.list removeAllObjects];
                [self.list addObjectsFromArray:commentsList.comments];
                self.page = commentsList.page;
                self.totalPages = commentsList.pages;
                self.totalItems = commentsList.total;
                
                if(self.page < self.totalPages)
                    self.status = YLListModelDownloading;
                else
                    self.status = YLListModelFinish;
                
                if([self.delegate respondsToSelector:@selector(listModelDidFinishFetch:)])
                    [self.delegate listModelDidFinishFetch:self];
            }
            else {
                [self postPageError];
            }
        }
            break;
            
        case YLListModelDownloading:
        {
            if(commentsList.page == self.page+1 ) {
                [self.list addObjectsFromArray:commentsList.comments];
                self.page = commentsList.page;
                self.totalPages = commentsList.pages;
                self.totalItems = commentsList.total;
                
                if(commentsList.page == commentsList.pages) {
                    self.status = YLListModelFinish;
                }
                
                if([self.delegate respondsToSelector:@selector(listModelDidFinishFetch:)])
                    [self.delegate listModelDidFinishFetch:self];
            }
            else {
                [self postPageError];
            }
        }
            break;
            
        case YLListModelFinish:
        {
            // do nothing
            [self postPageError];
        }
            break;
            
        default:
        {
            [self postPageError];
        }
            break;
    }
    
}

- (void)processError:(NSError*)error
{
    //NSLog(@"error : %@", error);
    
    if([self.delegate respondsToSelector:@selector(listModelDidFailedFetch:)])
        [self.delegate listModelDidFailedFetch:self];
}

- (void)postPageError
{
    NSError* error = [NSError errorWithDomain:nil code:5942 userInfo:nil];
    [self processError:error];
    
    if([self.delegate respondsToSelector:@selector(listModelDidFailedFetch:)])
        [self.delegate listModelDidFailedFetch:self];
}


- (void)refresh
{
    
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getCommentsOfShot:self.shot.shotID withPage:1 successBlock:^(YLDribbbleCommentList *list) {
        self.status = YLListModelUnInit;
        [self processShotsList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
}

- (void)loadNextPage
{
    
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getCommentsOfShot:self.shot.shotID withPage:self.page+1 successBlock:^(YLDribbbleCommentList *list) {
        [self processShotsList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
}

- (BOOL)isFinished
{
    return self.status == YLListModelFinish;
}


@end
