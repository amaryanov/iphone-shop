//
//  ProductDetailsViewCotroller.mm
//  iShop
//
//  Created by Andrey Konovalov on 20.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductDetailCellView.h"

#include "soapIMobileSoap12BindingProxy.h"
using namespace std;

class CProductOffer
{
public:
	CProductOffer():id(-1),price(0),shipmentCost(0){}
	CProductOffer(const CProductOffer &po):currency(po.currency),details(po.details),id(po.id),imageURL(po.imageURL),
											manufacturer(po.manufacturer),model(po.model),name(po.name),price(po.price),
											productURL(po.productURL),shipmentCost(po.shipmentCost){}
	CProductOffer(const ns2__MProductOffer *pMp)
	{
		copyMemebers(pMp);
	}
	CProductOffer &operator =(const ns2__MProductOffer *pMp)
	{
		copyMemebers(pMp);
		return *this;
	}
public:
	std::string currency;
	std::string details;
	int			id;
	std::string imageURL;
	std::string manufacturer;
	std::string model;
	std::string name;
	float		price;
	std::string productURL;
	float 		shipmentCost;
private:
	void copyMemebers(const ns2__MProductOffer *pMp)
	{
		if(pMp->currency)
			currency=*(pMp->currency);
		if(pMp->details)
			details=*(pMp->details);
		if(pMp->id)
			this->id=*(pMp->id);
		else
			this->id=-1;
		if(pMp->imageURL)
			imageURL=*(pMp->imageURL);
		if(pMp->manufacturer)
			manufacturer=*(pMp->manufacturer);
		if(pMp->model)
			model=*(pMp->model);
		if(pMp->name)
			name=*(pMp->name);
		if(pMp->price)
			price=*(pMp->price);
		else
			price=0;
		if(pMp->productURL)
			productURL=*(pMp->productURL);
		if(pMp->shipmentCost)
			shipmentCost=*(pMp->shipmentCost);
}
	
};
class CProductDataContainer
{
public:
	CProductDataContainer(){};
	CProductDataContainer &operator = (const ns2__MDetailedProduct *pProd)
	{
	std::vector<ns2__MProductOffer * >::const_iterator iter;
		if(pProd->id)
			this->id=*(pProd->id);
		if(pProd->name)
			name=*(pProd->name);
		if(pProd->imageURL)
			imageURL=*(pProd->imageURL);
		if(pProd->amazonURL)
			amazonURL=*(pProd->amazonURL);
		if(pProd->reviewURL)
			reviewURL=*(pProd->reviewURL);
		for(iter=pProd->offers.begin();iter != pProd->offers.end();iter++)
		{
			offers.push_back(*iter);
		}
		
		return *this;
	}
public:
	int id;
	std::string name;
	std::string imageURL;
	std::string amazonURL;
	std::string reviewURL;
	std::vector<CProductOffer> offers;
};

@implementation ProductDetailsViewController

@synthesize productId;
@synthesize firstCell, secondCell, buttonsCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger retVal=0;
	switch (section) {
		case 0:
			retVal = 2;
			break;
		case 1:
			retVal = 1;
		default:
			break;
	}
	return retVal;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell *cell;
	switch ([indexPath indexAtPosition:0]) {
		case 0:
			switch([indexPath indexAtPosition:1])
			{
				case 0:
					cell = firstCell ;
					break;
				case 1:
					cell = secondCell;
					break;
			}
			break;
		case 1:
			cell = buttonsCell;
			break;
	}
	return cell;
}
/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad 
{
IMobileSoap12Binding client;
_ns1__getProductDetails srvRequest;
_ns1__getProductDetailsResponse srvResp;
//	srvRequest.param0=new int(productId);
	srvRequest.param0=new int(1);
	if( SOAP_OK == client.__ns4__getProductDetails(&srvRequest,&srvResp) )
	{
	vector<ns2__MProductOffer * >::iterator iter=srvResp.return_->offers.begin();
		pProdData=new CProductDataContainer();
		*pProdData=srvResp.return_;
	}
	[self.navigationItem setTitle:@"Detail data"];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
CGFloat retVal=44;
	if(indexPath.section == 0)
	{
		switch(indexPath.row)
		{
			case 0:
				retVal=firstCell.bounds.size.height;
				break;
			case 1:
				retVal=secondCell.bounds.size.height;
				break;
		}
	}
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
