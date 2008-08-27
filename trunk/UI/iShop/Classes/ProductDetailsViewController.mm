//
//  ProductDetailsViewCotroller.mm
//  iShop
//
//  Created by Andrey Konovalov on 20.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductDetailCellView.h"

#include "soapMobileServiceSoap12BindingProxy.h"
using namespace std;


class CProductOffer
{
public:
	CProductOffer():id(-1),price(0),shipmentCost(0)
	{
		for(int i=0;i<7;i++)
			arr[i]=nil;
	}
	CProductOffer(const CProductOffer &po):currency(po.currency),details(po.details),
											imageURL(po.imageURL),manufacturer(po.manufacturer),
											model(po.model),name(po.name),productURL(po.productURL),
											id(po.id),shipmentCost(po.shipmentCost),price(po.price)
	{
		for(int i=0;i<7;i++)
		{
			if(arr[i])
				[arr[i] retain];
		}
	}
	CProductOffer(const ns2__MProductOffer *pMp)
	{
		for(int i=0;i<7;i++)
			arr[i]=nil;
		if(pMp)
			copyMemebers(pMp);
	}
	~CProductOffer()
	{
		for(int i=0;i<7;i++)
		{
			if(arr[i])
				[arr[i] release];
		}
	}
	
	CProductOffer &operator =(const ns2__MProductOffer *pMp)
	{
		if(pMp)
			copyMemebers(pMp);
		return *this;
	}
public:
	union
	{
		struct
		{
			NSString *currency;
			NSString *details;
			NSString *imageURL;
			NSString *manufacturer;
			NSString *model;
			NSString *name;
			NSString *productURL;
		};
		NSString *arr[7];
	};
	int			id;
	float 		shipmentCost;
	float		price;
private:
	void copyMemebers(const ns2__MProductOffer *pMp)
	{
		if(pMp->currency)
			currency=[NSString stringWithUTF8String:pMp->currency->c_str()];
		if(pMp->details)
			details=[NSString stringWithUTF8String:pMp->details->c_str()];
		if(pMp->id)
			this->id=*(pMp->id);
		else
			this->id=-1;
		if(pMp->imageURL)
			imageURL=[NSString stringWithUTF8String:pMp->imageURL->c_str()];
		if(pMp->manufacturer)
			manufacturer=[NSString stringWithUTF8String:pMp->manufacturer->c_str()];
		if(pMp->model)
			model=[NSString stringWithUTF8String:pMp->model->c_str()];
		if(pMp->name)
			name=[NSString stringWithUTF8String:pMp->name->c_str()];
		if(pMp->price)
			price=*(pMp->price);
		else
			price=0;
		if(pMp->productURL)
			productURL=[NSString stringWithUTF8String:pMp->productURL->c_str()];
		if(pMp->shipmentCost)
			shipmentCost=*(pMp->shipmentCost);
}
	
};
class CProductDataContainer
{
public:
	CProductDataContainer()
	{
		for(int i=0;i<4;i++)
			arr[i]=nil;
	}
	~CProductDataContainer()
	{
		for(int i=0;i<4;i++)
			[arr[i] release];
	}
	CProductDataContainer &operator = (const ns2__MDetailedProduct *pProd)
	{
	std::vector<ns2__MProductOffer * >::const_iterator iter;
		if(pProd->id)
			this->id=*(pProd->id);
		if(pProd->name)
			name=[NSString stringWithUTF8String:pProd->name->c_str()];
		if(pProd->imageURL)
			imageURL=[NSString stringWithUTF8String:pProd->imageURL->c_str()];
		if(pProd->amazonURL)
			amazonURL=[NSString stringWithUTF8String:pProd->amazonURL->c_str()];
		if(pProd->reviewURL)
			reviewURL=[NSString stringWithUTF8String:pProd->reviewURL->c_str()];
		NSLog(@"retain cnt %d",[[[NSString alloc] retain] retainCount]);
		for(iter=pProd->offers.begin();iter != pProd->offers.end();iter++)
		{
			offers.push_back(*iter);
		}
		
		return *this;
	}
public:
	int id;
	union
	{
		struct
		{
			NSString *name;
			NSString *imageURL;
			NSString *amazonURL;
			NSString *reviewURL;
		};
		NSObject *arr[4];
	};
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
MobileServiceSoap12Binding client;
_ns2__getProductDetails srvRequest;
_ns2__getProductDetailsResponse srvResp;
//	srvRequest.param0=new int(productId);
	srvRequest.productId=new int(0);
	srvRequest.languageId=new int(0);

	if( SOAP_OK == client.__ns4__getProductDetails(&srvRequest,&srvResp) )
	{
	vector<ns2__MProductOffer * >::iterator iter=srvResp.return_->offers.begin();
		pProdData=new CProductDataContainer();
		*pProdData=srvResp.return_;
		firstCell.name.text=pProdData->name;
		//firstCell.description.text=pProdData->
	}
	if(pProdData)
		[self.navigationItem setTitle:pProdData->name];
	
}
/*
HTTP/1.1 500 Internal Server Error
Server: Apache-Coyote/1.1
Content-Type: application/soap+xml; action="http://www.w3.org/2005/08/addressing/soap/fault";charset=utf-8
Date:Wed, 27 Aug 2008 19:33:51 GMT..
Connection: clos
e....
<?xml version='1.0' encoding='utf-8'?>
<soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
	<soapenv:Body>
 		<soapenv:Fault>
 			<soapenv:Code>
				<soapenv:Value>soapenv:Receiver</soapenv:Value>
</soapenv:Code><s
oapenv:Reason>
 <soapenv:Text xml:
lang="en-US">unknown</soapenv:Text></soapenv:Reason><soapenv:Det
ail /></soapenv:
Fault></soapenv:
Body></soapenv:E
nvelope>s2="http
://mobile.kenlo.
com/xsd" xmlns:n
s4="http://mobil
e.kenlo.com/Mobi
leServiceSoap12B
inding"><SOAP-EN
V:Body><ns2:getP
roductDetails><n
s2:productId xsi
:type="xsd:int">
1</ns2:productId
></ns2:getProduc
tDetails></SOAP-
ENV:Body></SOAP-
ENV:Envelope
*/


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
