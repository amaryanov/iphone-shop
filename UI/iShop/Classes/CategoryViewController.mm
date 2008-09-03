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
//#include "soapIMobileSoap12BindingProxy.h"
#include "soapMobileServiceSoap12BindingProxy.h"


class CCategory
{
public:
	CCategory():id(-1),itemsCnt(0)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
			arr[i]=nil;
	}
	CCategory(const CCategory &cl):id(cl.id),itemsCnt(cl.itemsCnt),childs(cl.childs)
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			arr[i]=cl.arr[i];
			if(arr[i])
				[arr[i] retain];
		}
	}
	~CCategory()
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		{
			if(arr[i])
				[arr[i] release];
		}
	}
	CCategory &operator =(const ns2__MCategory *ct)
	{
		this->id=*(ct->id);
		if(ct->totalItems)
			itemsCnt=*(ct->totalItems);
		name=[[NSString stringWithUTF8String:ct->name->c_str()] retain];
		if(itemsCnt != 0)
			title=[[NSString stringWithFormat:@"%s (%d)",ct->name->c_str(),itemsCnt] retain];
		else
			title=[[NSString stringWithUTF8String:ct->name->c_str()] retain];
		if(ct->imageURL)
			imageUrl=[[NSString stringWithUTF8String:ct->imageURL->c_str()] retain];
		return *this;
	}
	int id;
	int itemsCnt;
	union
	{
		struct
		{
			NSString *name;
			NSString *title;
			NSString *imageUrl;
		};
		NSString *arr[3];
	};
	std::vector<CCategory> childs;
};
class CCategories
{
public:
	CCategories(){}
	std::vector<CCategory> categs;
};
using namespace std;
void printCategs(std::vector<CCategory> &category,std::string ident);

@implementation CategoryViewController


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
	if(pCategs)
		retVal=pCategs->categs.size();
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
		[categCell.name setText:pCategs->categs[indexPath.row].name];
		if(pCategs->categs[indexPath.row].imageUrl)
		{
			[categCell loadingImage:pCategs->categs[indexPath.row].imageUrl];
		}
		if(pCategs->categs[indexPath.row].childs.size() == 0)
		{
			[categCell.productsCount setText:[NSString stringWithFormat:@"(%d)", pCategs->categs[indexPath.row].itemsCnt]];
		}
		[categCell placeProductCounts];
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
		if(pCategs->categs[indexPath.row].childs.size())
		{
		CategoryViewController *root;
			root=[[CategoryViewController alloc] initWithNibName:self.nibName bundle:nil];
			root->pCategs=new CCategories();
			root->pCategs->categs=pCategs->categs[indexPath.row].childs;
//			printCategs(pCategs->categs,"");
			[[root navigationItem] setTitle:pCategs->categs[indexPath.row].title];
			[[self navigationController] navigationBar].backItem.title=@"Back";
			[[self navigationController] pushViewController:root animated:YES];
		}
		else
		{
		ProductViewController *prods;
			prods=[[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
			prods.categoryId=pCategs->categs[indexPath.row].id;
			prods.itemsCnt=pCategs->categs[indexPath.row].itemsCnt;
			[prods.navigationItem setTitle:pCategs->categs[indexPath.row].title];
			[prods.navigationItem leftBarButtonItem].title=@"Back";
			[[self navigationController] pushViewController:prods animated:YES];
		}
	}
}


/*
// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
*/
void printCategs(vector<CCategory> &category,string ident)
{
vector<CCategory>::iterator iter=category.begin();
	for(;iter!=category.end();iter++)
	{
		cout<<ident<<iter->id<<endl
			<<ident<<iter->name<<endl
			<<ident<<"--------------"<<endl;
		printCategs(iter->childs,string(ident+"\t"));
	}
}

// If you need to do additional setup after loading the view, override viewDidLoad.
void buildCategs(vector<CCategory> &category,vector<ns2__MCategory*> &val)
{
vector<ns2__MCategory*>::iterator iter=val.begin();
CCategory ct;
	for(;iter!=val.end();iter++)
	{
		if(*iter)
		{
			ct=*iter;
			buildCategs(category.insert(category.end(),ct)->childs,(*iter)->childCategories);
		}
	}
}

- (void)viewDidLoad 
{
	if(pCategs == NULL)
	{
	MobileServiceSoap12Binding client;
	_ns2__getCategoryList catList;
	_ns2__getCategoryListResponse catListResp;

		catList.categoryType=new int(0);
		if( SOAP_OK == client.__ns4__getCategoryList(&catList,&catListResp) )
		{
			pCategs=new CCategories();
			buildCategs(pCategs->categs,catListResp.return_);
//			printCategs(pCategs->categs,"");
		}
		[self.navigationItem setTitle:@"Categories"];
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
