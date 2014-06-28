//
//  CommentsViewController.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/28/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLDribbbleShot;
@interface CommentsViewController : UITableViewController

+ (CommentsViewController*)commentsViewControllerOfShot:(YLDribbbleShot*)shot;

@end
