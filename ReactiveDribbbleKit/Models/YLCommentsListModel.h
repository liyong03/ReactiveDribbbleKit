//
//  YLCommentsListModel.h
//  Dribbb7e
//
//  Created by Yong Li on 14-1-14.
//  Copyright (c) 2014年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLListModel.h"
#import "YLDribbbleEngine.h"

@interface YLCommentsListModel : YLListModel
@property (nonatomic, strong) YLDribbbleShot* shot;
@end
