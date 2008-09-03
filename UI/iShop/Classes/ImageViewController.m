//
//  FirstViewController.m
//  ivTest
//
//  Created by Anton Maryanov on 8/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageButton

@synthesize imgNum;
- (void) startActivity
{
	self->activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	CGRect actFr = self->activity.frame;
	actFr.origin.x = (IMAGE_WIDTH - actFr.size.width)/2;
	actFr.origin.y = (IMAGE_WIDTH - actFr.size.height)/2;
	self->activity.frame = actFr;
	[self->activity startAnimating];
	[self addSubview:activity];
}
- (void) stopActivity
{
	[activity stopAnimating];
	[activity removeFromSuperview];
	[activity release];
}
@end


@implementation ImageViewController
@synthesize slider;
@synthesize images, buttons;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}
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
 - (void)loadView {
	 [super loadView];
 }
 */

 //If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	
	 self.navigationItem.title = @"Images";
	 int i, j, row, col;
	j = 0;
	 for(i = 0; i < [images count]; i++)
	 {
		 if([images objectAtIndex:i] != nil)
		 {
			 row = j/IMAGES_PER_LINE;
			 col = i - row*IMAGES_PER_LINE;
			 CGRect buttonFrame = CGRectMake(IMAGE_WIDTH*col + IMAGE_PADDING*(col + 1), IMAGE_WIDTH*row + IMAGE_PADDING*(row + 1), IMAGE_WIDTH, IMAGE_WIDTH);
			 ImageButton *button = [[ImageButton alloc] initWithFrame:buttonFrame];
			 button.imgNum = j;
			 [button addTarget:self action:@selector(openSlider:) forControlEvents:UIControlEventTouchUpInside];
			 [[self view] addSubview:button];
			 [buttons addObject:button];
			 [button startActivity];
			 NSURL *imageURL = [NSURL URLWithString:[self makeUrl:[images objectAtIndex:i]]];
			 NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
			 GDataHTTPFetcher *fetcher = [GDataHTTPFetcher httpFetcherWithRequest:request];
			 [fetcher setUserData:button];
			 [fetcher setShouldCacheDatedData:YES];
			 
			 [fetcher beginFetchWithDelegate:self
						   didFinishSelector:@selector(imageFetcher:finishedWithData:)
				   didFailWithStatusSelector:@selector(imageFetcher:failedWithStatus:data:)
					didFailWithErrorSelector:@selector(imageFetcher:failedWithError:)];
			 j++;
		 }
	 }
	UIScrollView *scrl = self.view;
	scrl.contentSize = CGSizeMake(320, row * IMAGE_WIDTH);
 }
 

- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data 
{
	UIImage *img = [[[UIImage alloc] initWithData:data] autorelease];
	ImageButton *button = [fetcher userData];
	[button stopActivity];
	[button setBackgroundImage:img forState:UIControlStateNormal];
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

- (void)openSlider:(id)sender {
	slider.current = [sender imgNum];
	[[self navigationController] pushViewController:slider animated:YES];
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
	[images release];
	[buttons release];
	[super dealloc];
}

@end

