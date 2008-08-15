//
//  iShopAppDelegate.h
//  iShop
//
//  Created by Andrey Konovalov on 01.08.08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface iShopAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navController;
	IBOutlet UITabBarController *tabController;
	IBOutlet RootViewController *rootController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) UITabBarController *tabController;
@property (nonatomic, retain) RootViewController *rootController;

@end

