//
//  iShopAppDelegate.m
//  iShop
//
//  Created by Andrey Konovalov on 01.08.08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "iShopAppDelegate.h"
#import "RootViewController.h"

@implementation iShopAppDelegate

@synthesize window;
@synthesize navController;
@synthesize tabController;
@synthesize rootController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
//	[rootController initWithStyle:
	[window addSubview:[tabController view]];
	// Override point for customization after app launch	
    [window makeKeyAndVisible];
}


- (void)dealloc 
{
	[navController release];
	[window release];
	[super dealloc];
}


@end
