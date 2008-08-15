//
//  RootViewController.m
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#include <iostream>

#import "RootViewController.h"
#include "soapIMobileSoap12BindingProxy.h"

class CCategory
{
public:
	CCategory():ref(1){}
	CCategory(const CCategory &cl):id(cl.id),name(cl.name),imageUrl(cl.imageUrl),childs(cl.childs),ref(cl.ref+1)
	{
	}
	CCategory &operator =(const ns2__MCategory *ct)
	{
		this->id=*(ct->id);
		name=*(ct->name);
		if(ct->imageURL)
			imageUrl=*(ct->imageURL);
		return *this;
	}
	int id;
	std::string name;
	std::string imageUrl;
	std::vector<CCategory> childs;
protected:
	int ref;
};
class CCategories
{
public:
	CCategories():next(NULL),parent(NULL){}
	std::vector<CCategory> categs;
	std::vector<CCategory>::iterator currIter;
	CCategories *next;
	CCategories *parent;
};
using namespace std;
void printCategs(std::vector<CCategory> &category,std::string ident);
@implementation RootViewController

@synthesize myDinamicalyTable;

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return pCategs->categs.size();
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
static NSString *MyIdentifier = @"MyIdentifier";
NSString *str;
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) 
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	// Configure the cell
//	in
	if(pCategs)
	{
		cout<<indexPath.row<<endl<<pCategs->categs[indexPath.row].name<<endl;;
		str=[NSString stringWithUTF8String:pCategs->categs[indexPath.row].name.c_str()];
		[cell setText:str];
//		[str release];
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
RootViewController *root;

	//[targetViewController setDelegate:prefControl];
	if(pCategs->categs.size() > indexPath.row)
	{
		root=[[RootViewController alloc] initWithNibName:self.nibName bundle:nil];
		root->pCategs=new CCategories();
		root->pCategs->categs=pCategs->categs[indexPath.row].childs;
//		printCategs(pCategs->categs,"");
		[[root navigationItem] setTitle:[NSString stringWithUTF8String:pCategs->categs[indexPath.row].name.c_str()]];
		[[self navigationController] pushViewController:root animated:YES];
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
		ct=*iter;
//		category.insert(category.end(),ct)
		buildCategs(category.insert(category.end(),ct)->childs,(*iter)->childCategories);
	}
}

- (void)viewDidLoad 
{
	if(pCategs == NULL)
	{
	IMobileSoap12Binding client;
	_ns1__getCategoryList *catList=new _ns1__getCategoryList();
	static _ns1__getCategoryListResponse *catListResp=new _ns1__getCategoryListResponse();

		catList->param0=new int(-1);
		if( SOAP_OK == client.__ns4__getCategoryList(catList,catListResp) )
		{
			pCategs=new CCategories();
			buildCategs(pCategs->categs,catListResp->return_);
			printCategs(pCategs->categs,"");
		}
		[self.navigationItem setTitle:@"Root"];
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
