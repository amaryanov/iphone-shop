//
//  ProductDetailsViewCotroller.h
//  iShop
//
//  Created by Andrey Konovalov on 20.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

class CProductDataContainer;
@interface ProductDetailsViewController : UIViewController {
	int productId;
	CProductDataContainer *pProdData;
	IBOutlet UITableViewCell *firstCell;
	IBOutlet UITableViewCell *secondCell;
	IBOutlet UITableViewCell *buttonsCell;
}
@property(readwrite) int productId;
@property(retain, nonatomic) UITableViewCell *firstCell;
@property(retain, nonatomic) UITableViewCell *secondCell;
@property(retain, nonatomic) UITableViewCell *buttonsCell;

@end
