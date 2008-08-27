//
//  ProductDetailCellView.h
//  iShop
//
//  Created by Andrey Konovalov on 8/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellView.h"


@interface ProductDetailCellView : BaseCellView
{
	IBOutlet UILabel		*name;
	IBOutlet UILabel		*rang;
	IBOutlet UITextView		*description;
	IBOutlet UIImageView	*prodImg;
}
@property (nonatomic, retain)  UILabel		*name;
@property (nonatomic, retain)  UILabel		*rang;
@property (nonatomic, retain)  UITextView	*description;
@property (nonatomic, retain)  UIImageView	*prodImg;

@end
