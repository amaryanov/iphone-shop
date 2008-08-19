//
//  CategoryViewCell.m
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
//#import "GData.h"
#import "GDataHTTPFetcher.h"

#import "CategoryViewCell.h"


@implementation CategoryViewCell
@synthesize name;
@synthesize categImg;
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

- (void) loadingImage:(NSString *)urlStr
{
NSString *str=[NSString stringWithFormat:@"http://kenlo.gotdns.com/%@",urlStr];
NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://kenlo.gotdns.com/%@",urlStr]];
NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
GDataHTTPFetcher *fetcher = [GDataHTTPFetcher httpFetcherWithRequest:request];
//	[fetcher setUserData:urlStr];
	
    [fetcher beginFetchWithDelegate:self
                  didFinishSelector:@selector(imageFetcher:finishedWithData:)
          didFailWithStatusSelector:@selector(imageFetcher:failedWithStatus:data:)
           didFailWithErrorSelector:@selector(imageFetcher:failedWithError:)];
}
- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data 
{
UIImage *image = [[[UIImage alloc] initWithData:data] autorelease];
//	[imageList addObject:[[MyTubeIKBrowserItem alloc] init:[fetcher userData] image:image]];
	[categImg setImage:image];
}

- (void)imageFetcher:(GDataHTTPFetcher *)fetcher failedWithStatus:(int)status data:(NSData *)data 
{
NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"image fetch error %d with data %@", status, dataStr);
}

- (void)imageFetcher:(GDataHTTPFetcher *)fetcher failedWithError:(NSError *)error
{
	NSLog(@"Image fetch error %@", error);
}

- (void)dealloc {
	[super dealloc];
}


@end
