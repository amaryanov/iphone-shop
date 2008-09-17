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
#import "LoadMoreViewCell.h"

//#include "soapIMobileSoap12BindingProxy.h"
#include "soapMobileServiceSoap12BindingProxy.h"

#define BATCH_SIZE	3

class CProduct
{
public:
	CProduct():id(-1)
	{
		memset(arr,0,sizeof(arr));
	}
	CProduct(const CProduct &pr):id(pr.id)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			arr[i]=pr.arr[i];
			if(arr[i])
				[arr[i] retain];
		}
	}
	~CProduct()
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			if(arr[i])
				[arr[i] release];
		}
	}
	CProduct(ns2__MProduct *pProd)
	{
		memset(arr,0,sizeof(arr));
		if(pProd->id)
			this->id=*(pProd->id);
		if(pProd->name)
			name=[[NSString stringWithUTF8String:pProd->name->c_str()] retain];
		if(pProd->imageURL)
			imageURL=[[NSString stringWithUTF8String:pProd->imageURL->c_str()] retain];
		if(pProd->highlight1)
			highlight1=[[NSString stringWithUTF8String:pProd->highlight1->c_str()] retain];
		if(pProd->highlight2)
			highlight2=[[NSString stringWithUTF8String:pProd->highlight2->c_str()] retain];
		if(pProd->price)
		{
			if( (pProd->stores) && (*(pProd->stores)) )
				storesCnt=[[NSString stringWithFormat:@"(in %d stores)",*(pProd->stores)] retain];
			else
				storesCnt=[[NSString stringWithString:@"(Not in stock)"] retain];
				
			price=[[NSString stringWithFormat:@"From %1.2f₪",*(pProd->price)] retain];
		}
	}
public:
	int id;
	union
	{
		struct
		{
			NSString *name;
			NSString *highlight1;
			NSString *highlight2;
			NSString *price;
			NSString *storesCnt;
			NSString *imageURL;
		};
		NSString *arr[6];
	};
};
class CProductListContainer
{
public:
	CProductListContainer(){};
	std::vector<CProduct> products;
};
using namespace std;
/************************************************
 *
 ************************************************/
@interface ThreadParameter:NSObject
{
	int iVal;
}
@property(readwrite) int iVal;
+ (id) initIntWithVal:(int)val;
@end

@implementation ThreadParameter
@synthesize iVal;
+ (id) initIntWithVal:(int)val
{
ThreadParameter *param;
	param=[[ThreadParameter alloc] init];
	param->iVal=val;
	return param;
}
@end
/***********************************************/
@interface ProductViewController(PrivateMethods)
	CProductListContainer	*pProducts;
	int						itemsWasLoaded;
@end

@implementation ProductViewController
@synthesize loadMoreCell,mainTable;
@synthesize categoryId;
@synthesize itemsCnt;
@synthesize indicator;
@synthesize categoryName;
@synthesize isFavControl;


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
		if( (pProducts) && (pProducts->products.size()) )
		{
			retVal=pProducts->products.size();
			if(retVal != itemsCnt)
				retVal++;//for load more;
		}
	}
	return retVal;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
static NSString *MyIdentifier = @"ProductCellIdentifier";
UITableViewCell *cell;
	NSLog(@"%d",indexPath.row);
	if( indexPath.row == itemsWasLoaded )
	{
		loadMoreCell.label.text=[NSString stringWithFormat:@"Load %d More ...",BATCH_SIZE];
		loadMoreCell.secondLabel.text=[NSString stringWithFormat:@"Total %d %@, loaded %d of %d",itemsCnt,categoryName,itemsWasLoaded,itemsCnt];
		[loadMoreCell initLabelsFont];
		cell=loadMoreCell;
	}
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
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
		ProductViewCell *prodCell=(ProductViewCell *)cell;
			[prodCell initLabelsFont];
			[prodCell.name setText:pProducts->products[indexPath.row].name];
			[prodCell.highlight1 setText:pProducts->products[indexPath.row].highlight1];
			[prodCell.highlight2 setText:pProducts->products[indexPath.row].highlight2];
			[prodCell loadingImage:pProducts->products[indexPath.row].imageURL];
			[prodCell.price setText:pProducts->products[indexPath.row].price];
			[prodCell placeStoresCounts:pProducts->products[indexPath.row].storesCnt];
		}
	}

	return cell;
}
void buildProducts(vector<CProduct> &products,std::vector<class ns2__MProduct * > &vals)
{
	std::vector<class ns2__MProduct * >::iterator iter=vals.begin();
	for(;iter != vals.end();iter++)
	{
		products.push_back(*iter);
	}
}
- (void)requestItemsFromId:(ThreadParameter*)param
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
MobileServiceSoap12Binding client;
	if(isFavControl == NO)
	{
	_ns2__getProductList srvRequest;//=new _ns1__getProductList();
	_ns2__getProductListResponse srvResp;
		srvRequest.categoryId=new int(categoryId);
		srvRequest.startItemId=new int(param.iVal);
		srvRequest.batchSize=new int(BATCH_SIZE);
		srvRequest.languageId=new int(0);
		if( SOAP_OK == client.__ns4__getProductList(&srvRequest,&srvResp) )
		{
			@synchronized(self)
			{
				buildProducts(pProducts->products,srvResp.return_);
				itemsWasLoaded=pProducts->products.size();
			}
		}
	}
	else
	{
/*
	_ns2__getPopularItems request;
	_ns2__getPopularItemsResponse response
		if( SOAP_OK == client.__ns4__getPopularItems(&request,response) )
		{
		}
*/
	}
	if(param.iVal != 0)
	{
		[loadMoreCell.indicator stopAnimating];
	}
	[indicator stopAnimating];
	[mainTable reloadData];
	[pool release];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == itemsWasLoaded)
	{
	ThreadParameter *param;
		[loadMoreCell.indicator startAnimating];
		param=[[ThreadParameter alloc] init];
		param.iVal=(pProducts->products.end()-1)->id;
//		[self requestItemsFromId:(pProducts->products.end()-1)->id];
		[NSThread detachNewThreadSelector:@selector(requestItemsFromId:) toTarget:self withObject:[param retain]];
	}
	else
	{
	ProductDetailsViewController *pDetails;
		pDetails=[[ProductDetailsViewController alloc] initWithNibName:@"ProductDetails" bundle:nil];
		pDetails.productId=pProducts->products[indexPath.row].id;
		[[self navigationController] pushViewController:pDetails animated:YES];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad 
{
	pProducts=new CProductListContainer();
	itemsWasLoaded=0;
	[indicator startAnimating];
	[NSThread detachNewThreadSelector:@selector(requestItemsFromId:) toTarget:self withObject:[ThreadParameter initIntWithVal:0]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
CGFloat retVal;
	if(indexPath.row == itemsWasLoaded)
		retVal=55;
	else
		retVal=80;
	return retVal;
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
