//
//  iShopAppDelegate.h
//  iShop
//
//  Created by Anton Maryanov on 8/4/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductViewController;
@interface iShopAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UITabBarController *tabBarController;
	IBOutlet UINavigationController *navController;
	IBOutlet UITabBar *tabBar;
	IBOutlet ProductViewController *populars;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) UITabBar *tabBar;
@property (nonatomic, retain) ProductViewController *populars;
+(iShopAppDelegate*)MainDelegate;

@end

static iShopAppDelegate *mainDelegate;
