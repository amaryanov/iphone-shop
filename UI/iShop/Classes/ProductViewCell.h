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
	IBOutlet UILabel	*name;
	IBOutlet UILabel	*highlight1;
	IBOutlet UILabel 	*highlight2;
	IBOutlet UILabel	*price;
	IBOutlet UIImageView *image;
	int iter;
}
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *highlight1;
@property (nonatomic, retain) UILabel *highlight2;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *price;

- (void)initLabelsFont;

@end
