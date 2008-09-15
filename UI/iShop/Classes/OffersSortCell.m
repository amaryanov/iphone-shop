//
//  FirstCellForSort.m
//  iShop
//
//  Created by Andrey Konovalov on 9/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OffersSortCell.h"

#ifndef RGB
	#define RGB(x) (((float)x)/255)
#endif

@implementation OffersSortCell
@synthesize label,staticLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}
-(void) initLabelsFont
{
	[label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
	[label setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];

	[staticLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
	[staticLabel setTextColor:[UIColor colorWithRed:RGB(0) green:RGB(0) blue:RGB(0) alpha:1.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc 
{
	[super dealloc];
}


@end
