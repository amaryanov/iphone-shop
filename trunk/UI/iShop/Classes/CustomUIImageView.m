//
//  CustomUIImageView.m
//  ivTest
//
//  Created by Anton Maryanov on 8/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CustomUIImageView.h"


@implementation CustomUIImageView
@synthesize cntrl;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[cntrl PlayBtnTouchInside:nil];
}

- (void)drawRect:(CGRect)rect {
	// Drawing code
}


- (void)dealloc {
	[super dealloc];
	[cntrl release];
}


@end
