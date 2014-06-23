//
//  YLPlayersViewModel.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/22/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveViewModel.h>
#import <ReactiveCocoa.h>

@interface YLPlayersViewModel : RVMViewModel

@property (nonatomic, copy, readonly) NSArray *players;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *loadMoreCommand;
@property (nonatomic, readonly, getter = isLoading) BOOL loading;

+ (YLPlayersViewModel*)playerFollowingViewModelWithName:(NSString*)name;
+ (YLPlayersViewModel*)playerFollowerViewModelWithName:(NSString*)name;
+ (YLPlayersViewModel*)playerDrafteeViewModelWithName:(NSString*)name;

@end
