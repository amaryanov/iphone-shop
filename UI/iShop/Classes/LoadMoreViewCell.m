//
//  LoadMoreViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 9/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LoadMoreViewCell.h"


@implementation LoadMoreViewCell
@synthesize label,indicator;

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


- (void)dealloc {
	[super dealloc];
}


@end