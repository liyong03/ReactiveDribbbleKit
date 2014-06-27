//
//  ShotsViewController.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/27/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDribbbleUser.h"

@interface ShotsViewController : UICollectionViewController

+ (ShotsViewController*)playerShotsViewControllerOfPlayer:(YLDribbbleUser*)player;

@end
