//
//  iShopAppDelegate.h
//  iShop
//
//  Created by Andrey Konovalov on 01.08.08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iShopViewController;

@interface iShopAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
}

@property (nonatomic, retain) UIWindow *window;

@end

