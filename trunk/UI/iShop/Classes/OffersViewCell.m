//
//  OffersViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 9/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OffersViewCell.h"


@implementation OffersViewCell
@synthesize price;
@synthesize shipping;
@synthesize total;
@synthesize ratingView;

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
-(void) setRating:(float)rating
{
NSString *fullStarPath=[NSString stringWithFormat:@"%@/full-star.png",[[NSBundle mainBundle] bundlePath]];
NSString *halfStarPath=[NSString stringWithFormat:@"%@/half-star.png",[[NSBundle mainBundle] bundlePath]];
NSString *emptyStarPath=[NSString stringWithFormat:@"%@/empty-star.png",[[NSBundle mainBundle] bundlePath]];
UIImage *img;
UIImageView *imgV;
	for(int i=0,cnt=(int)rating,half=((rating-cnt)>0?1:0);i<5;i++)
	{
		if(cnt)
		{
			img=[UIImage imageWithContentsOfFile:fullStarPath];
			cnt--;
		}
		else if(half)
		{
			img=[UIImage imageWithContentsOfFile:halfStarPath];
			half=0;
		}
		else
			img=[UIImage imageWithContentsOfFile:emptyStarPath];
		imgV=[[UIImageView alloc] initWithImage:img];
		[imgV setFrame:CGRectMake(i*14,1,14,14)];
		[ratingView addSubview:imgV];
	}
/*
	[fullStarPath release];
	[halfStarPath release];
	[emptyStarPath release];
*/
}

- (void)configureLabels
{
	[price setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
	[shipping setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.5]];
	[total setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.5]];
	
	[price setTextColor:[UIColor colorWithRed:RGB(0) green:RGB(0) blue:RGB(0) alpha:1.0]];
	[shipping setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
	[total setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
}

- (void)dealloc {
	[super dealloc];
}


@end
