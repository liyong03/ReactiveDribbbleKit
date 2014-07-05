//
//  YLDribbbleLoginViewModel.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 7/5/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "RVMViewModel.h"
#import <ReactiveViewModel.h>
#import <ReactiveCocoa.h>

@interface YLDribbbleLoginViewModel : RVMViewModel

@property (nonatomic, readonly) RACCommand *loginCommand;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, readonly, getter = isLoading) BOOL loading;

@end
