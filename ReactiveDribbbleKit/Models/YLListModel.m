//
//  YLListModel.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-25.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLListModel.h"

@implementation YLListModel

- (id)init
{
    self = [super init];
    if (self) {
        _status = YLListModelUnInit;
        _page = -1;
        _totalItems = -1;
        _totalPages = -1;
        _list = [NSMutableArray array];
    }
    return self;
}

- (void)refresh
{
    
}

- (void)loadNextPage
{
    
}

- (BOOL)isFinished
{
    return NO;
}

@end
