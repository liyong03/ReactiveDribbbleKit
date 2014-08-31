//
//  YLReactiveCoreDataManager.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 14-8-31.
//  Copyright (c) 2014年 Yong Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class YLDribbbleShotList;

@interface YLReactiveCoreDataManager : NSObject

+ (RACSignal*)saveShotsList:(YLDribbbleShotList*)shotsList;

@end
