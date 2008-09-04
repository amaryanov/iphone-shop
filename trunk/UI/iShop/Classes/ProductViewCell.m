//
//  ProductViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductViewCell.h"
#define RGB(x) (((float)x)/255)

@implementation ProductViewCell
@synthesize name;
@synthesize price;
@synthesize highlight1;
@synthesize highlight2;
@synthesize image;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data 
{
	UIImage *img = [[[UIImage alloc] initWithData:data] autorelease];
	//	[imageList addObject:[[MyTubeIKBrowserItem alloc] init:[fetcher userData] image:image]];
	
	[indicator stopAnimating];
	[image setImage:img];
}
- (void)initLabelsFont
{
	[name setFont:[UIFont systemFontOfSize:12.5]];
	[highlight1 setFont:[UIFont systemFontOfSize:12.5]];
	[highlight2 setFont:[UIFont systemFontOfSize:12.5]];
	[price setFont:[UIFont systemFontOfSize:12.5]];
	[name setTextColor:[UIColor colorWithRed:RGB(0x8d) green:RGB(0x2d) blue:RGB(0x2d) alpha:1.0]];
	[highlight1 setTextColor:[UIColor colorWithRed:RGB(255) green:RGB(128) blue:RGB(0) alpha:1.0]];
	[highlight2 setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
	[price setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc {
	[super dealloc];
}


@end
