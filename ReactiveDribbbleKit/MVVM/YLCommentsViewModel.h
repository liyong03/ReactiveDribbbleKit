//
//  YLCommentsViewModel.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/28/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveViewModel.h>
#import <ReactiveCocoa.h>

@interface YLCommentsViewModel : RVMViewModel


@property (nonatomic, copy, readonly) NSArray *comments;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *loadMoreCommand;
@property (nonatomic, readonly, getter = isLoading) BOOL loading;

+ (YLCommentsViewModel*)shotsCommentsViewModelWithShotID:(NSUInteger)shotID;

@end
