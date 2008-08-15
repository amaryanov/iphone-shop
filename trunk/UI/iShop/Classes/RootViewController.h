//
//  RootViewController.h
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
class CCategories;
@interface RootViewController : UIViewController {
	IBOutlet UITableView *myDinamicalyTable;
	CCategories *pCategs;
}
@property (nonatomic, retain) UITableView *myDinamicalyTable;

@end
