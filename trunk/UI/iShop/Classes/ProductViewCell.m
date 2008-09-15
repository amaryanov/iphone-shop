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
@synthesize storesCount;

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
	[price setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.5]];
	[storesCount setFont:[UIFont fontWithName:@"ArialMT" size:12.5]];
	[name setTextColor:[UIColor colorWithRed:RGB(0) green:RGB(0) blue:RGB(0) alpha:1.0]];
	[highlight1 setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
	[highlight2 setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
	[price setTextColor:[UIColor colorWithRed:RGB(161) green:RGB(41) blue:RGB(4) alpha:1.0]];
	[storesCount setTextColor:[UIColor colorWithRed:RGB(105) green:RGB(105) blue:RGB(105) alpha:1.0]];	
}
/*
const char *fontNamesArr[]={"HiraKakuProN-W3","Courier","Courier-BoldOblique","Courier-Oblique","Courier-Bold",
						"ArialMT","Arial-BoldMT","Arial-BoldItalicMT","Arial-ItalicMT","STHeitiTC-Light","STHeitiTC-Medium",
						"AppleGothic","CourierNewPS-BoldMT","CourierNewPS-ItalicMT","CourierNewPS-BoldItalicMT","CourierNewPSMT",
"Zapfino","HiraKakuProN-W6","ArialUnicodeMS","STHeitiSC-Medium","STHeitiSC-Light","AmericanTypewriter",
"AmericanTypewriter-Bold","Helvetica-Oblique","Helvetica-BoldOblique","Helvetica",
"Helvetica-Bold","MarkerFelt-Thin","HelveticaNeue","HelveticaNeue-Bold",
"DBLCDTempBlack","Verdana-Bold","Verdana-BoldItalic","Verdana",
"Verdana-Italic","TimesNewRomanPSMT","TimesNewRomanPS-BoldMT",
"TimesNewRomanPS-BoldItalicMT","TimesNewRomanPS-ItalicMT","Georgia-Bold",
"Georgia","Georgia-BoldItalic","Georgia-Italic","STHeitiJ-Medium","STHeitiJ-Light","ArialRoundedMTBold",
"TrebuchetMS-Italic","TrebuchetMS","Trebuchet-BoldItalic","TrebuchetMS-Bold","STHeitiK-Medium","STHeitiK-Light"};
- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
	if(selected)
	{
		if(iter >= sizeof(fontNamesArr)/sizeof(const char*))
			iter=0;
		[name setText:[NSString stringWithUTF8String:fontNamesArr[iter]]];
		[name setFont:[UIFont fontWithName:[NSString stringWithUTF8String:fontNamesArr[iter]] size:15.5]];//[name.font fontWithSize:15.5]];
		[highlight1 setFont:[UIFont fontWithName:[NSString stringWithUTF8String:fontNamesArr[iter]] size:13.5]];//[highlight1.font fontWithSize:13.5]];
		[highlight2 setFont:[UIFont fontWithName:[NSString stringWithUTF8String:fontNamesArr[iter]] size:13.5]];//[highlight2.font fontWithSize:13.5]];
		[price setFont:[UIFont fontWithName:[NSString stringWithUTF8String:fontNamesArr[iter]] size:13.5]];//[price.font fontWithSize:13.5]];
		iter++;
	}
	//	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}
*/

- (void)placeStoresCounts:(NSString*)countStr
{
	{
		CGSize priceSize = [price.text sizeWithFont:price.font];
		CGRect storeFrame = storesCount.frame;
		storeFrame.origin.x = price.frame.origin.x + priceSize.width + 2;
		storeFrame.size.width=289-storeFrame.origin.x;
		if(storeFrame.origin.x < storesCount.frame.origin.x)
			storesCount.frame = storeFrame;
		[storesCount setText:countStr];
/*		
		CGSize nameSize = [name.text sizeWithFont:name.font];
		CGRect prodFrame = productsCount.frame;
		prodFrame.origin.x = name.frame.origin.x + nameSize.width + 2;
		if(prodFrame.origin.x < productsCount.frame.origin.x)
			productsCount.frame = prodFrame;
*/		
	}
/*
	else
	{
		CGRect nameRect = name.frame;
		nameRect.size.width += 32.0;
		name.frame = nameRect;
	}
*/
}


- (void)dealloc {
	[super dealloc];
}


@end
