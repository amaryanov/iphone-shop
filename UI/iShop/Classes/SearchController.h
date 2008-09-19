//
//  SearchController.h
//  iShop
//
//  Created by Andrey Konovalov on 9/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

class CSearchResult;

@interface SearchController : UIViewController
{
	IBOutlet UIActivityIndicatorView 	*indicator;
	IBOutlet UITableView 				*table;
	IBOutlet UIView 					*theView;
	
	CSearchResult						*pSearchResult;
}

@property (nonatomic, retain) UIView *theView;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

@end
