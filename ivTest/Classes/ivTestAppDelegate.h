//
//  ivTestAppDelegate.h
//  ivTest
//
//  Created by Anton Maryanov on 8/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ivTestAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UITabBarController *tabBarController;
	IBOutlet UITabBar *tabBar;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBar *tabBar;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
