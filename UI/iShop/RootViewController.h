//
//  RootViewController.h
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController {
	IBOutlet UITableView *myDinamicalyTable;
}
@property (nonatomic, retain) UITableView *myDinamicalyTable;

@end
