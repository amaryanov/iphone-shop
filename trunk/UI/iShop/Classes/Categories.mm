/*
 *  Categories.cpp
 *  iShop
 *
 *  Created by Andrey Konovalov on 9/18/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#include "Categories.h"
#include "soapMobileServiceSoap12BindingProxy.h"
using namespace std;


CCategory::CCategory():id(-1),itemsCnt(0)
{
	for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
		arr[i]=nil;
}
CCategory::CCategory(const CCategory &cl):id(cl.id),itemsCnt(cl.itemsCnt),childs(cl.childs)
{
	for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
	{
		arr[i]=cl.arr[i];
		if(arr[i])
			[arr[i] retain];
	}
}
CCategory::CCategory(const ns2__MCategory *ct):id(-1),itemsCnt(0)
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
}

CCategory::~CCategory()
{
	for(int i=0;i<sizeof(arr)/sizeof(NSString*);i++)
	{
		if(arr[i])
			[arr[i] release];
	}
}
/****************
 *
 ****************/
CCategory *CCategory::instance=NULL;

void CCategory::buildCategs(vector<CCategory*> &category,std::vector<ns2__MCategory*> &val)
{
vector<ns2__MCategory*>::iterator iter=val.begin();
CCategory *pCt;
	for(;iter!=val.end();iter++)
	{
		if(*iter)
		{
			pCt=new CCategory(*iter);
			category.insert(category.end(),pCt);
			categoryMap.insert(pair<int,CCategory*>(pCt->id,pCt));
			buildCategs(pCt->childs,(*iter)->childCategories);
		}
	}
}
CCategory *CCategory::getInstance()
{
	if(instance == NULL)
	{
	MobileServiceSoap12Binding client;
	_ns2__getCategoryList catList;
	_ns2__getCategoryListResponse catListResp;
		catList.categoryType=new int(0);
		if( SOAP_OK == client.__ns4__getCategoryList(&catList,&catListResp) )
		{
			instance=new CCategory();
			instance->buildCategs(instance->childs,catListResp.return_);
		}
	}
	return instance;
}
CCategory *CCategory::getSubCategory(int categoryId)
{
CCategory *pRet=NULL;
	if(instance)
	{
		pRet=instance->categoryMap.find(categoryId)->second;
	}
	return pRet;
	
}
/*
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
*/