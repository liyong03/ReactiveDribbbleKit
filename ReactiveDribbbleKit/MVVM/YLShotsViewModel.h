//
//  YLShotsViewModel.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/26/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveViewModel.h>
#import <ReactiveCocoa.h>
#import "YLDribbbleUser.h"

@interface YLShotsViewModel : RVMViewModel

@property (nonatomic, copy, readonly) NSArray *shots;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *loadMoreCommand;
@property (nonatomic, readonly, getter = isLoading) BOOL loading;

+ (YLShotsViewModel*)followShotsViewModelOfPlayer:(YLDribbbleUser*)player;
+ (YLShotsViewModel*)playerShotsViewModelOfPlayer:(YLDribbbleUser*)player;
+ (YLShotsViewModel*)playerLikeShotsViewModelOfPlayer:(YLDribbbleUser*)player;

@end
