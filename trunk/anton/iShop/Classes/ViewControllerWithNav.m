//
//  ViewControllerWithNav.m
//  iShop
//
//  Created by Anton Maryanov on 8/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerWithNav.h"


@implementation ViewControllerWithNav

@synthesize navController;

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


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	[[self view] addSubview:[navController view]];
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
