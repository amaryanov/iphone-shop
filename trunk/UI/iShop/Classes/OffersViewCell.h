//
//  OffersViewCell.h
//  iShop
//
//  Created by Andrey Konovalov on 9/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellView.h"

@interface OffersViewCell : BaseCellView 
{
	IBOutlet UILabel	*price;
	IBOutlet UILabel	*shipping;
	IBOutlet UILabel	*total;
	IBOutlet UIView		*ratingView;
}
@property (nonatomic, retain) UILabel	*price;
@property (nonatomic, retain) UILabel	*shipping;
@property (nonatomic, retain) UILabel	*total;
@property (nonatomic, retain) UIView	*ratingView;

-(void) setRating:(float)rating;
- (void)configureLabels;

@end
