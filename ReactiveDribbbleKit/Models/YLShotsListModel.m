//
//  YLShotsListModel.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-25.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLShotsListModel.h"
#import "YLDribbbleEngine.h"

@interface YLShotsListModel()
@end

@implementation YLShotsListModel
{
    NSMutableDictionary* _existSet;
}

- (void)processShotsList:(YLDribbbleShotList*)shotsList
{
    self.apiRequest = nil;
    switch (self.status) {
        case YLListModelUnInit:
        {
            if(shotsList.page == 1 && shotsList.pages > 0) {
                [self.list removeAllObjects];
                _existSet = [NSMutableDictionary dictionary];
                [shotsList.shots enumerateObjectsUsingBlock:^(YLDribbbleShot* shot, NSUInteger idx, BOOL *stop) {
                    _existSet[[NSString stringWithFormat:@"%lu", shot.shotID]] = shot;
                    [self.list addObject:shot];
                }];
                
                self.page = shotsList.page;
                self.totalPages = shotsList.pages;
                self.totalItems = shotsList.total;
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
            if(shotsList.page == self.page+1 ) {
                
                [shotsList.shots enumerateObjectsUsingBlock:^(YLDribbbleShot* shot, NSUInteger idx, BOOL *stop) {
                    NSString* key = [NSString stringWithFormat:@"%lu", shot.shotID];
                    _existSet[key] = shot;
                    [self.list addObject:shot];
                }];
                self.page = shotsList.page;
                self.totalPages = shotsList.pages;
                self.totalItems = shotsList.total;
                
                if(shotsList.page == shotsList.pages) {
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

#pragma mark - YLPopularShotsListModel

@implementation YLPopularShotsListModel

- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPopularShotsWithPage:1 successBlock:^(YLDribbbleShotList *list) {
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
    self.apiRequest = [YLDribbbleEngine getPopularShotsWithPage:self.page+1 successBlock:^(YLDribbbleShotList *list) {
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


#pragma mark - YLEveryoneShotsListModel

@implementation YLEveryoneShotsListModel

- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getEveryoneShotsWithPage:1 successBlock:^(YLDribbbleShotList *list) {
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
    self.apiRequest = [YLDribbbleEngine getEveryoneShotsWithPage:self.page+1 successBlock:^(YLDribbbleShotList *list) {
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


#pragma mark - YLDebutShotsListModel

@implementation YLDebutShotsListModel

- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getDebutsShotsWithPage:1 successBlock:^(YLDribbbleShotList *list) {
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
    self.apiRequest = [YLDribbbleEngine getDebutsShotsWithPage:self.page+1 successBlock:^(YLDribbbleShotList *list) {
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

#pragma mark - YLFollowShotsListModel

@implementation YLFollowShotsListModel

- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getFollowingShotsWithUsername:self.player.userName page:1 successBlock:^(YLDribbbleShotList *list) {
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
    self.apiRequest = [YLDribbbleEngine getFollowingShotsWithUsername:self.player.userName page:self.page+1 successBlock:^(YLDribbbleShotList *list) {
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

#pragma mark - YLPlayerShotsListModel

@implementation YLPlayerShotsListModel

- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getPlayerShotsWithUsername:self.player.userName page:1 successBlock:^(YLDribbbleShotList *list) {
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
    self.apiRequest = [YLDribbbleEngine getPlayerShotsWithUsername:self.player.userName page:self.page+1 successBlock:^(YLDribbbleShotList *list) {
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

#pragma mark - YLPlayerLikeShotsListModel

@implementation YLPlayerLikeShotsListModel

- (void)refresh
{
    if(self.apiRequest && !self.apiRequest.isFinished)
        return;
    self.apiRequest = [YLDribbbleEngine getLikeShotsWithUsername:self.player.userName page:1 successBlock:^(YLDribbbleShotList *list) {
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
    self.apiRequest = [YLDribbbleEngine getLikeShotsWithUsername:self.player.userName page:self.page+1 successBlock:^(YLDribbbleShotList *list) {
        [self processShotsList:list];
    } failedBlock:^(NSError *error) {
        [self processError:error];
    }];
}

- (BOOL)isFinished
{
    return self.status == YLListModelFinish;
}

- (void)dealloc
{
    NSLog(@"model dealloc");
}

@end
