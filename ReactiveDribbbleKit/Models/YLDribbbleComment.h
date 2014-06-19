//
//  YLDribbbleComment.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-16.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "YLDribbbleUser.h"

/*
 {
 "id": 54065,
 "body": "My response to Mr. Henry's Friday 20 minute \"moon\" design challenge.\n\nFun. Random. Rough. No clue.",
 "likes_count": 0,
 "created_at": "2010/05/21 16:36:22 -0400",
 "player": {
 "id": 1,
 "name": "Dan Cederholm",
 "username": "simplebits",
 "url": "http://dribbble.com/simplebits",
 "avatar_url": "http://dribbble.com/system/users/1/avatars/original/dancederholm-peek.jpg",
 "location": "Salem, MA",
 "twitter_screen_name": "simplebits",
 "drafted_by_player_id": null,
 "shots_count": 147,
 "draftees_count": 103,
 "followers_count": 2027,
 "following_count": 354,
 "created_at": "2009/07/07 21:51:22 -0400"
 }
 }
 */

@interface YLDribbbleComment : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSUInteger shotID;
@property (nonatomic, copy) NSString* body;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, readonly) NSDate* createDate;
@property (nonatomic, readonly) YLDribbbleUser* player;

@end

@interface YLDribbbleCommentList : YLDribbbleList
@property (nonatomic, readonly) NSArray* comments;
@end
