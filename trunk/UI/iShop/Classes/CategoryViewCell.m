//
//  CategoryViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
//#import "GData.h"
#import "CategoryViewCell.h"
#import "GDataHTTPFetcher.h"


@implementation CategoryViewCell
@synthesize name;
@synthesize productsCount;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}
- (void)initLabelsFont
{
//	[name setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
	[productsCount setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
//	[name setTextColor:[UIColor colorWithRed:RGB(0) green:RGB(0) blue:RGB(0) alpha:1.0]];
	[productsCount setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
}
- (void) placeProductCounts
{
	if([productsCount.text length] > 0)
	{
		CGSize nameSize = [name.text sizeWithFont:name.font];
		CGRect prodFrame = productsCount.frame;
		prodFrame.origin.x = name.frame.origin.x + nameSize.width + 2;
		if(prodFrame.origin.x < productsCount.frame.origin.x)
			productsCount.frame = prodFrame;
	}
	else
	{
		CGRect nameRect = name.frame;
		nameRect.size.width += 32.0;
		name.frame = nameRect;
	}
}

- (void)dealloc {
	[super dealloc];
}


@end
