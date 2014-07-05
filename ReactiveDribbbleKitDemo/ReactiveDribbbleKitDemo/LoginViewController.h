//
//  LoginViewController.h
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 7/5/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

+ (LoginViewController*)showLoginViewWithFinishHandler:(void(^)())completionBlock;

@end
