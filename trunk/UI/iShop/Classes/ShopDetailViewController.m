//
//  shopDetailViewController.m
//  iShop
//
//  Created by Andrey Konovalov on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopBarTitleView.h"

@implementation ShopDetailViewController
@synthesize web;
@synthesize url,name;
@synthesize titleView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
*/
- (void)viewDidLoad
{
	[titleView setTitle:name];
	if(url)
	{
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
		if(request)
		{
			[web loadRequest:request];
		}
	}
}

//UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[titleView.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[titleView.indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
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
