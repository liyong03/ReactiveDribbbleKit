//
//  AppDelegate.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/19/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "AppDelegate.h"
#import "PlayersTableViewController.h"
#import "ShotsViewController.h"
#import "LoginViewController.h"
#import "YLAccountManager.h"
#import "YLDribbbleCoreDataManager.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [SDWebImageManager sharedManager].imageDownloader.maxConcurrentDownloads = 10;
    [[YLDribbbleCoreDataManager sharedManager] setUp];
    
    
    LoginViewController* login = [LoginViewController showLoginViewWithFinishHandler:^{
        
        //PlayersTableViewController* playersVC = [[PlayersTableViewController alloc] initWithStyle:UITableViewStylePlain];
        ShotsViewController* currentPlayerShotsVC = [ShotsViewController playerShotsViewControllerOfPlayer:[YLAccountManager sharedManager].currentPlayer];
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:currentPlayerShotsVC];
        navi.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
        ShotsViewController* popularShotsVC = [ShotsViewController popularShotsViewController];
        UINavigationController* navi2 = [[UINavigationController alloc] initWithRootViewController:popularShotsVC];
        navi2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
        UITabBarController* tabbar = [[UITabBarController alloc] init];
        [tabbar addChildViewController:navi];
        [tabbar addChildViewController:navi2];
        
        self.window.rootViewController = tabbar;
    }];
    
    if (login) {
        self.window.rootViewController = login;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
