//
//  ProductDetaiCellView.h
//  iShop
//
//  Created by Andrey Konovalov on 22.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductDescriptCellView : UITableViewCell {
	IBOutlet UILabel	*descriptionLabel;
	IBOutlet UILabel	*details;
}
@property (nonatomic, retain) UILabel	*details;
@property (nonatomic, retain) UILabel	*descriptionLabel;

- (void)initLabelsFont;
@end
