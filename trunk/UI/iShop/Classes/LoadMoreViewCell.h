//
//  LoadMoreViewCell.h
//  iShop
//
//  Created by Andrey Konovalov on 9/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadMoreViewCell : UITableViewCell {
	IBOutlet UILabel 					*label;
	IBOutlet UILabel 					*secondLabel;
	IBOutlet UIActivityIndicatorView 	*indicator;
}
@property (nonatomic, retain) UILabel					*label;
@property (nonatomic, retain) UILabel					*secondLabel;
@property (nonatomic, retain) UIActivityIndicatorView	*indicator;

- (void)initLabelsFont;

@end
