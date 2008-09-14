//
//  OffersSortController.m
//  iShop
//
//  Created by Andrey Konovalov on 9/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OffersSortController.h"
#import "OffersTable.h"

@interface OffersSortController (PrivateMethods)
UITableViewCell *cells[3];
@end

@implementation OffersSortController
@synthesize tableDelegate,selectedRow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
 */
- (void)viewDidLoad 
{
static NSString *labels[]={@"Price",@"Shipping",@"Total"};
	 for(int i=0;i<3;i++)
	 {
		cells[i]=[[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,320,44)];
		[cells[i] setText:labels[i]];
		if(i == selectedRow)
			[cells[i] setAccessoryType:UITableViewCellAccessoryCheckmark];
	 }
 }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return cells[indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(selectedRow != indexPath.row)
	{
		[cells[selectedRow] setAccessoryType:UITableViewCellAccessoryNone];
		[cells[indexPath.row] setAccessoryType:UITableViewCellAccessoryCheckmark];
		selectedRow=indexPath.row;
		[tableDelegate setSortingType:indexPath.row];
		[[self navigationController] popViewControllerAnimated:YES];// hViewController
	}
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
