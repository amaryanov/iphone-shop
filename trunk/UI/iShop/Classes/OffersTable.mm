//
//  OffersTableDelegate.m
//  iShop
//
//  Created by Andrey Konovalov on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OffersTable.h"
#import "OffersViewCell.h"
#import "ShopDetailViewController.h"
#import "OffersSortCell.h"
#import "OffersSortController.h"

#include <vector>
#include "soapMobileServiceSoap12BindingProxy.h"
class CProductOffer
{
public:
	CProductOffer():id(-1),price(0),shipping(0),total(0),rating(0)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
			arr[i]=nil;
	}
	CProductOffer(const CProductOffer &po):id(po.id),price(po.price),shipping(po.shipping),total(po.total),rating(po.rating)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			arr[i]=po.arr[i];
			if(arr[i])
			{
				[arr[i] retain];
//				NSLog(@"Retain: %d %d %@",i,[arr[i] retainCount],arr[i]);
			}
		}
	}
	CProductOffer(const ns2__MProductOffer *pMp)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
			arr[i]=nil;
		if(pMp)
			copyMemebers(pMp);
	}
	~CProductOffer()
	{

		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			if(arr[i])
			{
//				NSLog(@"Release: %d %d %@",i,[arr[i] retainCount],arr[i]);
				[arr[i] release];
			}
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
			NSString *logoURL;
			NSString *priceStr;
			NSString *shippingStr;
			NSString *totalStr;
			NSString *storeUrl;
			NSString *details;
		};
		NSString *arr[6];
	};
	int			id;
	float		price;
	float		shipping;
	float		total;
	float		rating;
private:
	void copyMemebers(const ns2__MProductOffer *pMp)
	{
		this->id=*pMp->id;
		total=*pMp->price;
		total+=*pMp->shipmentCost;
		price=*pMp->price;
		shipping=*pMp->shipmentCost;
		rating=*pMp->businessRating;
		if(pMp->businessLogo)
			logoURL=[[NSString stringWithCString:pMp->businessLogo->c_str()] retain];
		if(pMp->price)
			priceStr=[[NSString stringWithFormat:@"Price: %1.2f₪",*pMp->price] retain];
		if(pMp->shipmentCost)
			shippingStr=[[NSString stringWithFormat:@"Shipping: %1.2f₪",*pMp->shipmentCost] retain];
		if(pMp->productURL)
			storeUrl=[[NSString stringWithCString:pMp->productURL->c_str()] retain];
		totalStr=[[NSString stringWithFormat:@"Total: %1.2f₪",total] retain];
	}
};
class COffersComparator
{
public:
	typedef enum{byPrice=0,byShipping,byTotal} compareType;
	COffersComparator(compareType ct):ct(ct){}
	bool operator() (const CProductOffer &a,const CProductOffer &b)
	{
	bool retVal=false;
		switch(ct)
		{
			case byPrice:
				retVal=a.price < b.price;
				break;
			case byShipping:
				retVal=a.shipping < b.shipping;
				break;
			case byTotal:
				retVal=a.total < b.total;
				break;
		}
		return retVal;
	}
private:
	compareType ct;
};
@interface OffersTable(PrivateMethods)
	COffersComparator::compareType cmpType;
	std::vector<CProductOffer> *pOffers;
	float minPrice;
	int totalWithMinPrice;
@end
@implementation OffersTable
@synthesize parentController;
@synthesize sortCell,tableHeader,headerLabel;

//delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
NSInteger row=indexPath.row;
UITableViewCell *cell;
	if(row == 0)
	{
		cell=sortCell;
	}
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:@"OffersViewCellId"];
		row--;
		if (cell == nil) 
		{
		NSArray *topObjs;
			topObjs =  [[NSBundle mainBundle] loadNibNamed:@"OffersCell" owner:self options:nil];
			if(topObjs)
			{
				cell=[topObjs objectAtIndex:1];
			}
		}
		if(cell)
		{
		OffersViewCell *offCell=(OffersViewCell *)cell;
			[offCell.price setText:pOffers->at(row).priceStr];
			[offCell.shipping setText:pOffers->at(row).shippingStr];
			[offCell.total setText:pOffers->at(row).totalStr];
			[offCell setRating:pOffers->at(row).rating];
			[offCell loadingImage:pOffers->at(row).logoURL];
			[offCell configureLabels];
		}
	}
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
NSInteger cnt=0;
	if( (pOffers) && (cnt=pOffers->size()) )
		cnt++;
	return cnt;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
