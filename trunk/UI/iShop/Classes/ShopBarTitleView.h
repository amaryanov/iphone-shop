//
//  ShopBarTitle.h
//  iShop
//
//  Created by Andrey Konovalov on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShopBarTitleView : UIView 
{
	IBOutlet UILabel *label;
	IBOutlet UIActivityIndicatorView *indicator;
}
@property (nonatomic, retain) UILabel					*label;
@property (nonatomic, retain) UIActivityIndicatorView	*indicator;
-(void) setTitle:(NSString*)title;
@end
