//
//  YLListModel.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-25.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


typedef enum {
    YLListModelUnInit,
    YLListModelDownloading,
    YLListModelFinish,
} YLListModelStatus;

@class YLListModel;

@protocol YLListModelDelegate <NSObject>

- (void)listModelDidBeginFetch:(YLListModel*)model;
- (void)listModelDidFinishFetch:(YLListModel*)model;
- (void)listModelDidFailedFetch:(YLListModel*)model;

@end

@interface YLListModel : NSObject

@property (nonatomic, assign) YLListModelStatus status;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger totalPages;
@property (nonatomic, assign) NSUInteger totalItems;
@property (nonatomic, weak) id<YLListModelDelegate> delegate;
@property (nonatomic, strong) NSMutableArray* list;
@property (nonatomic, strong) AFHTTPRequestOperation* apiRequest;

- (void)refresh;
- (void)loadNextPage;
- (BOOL)isFinished;

@end
