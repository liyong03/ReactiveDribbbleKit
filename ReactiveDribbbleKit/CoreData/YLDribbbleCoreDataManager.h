//
//  YLDribbbleCoreDataManager.h
//  ReactiveDribbbleKit
//
//  Created by Yong Li on 8/17/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DribbbleCoreDataControllerBlock)(NSManagedObjectContext *context);

@interface YLDribbbleCoreDataManager : NSObject

+ (YLDribbbleCoreDataManager*)sharedManager;


- (void)setUp;

/**
 *  Provides a block with a private queue context and performs the block on the aforementioned queue, synchronously.
 *  Saves the context (and any ancestor contexts, recursively) afterwards.
 *
 *  @param block Block provided with a private queue context and performed on the aforementioned queue.
 */
- (void)performBackgroundBlockAndWait:(DribbbleCoreDataControllerBlock)block;

/**
 *  Provides a block with the main queue context and performs the block on the main queue, synchronously.
 *  Saves the context (and any ancestor contexts, recursively) afterwards.
 *
 *  @param block Block provided with the main queue context and performed on the main queue.
 */
- (void)performMainContextBlock:(DribbbleCoreDataControllerBlock)block;


@end
