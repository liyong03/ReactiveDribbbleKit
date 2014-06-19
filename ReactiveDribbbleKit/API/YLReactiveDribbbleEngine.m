//
//  YLReactiveDribbbleEngine.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/19/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "YLReactiveDribbbleEngine.h"
#import "YLDribbbleEngine.h"

@implementation YLReactiveDribbbleEngine

+ (RACSignal*)getPlayerWithUsername:(NSString*)username {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getPlayerWithUsername:username
                                                                       successBlock:^(YLDribbbleUser *user) {
                                                                           [subscriber sendNext:user];
                                                                           [subscriber sendCompleted];
                                                                       } failedBlock:^(NSError *error) {
                                                                           [subscriber sendError:error];
                                                                       }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

@end
