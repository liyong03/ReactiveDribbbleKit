//
//  YLDribbbleList.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-21.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLDribbbleList.h"

@implementation YLDribbbleList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"page": @"page",
             @"pages": @"pages",
             @"perPage": @"per_page",
             @"total": @"total"
             };
}

@end
