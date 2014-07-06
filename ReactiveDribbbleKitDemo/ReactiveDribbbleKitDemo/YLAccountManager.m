//
//  YLAccountManager.m
//  Dribbb7e
//
//  Created by Yong Li on 14-1-21.
//  Copyright (c) 2014年 YongLi. All rights reserved.
//

#import "YLAccountManager.h"

@implementation YLAccountManager

YLAccountManager* _sharedManager = nil;

+ (YLAccountManager*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self loadManager];
        if(!_sharedManager)
            _sharedManager = [[YLAccountManager alloc] init];
    });
    return _sharedManager;
}

+ (void)saveManager:(YLAccountManager*)manager
{
    if(manager) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:manager];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SharedManager"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SharedManager"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (YLAccountManager*)loadManager
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"SharedManager"];
    if(data) {
        YLAccountManager* manager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return manager;
    }
    return nil;
}

+ (void)removeManager
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SharedManager"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isContinue = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        _currentPlayer = [decoder decodeObjectForKey:@"currentPlayer"];
        _isContinue = [decoder decodeBoolForKey:@"isContinue"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.currentPlayer)
        [aCoder encodeObject:self.currentPlayer forKey:@"currentPlayer"];
    [aCoder encodeBool:self.isContinue forKey:@"isContinue"];
}

- (void)setIsContinue:(BOOL)isContinue
{
    if(_isContinue != isContinue) {
        _isContinue = isContinue;
        [YLAccountManager saveManager:[YLAccountManager sharedManager]];
    }
}


- (RACSignal*)loginWithUser:(NSString*)username
{
    return [[YLReactiveDribbbleEngine getPlayerWithUsername:username] doNext:^(YLDribbbleUser *player) {
        self.currentPlayer = player;
        [YLAccountManager saveManager:[YLAccountManager sharedManager]];
    }];
}

- (RACSignal*)logout
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        self.currentPlayer = nil;
        self.isContinue = NO;
        [YLAccountManager saveManager:[YLAccountManager sharedManager]];
        [subscriber sendCompleted];
        return nil;
    }];
}
@end
