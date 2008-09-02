//
//  BaseCellView.m
//  iShop
//
//  Created by Andrey Konovalov on 27.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BaseCellView.h"
#import "GDataHTTPFetcher.h"


@implementation BaseCellView

@synthesize indicator;

- (NSString*) makeUrl:(NSString *)url
{
NSString *ret;
	if([url rangeOfString:@"http://"].location == NSNotFound)
		ret=[NSString stringWithFormat:@"http://kenlo.gotdns.com/%@",url];
	else
		ret=url;
	return ret;
}
- (void) loadingImage:(NSString *)urlStr
{
NSURL *imageURL = [NSURL URLWithString:[self makeUrl:urlStr]];
NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
GDataHTTPFetcher *fetcher = [GDataHTTPFetcher httpFetcherWithRequest:request];
	if(indicator)
		[indicator startAnimating];
	[fetcher setShouldCacheDatedData:YES];
	//	[fetcher setUserData:urlStr];
	
    [fetcher beginFetchWithDelegate:self
                  didFinishSelector:@selector(imageFetcher:finishedWithData:)
          didFailWithStatusSelector:@selector(imageFetcher:failedWithStatus:data:)
           didFailWithErrorSelector:@selector(imageFetcher:failedWithError:)];
}
- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data 
{
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
