//
//  BaseCellView.m
//  iShop
//
//  Created by Andrey Konovalov on 8/27/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BaseCellView.h"


@implementation BaseCellView

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

- (void) loadingImage:(NSString*)url
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc {
	[super dealloc];
}


@end