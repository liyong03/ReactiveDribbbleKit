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
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
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
    }] publish] autoconnect];
}

+ (RACSignal*)getPlayerFollowingWithUsername:(NSString*)username page:(NSInteger)page {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getPlayerFollowingWithUsername:username page:page
                                                                                successBlock:^(YLDribbbleUserList *list) {
                                                                                    [subscriber sendNext:list];
                                                                                    [subscriber sendCompleted];
                                                                                } failedBlock:^(NSError *error) {
                                                                                    [subscriber sendError:error];
                                                                                }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
}
+ (RACSignal*)getPlayerFollowerWithUsername:(NSString*)username page:(NSInteger)page {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getPlayerFollowerWithUsername:username page:page
                                                                               successBlock:^(YLDribbbleUserList *list) {
                                                                                   [subscriber sendNext:list];
                                                                                   [subscriber sendCompleted];
                                                                               } failedBlock:^(NSError *error) {
                                                                                   [subscriber sendError:error];
                                                                               }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
}
+ (RACSignal*)getPlayerDrafteeWithUsername:(NSString*)username page:(NSInteger)page {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getPlayerDrafteeWithUsername:username page:page
                                                                              successBlock:^(YLDribbbleUserList *list) {
                                                                                  [subscriber sendNext:list];
                                                                                  [subscriber sendCompleted];
                                                                              } failedBlock:^(NSError *error) {
                                                                                  [subscriber sendError:error];
                                                                              }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
}


// shot
+ (RACSignal*)getShotWithID:(NSUInteger)shotID {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getShotWithID:shotID
                                                               successBlock:^(YLDribbbleShot *shot) {
                                                                   [subscriber sendNext:shot];
                                                                   [subscriber sendCompleted];
                                                               } failedBlock:^(NSError *error) {
                                                                   [subscriber sendError:error];
                                                               }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
}

// shot list
+ (RACSignal*)getPlayerShotsWithUsername:(NSString*)username page:(NSInteger)page {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getPlayerShotsWithUsername:username page:page
                                                                            successBlock:^(YLDribbbleShotList *list) {
                                                                                [subscriber sendNext:list];
                                                                                [subscriber sendCompleted];
                                                                            } failedBlock:^(NSError *error) {
                                                                                [subscriber sendError:error];
                                                                            }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
}
+ (RACSignal*)getFollowingShotsWithUsername:(NSString*)username page:(NSInteger)page {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getFollowingShotsWithUsername:username page:page
                                                                               successBlock:^(YLDribbbleShotList *list) {
                                                                                   [subscriber sendNext:list];
                                                                                   [subscriber sendCompleted];
                                                                               } failedBlock:^(NSError *error) {
                                                                                   [subscriber sendError:error];
                                                                               }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
    
}

+ (RACSignal*)getLikeShotsWithUsername:(NSString*)username page:(NSInteger)page {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getLikeShotsWithUsername:username page:page
                                                                          successBlock:^(YLDribbbleShotList *list) {
                                                                              [subscriber sendNext:list];
                                                                              [subscriber sendCompleted];
                                                                          } failedBlock:^(NSError *error) {
                                                                              [subscriber sendError:error];
                                                                          }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
    
}

+ (RACSignal*)getEveryoneShotsWithPage:(NSInteger)page {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getEveryoneShotsWithPage:page
                                                                          successBlock:^(YLDribbbleShotList *list) {
                                                                              [subscriber sendNext:list];
                                                                              [subscriber sendCompleted];
                                                                          } failedBlock:^(NSError *error) {
                                                                              [subscriber sendError:error];
                                                                          }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
    
}
+ (RACSignal*)getPopularShotsWithPage:(NSInteger)page {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getPopularShotsWithPage:page
                                                                         successBlock:^(YLDribbbleShotList *list) {
                                                                             [subscriber sendNext:list];
                                                                             [subscriber sendCompleted];
                                                                         } failedBlock:^(NSError *error) {
                                                                             [subscriber sendError:error];
                                                                         }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
    
}
+ (RACSignal*)getDebutsShotsWithPage:(NSInteger)page {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getDebutsShotsWithPage:page
                                                                        successBlock:^(YLDribbbleShotList *list) {
                                                                            [subscriber sendNext:list];
                                                                            [subscriber sendCompleted];
                                                                        } failedBlock:^(NSError *error) {
                                                                            [subscriber sendError:error];
                                                                        }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
    
}

// comment list
+ (RACSignal*)getCommentsOfShot:(NSUInteger)shotID withPage:(NSInteger)page {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation* operation = [YLDribbbleEngine getCommentsOfShot:shotID withPage:page
                                                                   successBlock:^(YLDribbbleCommentList *list) {
                                                                       [subscriber sendNext:list];
                                                                       [subscriber sendCompleted];
                                                                   } failedBlock:^(NSError *error) {
                                                                       [subscriber sendError:error];
                                                                   }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] publish] autoconnect];
}

@end
