//
//  ProductViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductViewCell.h"


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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc {
	[super dealloc];
}


@end