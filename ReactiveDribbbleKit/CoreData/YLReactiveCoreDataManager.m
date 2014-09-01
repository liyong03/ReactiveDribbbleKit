//
//  YLReactiveCoreDataManager.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 14-8-31.
//  Copyright (c) 2014年 Yong Li. All rights reserved.
//

#import "YLReactiveCoreDataManager.h"
#import "YLDribbbleShot.h"
#import "YLDribbbleCoreDataManager.h"
#import <ReactiveCocoa.h>

@implementation YLReactiveCoreDataManager

+ (RACSignal*)saveShotsList:(YLDribbbleShotList*)shotsList {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[YLDribbbleCoreDataManager sharedManager] performBackgroundBlockAndWait:^(NSManagedObjectContext *context) {
            NSError *insertError = nil;
            NSManagedObject *mob = [MTLManagedObjectAdapter managedObjectFromModel:shotsList
                                                              insertingIntoContext:context
                                                                             error:&insertError];
            if (insertError) {
                [subscriber sendError:insertError];
            } else {
                [subscriber sendNext:mob];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }] publish] autoconnect];
}

+ (RACSignal*)loadShotsListWithName:(NSString*)listName {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[YLDribbbleCoreDataManager sharedManager] performMainContextBlock:^(NSManagedObjectContext *context) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"DribbbleShotList"];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"listName==%@", listName];
            NSError* error;
            NSArray *cachedLists = [context executeFetchRequest:fetchRequest error:&error];
            if (!error) {
                NSManagedObject *mob = cachedLists.firstObject;
                YLDribbbleShotList *shotList = [MTLManagedObjectAdapter modelOfClass:[YLDribbbleShotList class] fromManagedObject:mob error:&error];
                if (!error) {
                    [subscriber sendNext:shotList];
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:error];
                }
            }
            else {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }] replay];
}

@end
