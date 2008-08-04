//
//  ViewControllerWithNav.h
//  iShop
//
//  Created by Anton Maryanov on 8/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewControllerWithNav : UIViewController {
	IBOutlet UINavigationController *navController;

}

@property(nonatomic, retain) UINavigationController *navController;

@end
