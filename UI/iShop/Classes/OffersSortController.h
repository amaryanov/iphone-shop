//
//  OffersSortController.h
//  iShop
//
//  Created by Andrey Konovalov on 9/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OffersTable;
@interface OffersSortController : UIViewController 
{
	int selectedRow;
	OffersTable * tableDelegate;
}
@property (assign,readwrite) OffersTable * tableDelegate;
@property (assign,readwrite) int selectedRow;
@end
