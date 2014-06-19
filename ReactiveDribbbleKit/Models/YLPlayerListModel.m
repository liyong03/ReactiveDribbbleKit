//
//  YLPlayerListModel.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-25.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLPlayerListModel.h"

@implementation YLPlayerListModel

- (void)processPlayersList:(YLDribbbleUserList*)playersList
{
    self.apiRequest = nil;
    switch (self.status) {
        case YLListModelUnInit:
        {
            if(playersList.page == 1 && playersList.pages > 0) {
                [self.list removeAllObjects];
                [self.list addObjectsFromArray:playersList.players];
                
                self.page = playersList.page;
                self.totalPages = playersList.pages;
                self.totalItems = playersList.total;
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
            if(playersList.page == self.page+1 ) {
                
                [self.list addObjectsFromArray:playersList.players];
                
                self.page = playersList.page;
                self.totalPages = playersList.pages;
                self.totalItems = playersList.total;
                
                if(playersList.page == playersList.pages) {
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
    NSLog(@"error : %@", error);
    self.apiRequest = nil;
    if([self.delegate respondsToSelector:@selector(listModelDidFailedFetch:)])
        [self.delegate listModelDidFailedFetch:self];
}

- (void)postPageError
{
    NSError* error = [NSError errorWithDomain:@"API PAge Error" code:5942 userInfo:nil];
    [self processError:error];
    
    if([self.delegate respondsToSelector:@selector(listModelDidFailedFetch:)])
        [self.delegate listModelDidFailedFetch:self];
}

@end

@implementation YLPlayerFollowingListModel


- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerFollowingWithUsername:self.player.userName page:1 successBlock:^(YLDribbbleUserList *list) {
        self.status = YLListModelUnInit;
        [self processPlayersList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
    
}

- (void)loadNextPage
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerFollowingWithUsername:self.player.userName page:self.page+1 successBlock:^(YLDribbbleUserList *list) {
        [self processPlayersList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
}

- (BOOL)isFinished
{
    return self.status == YLListModelFinish;
}

@end

@implementation YLPlayerFollowerListModel


- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerFollowerWithUsername:self.player.userName page:1 successBlock:^(YLDribbbleUserList *list) {
        self.status = YLListModelUnInit;
        [self processPlayersList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
    
}

- (void)loadNextPage
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerFollowerWithUsername:self.player.userName page:self.page+1 successBlock:^(YLDribbbleUserList *list) {
        [self processPlayersList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
}

- (BOOL)isFinished
{
    return self.status == YLListModelFinish;
}

@end


@implementation YLPlayerDrafteeListModel


- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerDrafteeWithUsername:self.player.userName page:1 successBlock:^(YLDribbbleUserList *list) {
        self.status = YLListModelUnInit;
        [self processPlayersList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
    
}

- (void)loadNextPage
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerDrafteeWithUsername:self.player.userName page:self.page+1 successBlock:^(YLDribbbleUserList *list) {
        [self processPlayersList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
}

- (BOOL)isFinished
{
    return self.status == YLListModelFinish;
}

@end