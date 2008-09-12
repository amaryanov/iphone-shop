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
	[name setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
	[highlight1 setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.5]];
	[highlight2 setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.5]];
	[name setTextColor:[UIColor colorWithRed:RGB(0) green:RGB(0) blue:RGB(0) alpha:1.0]];
	[highlight1 setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
	[highlight2 setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)dealloc {
	[super dealloc];
}


@end
