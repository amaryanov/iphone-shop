//
//  ProductViewController.m
//  iShop
//
//  Created by Andrey Konovalov on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#include <string>
#include <vector>
#include <iostream>

#import "ProductViewController.h"
#import "ProductViewCell.h"
#import "ProductDetailsViewController.h"

//#include "soapIMobileSoap12BindingProxy.h"
#include "soapMobileServiceSoap12BindingProxy.h"


class CProduct
{
public:
	CProduct():id(-1){}
	CProduct(const CProduct &pr):id(pr.id),name(pr.name),description(pr.description),cost(pr.cost),imageName(pr.imageName){}
	CProduct(ns2__MProduct *pProd)
	{
		this->id=*(pProd->id);
		name=*(pProd->name);
		if(pProd->imageURL)
		{
			imageName=*(pProd->imageURL);
		}
			
	}
public:
	int id;
	std::string name;
	std::string description;
	std::string cost;
	std::string imageName;
};
class CProductListContainer
{
public:
	CProductListContainer(){};
	std::vector<CProduct> products;
};
using namespace std;
@implementation ProductViewController
@synthesize categoryId;
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
	if(pProducts)
		retVal=pProducts->products.size();
	return retVal;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
static NSString *MyIdentifier = @"ProductCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) 
	{
	NSArray *topObjs;
		topObjs =  [[NSBundle mainBundle] loadNibNamed:@"ProductViewCell" owner:self options:nil];
		if( (topObjs) )//&& ([topObjs containsObject:ProductViewCell]) )
		{
			cell=[topObjs objectAtIndex:1];
		}
	}
	// Configure the cell

	if( (pProducts) && (cell) )
	{
	NSString *str;
	ProductViewCell *prodCell=(ProductViewCell *)cell;
	UIFont *font;
		cout<<indexPath.row<<endl<<pProducts->products[indexPath.row].name<<endl;;
		str=[NSString stringWithUTF8String:pProducts->products[indexPath.row].name.c_str()];
		[prodCell.name setText:str];
		font=[prodCell.name.font fontWithSize:15];
		[prodCell.name setFont:font];
		[prodCell.description setText:@"This is short product description"];
//		[str release];
	}

	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
ProductDetailsViewController *pDetails;
	pDetails=[[ProductDetailsViewController alloc] initWithNibName:@"ProductDetails" bundle:nil];
	pDetails.productId=pProducts->products[indexPath.row].id;
	[[self navigationController] pushViewController:pDetails animated:YES];
}
/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

void buildProducts(vector<CProduct> &products,std::vector<class ns2__MProduct * > &vals)
{
std::vector<class ns2__MProduct * >::iterator iter=vals.begin();
CProduct product;
	for(;iter != vals.end();iter++)
	{
		products.push_back(*iter);
	}
}
// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad 
{
MobileServiceSoap12Binding client;
_ns2__getProductList srvRequest;//=new _ns1__getProductList();
_ns2__getProductListResponse srvResp;
	srvRequest.categoryId=new int(categoryId);
	srvRequest.startItemId=new int(0);
	srvRequest.batchSize=new int(0);
	srvRequest.languageId=new int(0);
	if( SOAP_OK == client.__ns4__getProductList(&srvRequest,&srvResp) )
	{
		pProducts=new CProductListContainer();
		buildProducts(pProducts->products,srvResp.return_);
//		printCategs(pCategs->categs,"");
	}
	[self.navigationItem setTitle:@"Products"];
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
