//
//  RootViewController.h
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
class CCategories;
@class NSCondition;
@interface CategoryViewController : UIViewController 
{
	IBOutlet UIView *theView;
	IBOutlet UITableView *table;
	IBOutlet UIActivityIndicatorView *indicator;

	CCategories *pCategs;
	NSCondition *cond;
}
@property (nonatomic, retain) UIView *theView;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

@end
