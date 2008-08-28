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

- (void) loadingImage:(NSString *)urlStr
{
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
