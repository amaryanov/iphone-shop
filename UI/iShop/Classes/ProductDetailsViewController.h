//
//  ProductDetailsViewCotroller.h
//  iShop
//
//  Created by Andrey Konovalov on 20.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

class CProductDataContainer;
@class ProductDetailCellView;
@interface ProductDetailsViewController : UIViewController {
	int productId;
	CProductDataContainer *pProdData;
	IBOutlet ProductDetailCellView *firstCell;
	IBOutlet UITableViewCell *secondCell;
	IBOutlet UITableViewCell *buttonsCell;
}
@property(readwrite) int productId;
@property(retain, nonatomic) ProductDetailCellView *firstCell;
@property(retain, nonatomic) UITableViewCell *secondCell;
@property(retain, nonatomic) UITableViewCell *buttonsCell;

@end
