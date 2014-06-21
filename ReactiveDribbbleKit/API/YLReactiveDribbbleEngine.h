//
//  YLReactiveDribbbleEngine.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/19/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface YLReactiveDribbbleEngine : NSObject

// player
+ (RACSignal*)getPlayerWithUsername:(NSString*)username;


// player list
+ (RACSignal*)getPlayerFollowingWithUsername:(NSString*)username page:(NSInteger)page;
+ (RACSignal*)getPlayerFollowerWithUsername:(NSString*)username page:(NSInteger)page;
+ (RACSignal*)getPlayerDrafteeWithUsername:(NSString*)username page:(NSInteger)page;

// shot
+ (RACSignal*)getShotWithID:(NSUInteger)shotID;

// shot list
+ (RACSignal*)getPlayerShotsWithUsername:(NSString*)username page:(NSInteger)page;
+ (RACSignal*)getFollowingShotsWithUsername:(NSString*)username page:(NSInteger)page;

+ (RACSignal*)getLikeShotsWithUsername:(NSString*)username page:(NSInteger)page;

+ (RACSignal*)getEveryoneShotsWithPage:(NSInteger)page;
+ (RACSignal*)getPopularShotsWithPage:(NSInteger)page;
+ (RACSignal*)getDebutsShotsWithPage:(NSInteger)page;

// comment list
+ (RACSignal*)getCommentsOfShot:(NSUInteger)shotID withPage:(NSInteger)page;


@end
