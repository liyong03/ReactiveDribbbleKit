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

+ (RACSignal*)getPlayerWithUsername:(NSString*)username;

@end
