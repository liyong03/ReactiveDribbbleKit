//
//  YLDribbbleShot.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-16.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "YLDribbbleUser.h"

@interface YLDribbbleShot : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, assign) NSUInteger shotID;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) NSURL* shortURL;
@property (nonatomic, strong) NSURL* imageURL;
@property (nonatomic, strong) NSURL* imageTeaserURL;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger viewsCount;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger reboundsCount;
@property (nonatomic, strong) NSNumber* reboundSourceID;
@property (nonatomic, readonly) NSDate* createDate;
@property (nonatomic, readonly) YLDribbbleUser* player;

@end

@interface YLDribbbleShotList : YLDribbbleList
@property (nonatomic, readonly) NSArray* shots;
@end