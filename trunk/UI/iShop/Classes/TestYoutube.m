//
//  TestYoutube.m
//  iShop
//
//  Created by Anton Maryanov on 8/22/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TestYoutube.h"
@implementation MyYouTube

-(MyYouTube*)initWithYoutubeUrl:(NSString*)urlString postToObject:(id)ObjToPost
{
	
	NSRange videoIdPlace = [urlString rangeOfString:@"v=" options:NSCaseInsensitiveSearch];
	NSRange r;
	r.location = videoIdPlace.location + 2;
	r.length = [urlString length] - r.location;
	NSRange youtubeIdPlaceTo = [urlString rangeOfString:@"&" options:NSCaseInsensitiveSearch range:r];
	if(youtubeIdPlaceTo.length != 0)
		r.length = youtubeIdPlaceTo.location - videoIdPlace.location - 2;
	else
		r.length = [urlString length] - videoIdPlace.location - 2;
	NSString *movieId = [urlString substringWithRange:r];
	self->objToPost = ObjToPost;
    GDataServiceTicket *ticket;
	GDataServiceGoogleYouTube *service = [MyYouTube youTubeService];
	
	NSURL *feedURL = [GDataServiceGoogleYouTube youTubeURLForVideoID:movieId];
    ticket = [service fetchYouTubeFeedWithURL:feedURL
                                     delegate:self
                            didFinishSelector:@selector(entryListFetchTicket:finishedWithFeed:)
                              didFailSelector:@selector(entryListFetchTicket:failedWithError:)];
	return self;
}

- (void)entryListFetchTicket:(GDataServiceTicket *)ticket failedWithError:(NSError *)error {
    NSLog(@"Error %@", error);
	[self release];
}
- (void)entryListFetchTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedBase *)feed {
	if (![feed respondsToSelector:@selector(mediaGroup)]) return;
	GDataEntryYouTubeVideo *video = (GDataEntryYouTubeVideo *)feed;
	NSString *url = [[[[video mediaGroup] mediaContents] objectAtIndex:0] URLString];
    SEL theSEL = @selector(setYoutubeMovieURL:);  
	NSMethodSignature *signature = [objToPost methodSignatureForSelector:theSEL];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setSelector:theSEL];
	[invocation setTarget:objToPost];  
	[invocation setArgument:&url atIndex:2];
	[invocation retainArguments];
	[invocation invoke];
	[self release];
}

+ (GDataServiceGoogleYouTube *)youTubeService {
    static GDataServiceGoogleYouTube *service = nil;
    if (!service) {
        service = [[GDataServiceGoogleYouTube alloc] init];
		[service setUserAgent:@"Apple iPhone v1.1.4 YouTube v1.0.0.4A102"];
        //[service setShouldCacheDatedData:YES];
		[service setAuthToken:@"AIwbFAT5d7FIz8ZMy158BEM9eGNRMnodkPtAh2BrxyNx3gksiu95lNW5z9abJoabSmeIQUztXcghhqCw-wxQ9pst1SU5DV0SH1IQNr8KeOCWAVi78WB13S7BxkzYYxATWgaYJyk2Jz214F2icTfV37XavhH39acp5QPa4LwwnZvWJR_y9layHCI"];
    }
    return service;
}

@end


@implementation TestYoutube

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}
@synthesize txt;

-(void)setYoutubeMovieURL:(NSString*)vidURL
{
	NSLog(vidURL);
}

- (IBAction) loadMovie:(id)sender
{
	MyYouTube* t = [[MyYouTube alloc] initWithYoutubeUrl:[txt text] postToObject:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}


@end