NSString *ret;
	if( (pOffers == NULL) || (pOffers->size() == 0) )
	{
		ret=[NSString stringWithString:@"Currently this product is not available for sale"];
	}
	else
	{
		ret=[NSString stringWithFormat:@"%d Seller%s from %1.2f₪",pOffers->size(),((totalWithMinPrice > 1)?"s":""),minPrice];
	}
	return ret;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if( (pOffers == NULL) || (pOffers->size() == 0) )
	{
		[headerLabel setText:[NSString stringWithString:@"Currently this product is not available for sale"]];
	}
	else
	{
		[headerLabel setText:
		 [NSString stringWithFormat:@"%d Seller%s from %1.2f₪",pOffers->size(),((totalWithMinPrice > 1)?"s":""),minPrice]];
	}
	
	[headerLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.5]];
	[headerLabel setTextColor:[UIColor colorWithRed:RGB(50) green:RGB(79) blue:RGB(133) alpha:1.0]];
	
	return tableHeader;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 0)
	{
	OffersSortController *sort;
		sort=[[OffersSortController alloc] initWithNibName:@"OffersSortController" bundle:nil];
		[sort.navigationItem setTitle:@"Sorting By"];
		sort.tableDelegate=self;
		sort.selectedRow=cmpType;
		[[parentController navigationController] pushViewController:sort animated:YES];
	}
	else
	{
	ShopDetailViewController *shop;
	int	row=indexPath.row-1;
		shop=[[ShopDetailViewController alloc] initWithNibName:@"ShowShopDetail" bundle:nil];
		shop.url=pOffers->at(row).storeUrl;
		shop.name=pOffers->at(row).storeUrl;
		[[parentController navigationController] pushViewController:shop animated:YES];
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
CGFloat retVal=68;
	if(indexPath.row == 0)
		retVal=sortCell.frame.size.height;
	
	return retVal;
}
//////
-(void) setOffers:(void */*std::vector<ns2__MProductOffer * >**/)offersVector
{
std::vector<ns2__MProductOffer * > *vect=(std::vector<ns2__MProductOffer * > *)offersVector;
std::vector<ns2__MProductOffer * >::const_iterator iter=vect->begin();
	minPrice=0;
	totalWithMinPrice=0;
	pOffers=new std::vector<CProductOffer>();
	for(;iter!=vect->end();iter++)
	{
	CProductOffer tmp(*iter);
		pOffers->push_back(*iter);
		if(tmp.total == minPrice)
		{
			totalWithMinPrice++;
		}
		else if((tmp.total < minPrice) || (minPrice == 0) )
		{
			minPrice=tmp.total;
			totalWithMinPrice=1;
		}
	}
	[sortCell.label setText:@"Price"];
	[sortCell initLabelsFont];
	cmpType=COffersComparator::byPrice;
	NSLog(@"===== Sorting ======");
	std::sort(pOffers->begin(),pOffers->end(),COffersComparator(COffersComparator::byPrice));
}
-(void) setSortingType:(NSInteger)type
{
	switch(type)
	{
		case COffersComparator::byPrice:
			[sortCell.label setText:@"Price"];
			std::sort(pOffers->begin(),pOffers->end(),COffersComparator(COffersComparator::byPrice));
			break;
		case COffersComparator::byShipping:
			[sortCell.label setText:@"Shipping"];
			std::sort(pOffers->begin(),pOffers->end(),COffersComparator(COffersComparator::byShipping));
			break;
		case COffersComparator::byTotal:
			[sortCell.label setText:@"Total"];
			std::sort(pOffers->begin(),pOffers->end(),COffersComparator(COffersComparator::byTotal));
			break;
	}
	cmpType=(COffersComparator::compareType)type;
	[self reloadData];
}
-(void) eraseData
{
	if(pOffers)
	{
		delete pOffers;
		pOffers=NULL;
	}
}
-(void) dealloc
{
	if(pOffers)
		delete pOffers;
	[super dealloc];
}


@end
