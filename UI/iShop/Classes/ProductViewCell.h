//
//  ProductViewCell.h
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellView.h"

@interface ProductViewCell : BaseCellView
{
	IBOutlet UILabel *name;
	IBOutlet UILabel *description;
	IBOutlet UILabel *price;
	IBOutlet UIImageView *image;
}
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UILabel *price;
@end
