//
//  SearchController.m
//  iShop
//
//  Created by Andrey Konovalov on 9/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SearchController.h"
class

@implementation SearchController

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

- (void)loadThread:(id)param
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	CCategories *pNewCategs=NULL;
	{
	MobileServiceSoap12Binding client;
	_ns2__searchProducts request;
	_ns2__searchProductsResponse response;
		request.categoryId=new int(0);
		request.freeText=new string("camera");
		if( SOAP_OK == client.__ns4__searchProducts(&request,&response) )
		{
			pNewCategs=new CCategories();
			pNewCategs->buildCategs(pNewCategs->categs,catListResp.return_);
		}
		@synchronized(self) {pCategs=pNewCategs;}
	}
	[indicator stopAnimating];
	[table reloadData];
	[pool release];
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
 */
- (void)viewDidLoad 
{
	if(pCategs == NULL)
	{
		[self.navigationItem setTitle:@"Search categories"];
		[indicator startAnimating];
		[NSThread detachNewThreadSelector:@selector(loadThread:) toTarget:self withObject:nil];
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
static NSString *MyIdentifier = @"CategoryCellIdentifier";
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) 
	{
	NSArray *topObjs;
		topObjs =  [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil];
		if(topObjs)
		{
			cell=[topObjs objectAtIndex:1];
		}
	}
	// Configure the cell
	if( (pCategs) && (cell) )
	{
		CategoryViewCell *categCell=(CategoryViewCell *)cell;
		[categCell.name setText:pCategs->categs[indexPath.row]->name];
		if(pCategs->categs[indexPath.row]->imageUrl)
		{
			[categCell loadingImage:pCategs->categs[indexPath.row]->imageUrl];
		}
		if(pCategs->categs[indexPath.row]->childs.size() == 0)
		{
			[categCell.productsCount setText:[NSString stringWithFormat:@"(%d)", pCategs->categs[indexPath.row]->itemsCnt]];
		}
		[categCell initLabelsFont];
		[categCell placeProductCounts];
		//		[categCell loadingImage:@"http://kenlo.gotdns.com/assets/categoryImage/Computer.png"];
	}
	return cell;
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
