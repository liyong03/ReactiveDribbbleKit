//
//  YLDribbbleEngine.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-18.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDribbbleUser.h"
#import "YLDribbbleShot.h"
#import "YLDribbbleComment.h"
#import "YLDribbbleList.h"
#import <AFNetworking.h>


typedef void (^errorBlock)(NSError* error);
typedef void (^playerCompletionBlock)(YLDribbbleUser* user);
typedef void (^shotCompletionBlock)(YLDribbbleShot* shot);

typedef void (^listCompletionBlock)(YLDribbbleList* list);
typedef void (^playerListCompletionBlock)(YLDribbbleUserList* list);
typedef void (^shotsListCompletionBlock)(YLDribbbleShotList* list);
typedef void (^commentListCompletionBlock)(YLDribbbleCommentList* list);


@interface YLDribbbleEngine : NSObject

// player
+ (AFHTTPRequestOperation*)getPlayerWithUsername:(NSString*)username successBlock:(playerCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;

// player list
+ (AFHTTPRequestOperation*)getPlayerFollowingWithUsername:(NSString*)username page:(NSInteger)page successBlock:(playerListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;
+ (AFHTTPRequestOperation*)getPlayerFollowerWithUsername:(NSString*)username page:(NSInteger)page successBlock:(playerListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;
+ (AFHTTPRequestOperation*)getPlayerDrafteeWithUsername:(NSString*)username page:(NSInteger)page successBlock:(playerListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;


// shot
+ (AFHTTPRequestOperation*)getShotWithID:(NSUInteger)shotID successBlock:(shotCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;

// shot list
+ (AFHTTPRequestOperation*)getPlayerShotsWithUsername:(NSString*)username page:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;
+ (AFHTTPRequestOperation*)getFollowingShotsWithUsername:(NSString*)username page:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;

+ (AFHTTPRequestOperation*)getLikeShotsWithUsername:(NSString*)username page:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;

+ (AFHTTPRequestOperation*)getEveryoneShotsWithPage:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;
+ (AFHTTPRequestOperation*)getPopularShotsWithPage:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;
+ (AFHTTPRequestOperation*)getDebutsShotsWithPage:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;

// comment list
+ (AFHTTPRequestOperation*)getCommentsOfShot:(NSUInteger)shotID withPage:(NSInteger)page successBlock:(commentListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock;

@end
