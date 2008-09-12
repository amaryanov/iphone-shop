//
//  LoadMoreViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 9/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LoadMoreViewCell.h"

#define RGB(x) (((float)x)/255)

@implementation LoadMoreViewCell
@synthesize label,indicator;
@synthesize secondLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

- (void)initLabelsFont
{
	[label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
	[secondLabel setFont:[UIFont fontWithName:@"ArialMT" size:11.5]];
	[label setTextColor:[UIColor colorWithRed:RGB(35) green:RGB(110) blue:RGB(216) alpha:1.0]];
	[secondLabel setTextColor:[UIColor colorWithRed:RGB(105) green:RGB(105) blue:RGB(105) alpha:1.0]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc {
	[super dealloc];
}


@end
