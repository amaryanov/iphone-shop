//
//  OffersTableDelegate.m
//  iShop
//
//  Created by Andrey Konovalov on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OffersTable.h"
#import "OffersViewCell.h"

#include <vector>
#include "soapMobileServiceSoap12BindingProxy.h"
class CProductOffer
{
public:
	CProductOffer():id(-1),total(0),rating(0)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
			arr[i]=nil;
	}
	CProductOffer(const CProductOffer &po):id(po.id),total(po.total),rating(po.rating)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			arr[i]=po.arr[i];
			if(arr[i])
				[arr[i] retain];
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
			NSString *logoURL;
			NSString *price;
			NSString *shipping;
			NSString *totalStr;
			NSString *storeUrl;
			NSString *details;
		};
		NSString *arr[6];
	};
	int			id;
	float		total;
	float		rating;
private:
	void copyMemebers(const ns2__MProductOffer *pMp)
	{
		this->id=*pMp->id;
		price=[[NSString stringWithFormat:@"Price: %1.2f₪",*pMp->price] retain];
		total=*pMp->price;
		shipping=[[NSString stringWithFormat:@"Shipping: %1.2f₪",*pMp->shipmentCost] retain];
		total+=*pMp->shipmentCost;
		totalStr=[[NSString stringWithFormat:@"Total: %1.2f₪",total] retain];
		logoURL=[[NSString stringWithCString:pMp->businessLogo->c_str()] retain];
		storeUrl=[[NSString stringWithCString:pMp->productURL->c_str()] retain];
		rating=*pMp->businessRating;
	}
};
@interface OffersTable(PrivateMethods)
	std::vector<CProductOffer> offers;
@end

@implementation OffersTable
//delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffersViewCellId"];
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
		[offCell.price setText:offers[indexPath.row].price];
		[offCell.shipping setText:offers[indexPath.row].shipping];
		[offCell.total setText:offers[indexPath.row].totalStr];
		[offCell setRating:offers[indexPath.row].rating];
		[offCell loadingImage:offers[indexPath.row].logoURL];
		[offCell configureLabels];
	}
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"Section %d, size %d",section,offers.size());
	return offers.size();
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[NSString stringWithString:@"Price"] retain];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	[but setFrame:CGRectMake(0, 0, 310, 27)];
	[but setTitle:@"Price from button" forState:UIControlStateNormal];
	return but;
}
//////
-(void) setOffers:(void */*std::vector<ns2__MProductOffer * >**/)offersVector
{
std::vector<ns2__MProductOffer * > *vect=(std::vector<ns2__MProductOffer * > *)offersVector;
std::vector<ns2__MProductOffer * >::const_iterator iter=vect->begin();
	for(;iter!=vect->end();iter++)
	{
		offers.push_back(*iter);
	}
	
}

@end
