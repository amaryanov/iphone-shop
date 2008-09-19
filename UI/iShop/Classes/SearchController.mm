//
//  SearchController.m
//  iShop
//
//  Created by Andrey Konovalov on 9/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#include <map>
#include <string>
#include <vector>

#import "SearchController.h"
#import "CategoryViewCell.h"
#import "ProductViewController.h"

#include "soapMobileServiceSoap12BindingProxy.h"
#include "Categories.h"

using namespace std;
class CSearchContainer
{
public:
	CSearchContainer(){}
	CSearchContainer(ns2__SearchResult *p):categoryId(*p->categoryId),products(p->itemIds){}
//	CSearchContainer(int cId,vector<int> &p):categoryId(cId),products(p){}
	CSearchContainer(const CSearchContainer &sc):categoryId(sc.categoryId),products(sc.products){}
	CSearchContainer& operator =(const CSearchContainer &sc)
	{
		categoryId=sc.categoryId;
		products=sc.products;
		return *this;
	}
	int categoryId;
	vector<int> products;
};
class CSearchResult
{
public:
	CSearchResult(std::vector<ns2__SearchResult * > &result)
	{
	std::vector<ns2__SearchResult * >::iterator iter;
		for(iter=result.begin();iter!=result.end();iter++)
		{
			categories.push_back(*iter);
		}
	}
public:
	vector<CSearchContainer> categories;
};

@implementation SearchController
@synthesize theView,table,indicator;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
NSInteger retVal=0;
	@synchronized(self)
	{
		if(pSearchResult)
			retVal=pSearchResult->categories.size();
	}
	return retVal;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

- (void)loadThread:(id)param
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	@synchronized(self)
	{
	MobileServiceSoap12Binding client;
	_ns2__searchProducts request;
	_ns2__searchProductsResponse response;
		request.categoryId=new int(0);
		request.freeText=new string("canon");
		if( SOAP_OK == client.__ns4__searchProducts(&request,&response) )
		{
			pSearchResult=new CSearchResult(response.return_);
			(void)CCategory::getInstance();
		}
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
	if(pSearchResult == NULL)
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
	if( (pSearchResult) && (cell) )
	{
	CategoryViewCell *categCell=(CategoryViewCell *)cell;
	CCategory *pCategory=CCategory::getSubCategory(pSearchResult->categories[indexPath.row].categoryId);
		if(pCategory)
		{
			[categCell.name setText:pCategory->name];
			if(pCategory->imageUrl)
				[categCell loadingImage:pCategory->imageUrl];
			[categCell.productsCount setText:[NSString stringWithFormat:@"(%d)", pSearchResult->categories[indexPath.row].products.size()]];
			[categCell initLabelsFont];
			[categCell placeProductCounts];
		}
		//		[categCell loadingImage:@"http://kenlo.gotdns.com/assets/categoryImage/Computer.png"];
	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
CCategory *pCategory=CCategory::getSubCategory(pSearchResult->categories[indexPath.row].categoryId);
	if(pCategory)
	{
	ProductViewController *prods;
		prods=[[[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil] autorelease];
		prods.pProductIds=new vector<int>(pSearchResult->categories[indexPath.row].products);
		[prods.navigationItem setTitle:pCategory->name];
		[[self navigationController] pushViewController:prods animated:YES];
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
