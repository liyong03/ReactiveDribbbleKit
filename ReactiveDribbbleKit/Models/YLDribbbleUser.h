//
//  YLDribbbleUser.h
//  Dribbb7e
//
//  Created by Yong Li on 13-11-30.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

#import "YLDribbbleList.h"

@interface YLDribbbleUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* realName;
@property (nonatomic, copy) NSString* location;
@property (nonatomic, copy) NSString* twitterID;
@property (nonatomic, strong) NSURL* avatarURL;
@property (nonatomic, strong) NSURL* websiteURL;
@property (nonatomic, assign) int shotsCount;
@property (nonatomic, assign) int drafteesCount;
@property (nonatomic, assign) int followerCount;
@property (nonatomic, assign) int followingCount;
@property (nonatomic, assign) int commentsCount;
@property (nonatomic, assign) int commentsReceivedCount;
@property (nonatomic, assign) int likesCount;
@property (nonatomic, assign) int likesReceivedCount;
@property (nonatomic, assign) int reboundsCount;
@property (nonatomic, assign) int reboundsReceivedCount;
@property (nonatomic, readonly) NSDate* createDate;

@end

@interface YLDribbbleUserList : YLDribbbleList
@property (nonatomic, readonly) NSArray* players;
@end
