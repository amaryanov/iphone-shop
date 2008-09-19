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
		self->pCategs=NULL;
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
		if(pCategs)
			retVal=pCategs->categs.size();
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

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
UITableViewCellAccessoryType retVal=UITableViewCellAccessoryDisclosureIndicator;
	return retVal;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[targetViewController setDelegate:prefControl];
	if(pCategs->categs.size() > indexPath.row)
	{
		if(pCategs->categs[indexPath.row]->childs.size())
		{
		CategoryViewController *root;
			root=[[[CategoryViewController alloc] initWithNibName:self.nibName bundle:nil] autorelease];
			root->pCategs=new CCategories();
			root->pCategs->categs=pCategs->categs[indexPath.row]->childs;
//			printCategs(pCategs->categs,"");
			[[root navigationItem] setTitle:pCategs->categs[indexPath.row]->title];
			[[self navigationController] pushViewController:root animated:YES];
		}
		else
		{
		ProductViewController *prods;
			prods=[[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
			prods.categoryId=pCategs->categs[indexPath.row]->id;
			prods.itemsCnt=pCategs->categs[indexPath.row]->itemsCnt;
			prods.categoryName=pCategs->categs[indexPath.row]->name;
			[prods.navigationItem setTitle:pCategs->categs[indexPath.row]->name];
			[[self navigationController] pushViewController:prods animated:YES];
		}
	}
}


/*
// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
*/
void printCategs(vector<CCategory*> &category,string ident)
{
vector<CCategory*>::iterator iter=category.begin();
	for(;iter!=category.end();iter++)
	{
		cout<<ident<<(*iter)->id<<endl
			<<ident<<(*iter)->name<<endl
			<<ident<<"--------------"<<endl;
		printCategs((*iter)->childs,string(ident+"\t"));
	}
}

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)loadThread:(id)param
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
CCategories *pNewCategs=NULL;
	{
	MobileServiceSoap12Binding client;
	_ns2__getCategoryList catList;
	_ns2__getCategoryListResponse catListResp;
		catList.categoryType=new int(0);
		if( SOAP_OK == client.__ns4__getCategoryList(&catList,&catListResp) )
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
- (void)viewDidLoad 
{
	if(pCategs == NULL)
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
	if(pCategs)
		delete pCategs;
	[super dealloc];
}


@end
