//
//  YLShotsListModel.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-25.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLListModel.h"
#import "YLDribbbleEngine.h"

@interface YLShotsListModel : YLListModel

- (void)processShotsList:(YLDribbbleShotList*)shotsList;
- (void)processError:(NSError*)error;

@end

@interface YLPopularShotsListModel : YLShotsListModel

@end

@interface YLEveryoneShotsListModel : YLShotsListModel

@end

@interface YLDebutShotsListModel : YLShotsListModel

@end

@interface YLFollowShotsListModel : YLShotsListModel
@property (nonatomic, strong) YLDribbbleUser* player;

@end

@interface YLPlayerShotsListModel : YLShotsListModel
@property (nonatomic, strong) YLDribbbleUser* player;
@end

@interface YLPlayerLikeShotsListModel : YLShotsListModel
@property (nonatomic, strong) YLDribbbleUser* player;
@end
