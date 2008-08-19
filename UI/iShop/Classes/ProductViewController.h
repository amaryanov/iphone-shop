//
//  ProductViewController.h
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

class CProductListContainer;
@interface ProductViewController : UIViewController
{
	CProductListContainer	*pProducts;
	int						categoryId;
}
@property(readwrite) int categoryId;
@end
