//
//  shopDetailViewController.h
//  iShop
//
//  Created by Andrey Konovalov on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopBarTitleView;
@interface ShopDetailViewController : UIViewController <UIWebViewDelegate> 
{
	IBOutlet UIWebView *web;
	IBOutlet ShopBarTitleView *titleView;
	NSString *url;
	NSString *name;
}
@property(retain, nonatomic) UIWebView *web;
@property(retain, nonatomic) ShopBarTitleView *titleView;
@property(retain, nonatomic) NSString *url;
@property(retain, nonatomic) NSString *name;
@end
