//
//  YLDribbbleLoginViewModel.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 7/5/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "YLDribbbleLoginViewModel.h"
#import "YLAccountManager.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface YLDribbbleLoginViewModel()

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@end

@implementation YLDribbbleLoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self)
        _loginCommand =[[RACCommand alloc] initWithEnabled:[self isEnableLogin] signalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[YLAccountManager sharedManager] loginWithUser:self.username];
        }];
        
        RAC(self, loading) = _loginCommand.executing;
    }
    return self;
}

- (RACSignal*)isEnableLogin {
    return [RACObserve(self, username) map:^id(NSString* name) {
        if (name.length) {
            return @(YES);
        } else {
            return @(NO);
        }
    }];
}

@end
