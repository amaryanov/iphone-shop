//
//  ShopBarTitle.m
//  iShop
//
//  Created by Andrey Konovalov on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ShopBarTitleView.h"


@implementation ShopBarTitleView

@synthesize label,indicator;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}

-(void) setTitle:(NSString*)title
{
	[label setText:title];
	CGSize labelSize = [label.text sizeWithFont:label.font];
	CGRect indicatorFrame = indicator.frame;
	indicatorFrame.origin.x = label.frame.origin.x + labelSize.width + 10;
	if(indicatorFrame.origin.x < indicator.frame.origin.x)
		indicator.frame = indicatorFrame;
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
}


- (void)dealloc {
	[super dealloc];
}


@end
