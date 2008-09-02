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
			 NSURL *imageURL = [NSURL URLWithString:[images objectAtIndex:i]];
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

