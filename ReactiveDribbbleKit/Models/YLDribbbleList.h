//
//  YLDribbbleList.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-21.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface YLDribbbleList : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, assign) NSInteger total;

@property (nonatomic, copy) NSString *listName;

@end