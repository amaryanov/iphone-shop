//
//  ProductDetailCellView.m
//  iShop
//
//  Created by Andrey Konovalov on 8/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailCellView.h"
#import "GDataHTTPFetcher.h"


@implementation ProductDetailCellView
@synthesize name;
@synthesize rangView;
@synthesize highlight1;
@synthesize highlight2;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

- (void)initLabelsFont
{
	[name setFont:[name.font fontWithSize:16.5]];
	[highlight1 setFont:[highlight1.font fontWithSize:15]];
	[highlight2 setFont:[highlight2.font fontWithSize:15]];
	[name setTextColor:[UIColor colorWithRed:RGB(0) green:RGB(0) blue:RGB(0) alpha:1.0]];
	[highlight1 setTextColor:[UIColor colorWithRed:RGB(25) green:RGB(56) blue:RGB(102) alpha:1.0]];
	[highlight2 setTextColor:[UIColor colorWithRed:RGB(25) green:RGB(56) blue:RGB(102) alpha:1.0]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)dealloc {
	[super dealloc];
}


@end
