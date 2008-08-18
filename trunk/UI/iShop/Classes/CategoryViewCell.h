//
//  CategoryViewCell.h
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CategoryViewCell : UITableViewCell 
{
	IBOutlet UILabel		*name;
	IBOutlet UIImageView	*image;
	
}
@property (nonatomic, retain) UILabel		*name;
@property (nonatomic, retain) UIImageView	*image;

@end
