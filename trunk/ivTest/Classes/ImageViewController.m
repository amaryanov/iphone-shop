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
@synthesize tabBar;

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
	 //images = [NSMutableArray array];
	 [images addObject:[UIImage imageNamed:@"1.png"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 [images addObject:[UIImage imageNamed:@"3.jpg"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 [images addObject:[UIImage imageNamed:@"1.png"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 [images addObject:[UIImage imageNamed:@"1.png"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 [images addObject:[UIImage imageNamed:@"1.png"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 [images addObject:[UIImage imageNamed:@"1.png"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 [images addObject:[UIImage imageNamed:@"1.png"]];
	 [images addObject:[UIImage imageNamed:@"2.png"]];
	 int i, row;
	 UIButton *button;
	 for(i = 0; i < [images count]; i++)
	 {
		 row = i/IMAGES_PER_LINE;
		 CGRect buttonFrame = CGRectMake(IMAGE_WIDTH*(i - row*IMAGES_PER_LINE), IMAGE_WIDTH*row, IMAGE_WIDTH, IMAGE_WIDTH);
		 ImageButton *button = [[ImageButton alloc] initWithFrame:buttonFrame];
		 button.imgNum = i;
		 [button setBackgroundImage:[images objectAtIndex:i] forState:UIControlStateNormal];
		 [button addTarget:self action:@selector(openSlider:) forControlEvents:UIControlEventTouchUpInside];
		 [[self view] addSubview:button];
	 }
 }
 
- (void)openSlider:(id)sender {
	slider.current = [sender imgNum];
	slider.tabBar = tabBar;
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
	[super dealloc];
}

@end

