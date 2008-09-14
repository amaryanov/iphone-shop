//
//  FirstCellForSort.h
//  iShop
//
//  Created by Andrey Konovalov on 9/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OffersSortCell : UITableViewCell 
{
	IBOutlet UILabel *staticLabel;
	IBOutlet UILabel *label;
}

@property (nonatomic, retain) UILabel	*label;
@property (nonatomic, retain) UILabel	*staticLabel;
-(void) initLabelsFont;

@end
