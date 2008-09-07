//
//  BaseCellView.m
//  iShop
//
//  Created by Andrey Konovalov on 27.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BaseCellView.h"
#import "GDataHTTPFetcher.h"
#import <CFNetwork/CFNetwork.h>

@implementation BaseCellView

static NSMutableDictionary *loadedImages;

@synthesize indicator,cellImage;

- (NSString*) makeUrl:(NSString *)url
{
NSString *ret;
	if([url rangeOfString:@"http://"].location == NSNotFound)
		ret=[NSString stringWithFormat:@"http://kenlo.gotdns.com/%@",url];
	else
		ret=url;
	return ret;
}
/*
- (void) loadingImage:(NSString *)urlStr
{
NSURL *imageURL = [NSURL URLWithString:[self makeUrl:urlStr]];
NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
UIImage *img;
GDataHTTPFetcher *fetcher = [GDataHTTPFetcher httpFetcherWithRequest:request];
	if(indicator)
		[indicator startAnimating];
	@synchronized(self)
	{
		if( (loadedImages) && ( (img=[loadedImages objectForKey:urlStr]) != nil) )
		{
			if(indicator)
				[indicator stopAnimating];
			[cellImage setImage:img];
		}
		else
		{
		BOOL fl;
			if(!loadedImages)
				loadedImages=[[NSMutableDictionary alloc] init];
			[fetcher setShouldCacheDatedData:YES];
			[fetcher setUserData:[NSString stringWithString:urlStr]];
			
			fl=[fetcher beginFetchWithDelegate:self
						  didFinishSelector:@selector(imageFetcher:finishedWithData:)
				  didFailWithStatusSelector:@selector(imageFetcher:failedWithStatus:data:)
				   didFailWithErrorSelector:@selector(imageFetcher:failedWithError:)];
			if(fl == NO)
			{
				[indicator stopAnimating];
			}
		}
	}
}
*/
- (void)loadingThread:(id)parameter
{
NSAutoreleasePool *pool= [[NSAutoreleasePool alloc] init];
CFURLRef url=CFURLCreateWithString(kCFAllocatorDefault,(CFStringRef)parameter,NULL);
CFHTTPMessageRef request = CFHTTPMessageCreateRequest(kCFAllocatorDefault,
														  CFSTR("GET"), 
														  url, kCFHTTPVersion1_1);
CFReadStreamRef rdStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, request);
NSMutableData *data=[[NSMutableData alloc] init];
static UInt8 buff[1024];
CFIndex cnt;
	if(CFReadStreamOpen(rdStream))
	{
		while( (cnt=CFReadStreamRead(rdStream, buff, sizeof(buff))) )
		{
			[data appendBytes:buff length:cnt];
		}
		UIImage *img = [[UIImage alloc] initWithData:data];
		@synchronized(self)
		{
			if(![loadedImages objectForKey:(NSString*)parameter])
			{
				[loadedImages setObject:img forKey:(NSString*)parameter];
			}
		}
		[cellImage setImage:img];
	}
	if(indicator)
		[indicator stopAnimating];
	[pool release];
}
- (void) loadingImage:(NSString *)urlStr
{
NSString *url=[self makeUrl:urlStr];
UIImage *img;
	@synchronized(self)
	{
		if(!loadedImages)
			loadedImages=[[NSMutableDictionary alloc] init];
		if( (img=[loadedImages objectForKey:url]) )
		{
			[cellImage setImage:img];
		}
		else
		{
			if(indicator)
				[indicator startAnimating];
			[NSThread detachNewThreadSelector:@selector(loadingThread:) toTarget:self withObject:url];
		}
	}
}

- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data 
{
UIImage *img = [[[UIImage alloc] initWithData:data] retain];
	@synchronized(self)
	{
		if(![loadedImages objectForKey:[fetcher userData]])
		{
			[loadedImages setObject:img forKey:[fetcher userData]];
		}
		if(indicator)
			[indicator stopAnimating];
		[cellImage setImage:img];
	}
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
