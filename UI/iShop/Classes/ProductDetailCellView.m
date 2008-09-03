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
@synthesize prodImg;
@synthesize highlight1;
@synthesize highlight2;

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
	[prodImg setImage:image];
	
}

- (void)dealloc {
	[super dealloc];
}


@end