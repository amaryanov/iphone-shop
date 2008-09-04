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
	IBOutlet UIView			*rangView;
	IBOutlet UIImageView	*prodImg;
	IBOutlet UILabel 		*highlight1;
	IBOutlet UILabel 		*highlight2;
}
@property (nonatomic, retain)  UILabel		*name;
@property (nonatomic, retain)  UIView		*rangView;
//@property (nonatomic, retain)  UITextView	*description;
@property (nonatomic, retain)  UIImageView	*prodImg;
@property (nonatomic, retain)  UILabel 		*highlight1;
@property (nonatomic, retain)  UILabel 		*highlight2;

- (void)initLabelsFont;
@end
