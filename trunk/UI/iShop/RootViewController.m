//
//  RootViewController.m
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

@synthesize myDinamicalyTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}
/****************************************
 * UITableViewDelegate Protocol Reference
 ****************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	// Configure the cell
	return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
UITableViewCellAccessoryType retVal=UITableViewCellAccessoryDisclosureIndicator;
	return retVal;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
RootViewController *root;
	root=[[RootViewController alloc] initWithNibName:self.nibName bundle:self.nibBundle];
	//[targetViewController setDelegate:prefControl];
	[[self navigationController] pushViewController:root animated:YES];
	
}


/*
// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
*/

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad 
{
static int i=0;
	self.navigationItem.title=[NSString stringWithFormat:@"My title %d",i++];
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
