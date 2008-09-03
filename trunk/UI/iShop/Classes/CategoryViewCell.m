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
@synthesize categImg;
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

- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data 
{
UIImage *image = [[[UIImage alloc] initWithData:data] autorelease];
//	[imageList addObject:[[MyTubeIKBrowserItem alloc] init:[fetcher userData] image:image]];
	[categImg setImage:image];
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
