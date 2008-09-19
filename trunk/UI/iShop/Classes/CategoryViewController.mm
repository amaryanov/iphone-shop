//
//  RootViewController.m
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#include <iostream>

#import "CategoryViewController.h"
#import "ProductViewController.h"
#import "ProductViewCell.h"
#import "CategoryViewCell.h"

#include "Categories.h"
#include "soapMobileServiceSoap12BindingProxy.h"



using namespace std;
void printCategs(std::vector<CCategory> &category,std::string ident);

//	NSCondition *cond;
@implementation CategoryViewController
@synthesize theView;
@synthesize table;
@synthesize indicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
		// Initialization code
		self->pCategory=NULL;
	}
	return self;
}
/****************************************
 * UITableViewDelegate Protocol Reference
 ****************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
NSInteger retVal=0;
	@synchronized(self)
	{
		if(pCategory)
			retVal=pCategory->childs.size();
	}
	return retVal;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
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
	if( (pCategory) && (cell) )
	{
	CategoryViewCell *categCell=(CategoryViewCell *)cell;
		[categCell.name setText:pCategory->childs[indexPath.row]->name];
		if(pCategory->childs[indexPath.row]->imageUrl)
		{
			[categCell loadingImage:pCategory->childs[indexPath.row]->imageUrl];
		}
		if(pCategory->childs[indexPath.row]->childs.size() == 0)
		{
			[categCell.productsCount setText:[NSString stringWithFormat:@"(%d)", pCategory->childs[indexPath.row]->itemsCnt]];
		}
		[categCell initLabelsFont];
		[categCell placeProductCounts];
//		[categCell loadingImage:@"http://kenlo.gotdns.com/assets/categoryImage/Computer.png"];
	}
	return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
UITableViewCellAccessoryType retVal=UITableViewCellAccessoryDisclosureIndicator;
	return retVal;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[targetViewController setDelegate:prefControl];
	if(pCategory->childs.size() > indexPath.row)
	{
		if(pCategory->childs[indexPath.row]->childs.size())
		{
		CategoryViewController *root;
			root=[[[CategoryViewController alloc] initWithNibName:self.nibName bundle:nil] autorelease];
			root->pCategory=CCategory::getSubCategory(pCategory->childs[indexPath.row]->id);
//			printCategs(pCategs->categs,"");
			[[root navigationItem] setTitle:root->pCategory->title];
			[[self navigationController] pushViewController:root animated:YES];
		}
		else
		{
		ProductViewController *prods;
			prods=[[[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil] autorelease];
			prods.categoryId=pCategory->childs[indexPath.row]->id;
			prods.itemsCnt=pCategory->childs[indexPath.row]->itemsCnt;
			prods.categoryName=pCategory->childs[indexPath.row]->name;
			[prods.navigationItem setTitle:pCategory->childs[indexPath.row]->name];
			[[self navigationController] pushViewController:prods animated:YES];
		}
	}
}


/*
// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
*/
// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)loadThread:(id)param
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	@synchronized(self)
	{
		pCategory=CCategory::getInstance();
	}
	[indicator stopAnimating];
	[table reloadData];
	[pool release];
}
- (void)viewDidLoad 
{
	if(pCategory == NULL)
	{
		[self.navigationItem setTitle:@"Categories"];
		[indicator startAnimating];
		[NSThread detachNewThreadSelector:@selector(loadThread:) toTarget:self withObject:nil];
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


- (void)dealloc 
{
	[super dealloc];
}


@end
