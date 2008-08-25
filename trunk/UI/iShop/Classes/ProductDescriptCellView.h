//
//  ProductDetaiCellView.h
//  iShop
//
//  Created by Andrey Konovalov on 22.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductDescriptCellView : UITableViewCell {
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
