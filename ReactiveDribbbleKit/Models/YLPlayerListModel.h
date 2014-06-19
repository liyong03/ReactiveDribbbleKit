//
//  YLPlayerListModel.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-25.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLListModel.h"
#import "YLDribbbleEngine.h"

@interface YLPlayerListModel : YLListModel
@property (nonatomic, strong) YLDribbbleUser* player;

- (void)processPlayersList:(YLDribbbleUserList*)playersList;
- (void)processError:(NSError*)error;

@end

@interface YLPlayerFollowingListModel : YLPlayerListModel
@end


@interface YLPlayerFollowerListModel : YLPlayerListModel
@end


@interface YLPlayerDrafteeListModel : YLPlayerListModel
@end
