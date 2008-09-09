//
//  ProductDetaiCellView.m
//  iShop
//
//  Created by Andrey Konovalov on 22.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductDescriptCellView.h"
#define RGB(x) (((float)x)/255)

@implementation ProductDescriptCellView
@synthesize descriptionLabel,details;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}
- (void)initLabelsFont
{
	[details setFont:[details.font fontWithSize:12.5]];//[UIFont systemFontOfSize:12.5]];//
	[details setTextColor:[UIColor colorWithRed:RGB(255) green:RGB(128) blue:RGB(0) alpha:1.0]];
	[descriptionLabel setFont:[descriptionLabel.font fontWithSize:12.5]];//[UIFont systemFontOfSize:12.5]];//
	[descriptionLabel setTextColor:[UIColor colorWithRed:RGB(255) green:RGB(128) blue:RGB(0) alpha:1.0]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc {
	[super dealloc];
}


@end
