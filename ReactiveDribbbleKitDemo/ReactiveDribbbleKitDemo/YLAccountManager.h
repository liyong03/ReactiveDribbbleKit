//
//  YLAccountManager.h
//  Dribbb7e
//
//  Created by Yong Li on 14-1-21.
//  Copyright (c) 2014年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDribbbleEngine.h"
#import "YLReactiveDribbbleEngine.h"
#import <ReactiveCocoa.h>

typedef void (^YLAccountFetchPlayerBlock)(YLDribbbleUser* player, NSError* error);

@interface YLAccountManager : NSObject<NSCoding>

@property (nonatomic, strong) YLDribbbleUser* currentPlayer;
@property (nonatomic, assign) BOOL isContinue;

+ (YLAccountManager*)sharedManager;

- (RACSignal*)loginWithUser:(NSString*)username;
- (RACSignal*)logout;

@end
