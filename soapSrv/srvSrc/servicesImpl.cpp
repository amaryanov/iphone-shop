/*
 *  servicesImpl.cpp
 *  soapSrv
 *
 *  Created by Andrey Konovalov on 13.08.08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */
#include <string>

#include "servicesImpl.h"
#include "soapStub.h"
#include <sqlite3.h>

using namespace std;
class sqliteInit
{
public:
	sqliteInit():db(NULL)
	{
		if( SQLITE_OK != sqlite3_open("../../../database/products.sqlite",&db) )
			throw std::string("Can't open database");
	}
	~sqliteInit()
	{
		if(db)
			sqlite3_close(db);
	}
public:
	sqlite3 *db;
};
void fillCategory(ns2__MCategory *pCateg,int id,sqliteInit &sqlite)
{
static const char request[]={"select type,name,imageURL from Category where id=? limit 1"};
const char *tail;
sqlite3_stmt *stmt;
const char *tmpStr;
int rc;
	rc = sqlite3_prepare(sqlite.db, request, -1, &stmt, &tail);
	if(rc == SQLITE_OK)
	{
		rc=sqlite3_bind_int(stmt,1,id);
		if(rc == SQLITE_OK)
		{
			if(sqlite3_step(stmt) == SQLITE_ROW)
			{
				pCateg->id=new int(id);
				pCateg->type=new int(sqlite3_column_int(stmt,0));
				pCateg->name=new string((const char*)sqlite3_column_text(stmt,1));
				if( ( (tmpStr=(const char*)sqlite3_column_text(stmt,2)) != NULL) && (tmpStr[0] != '\0') )
				{
					pCateg->imageURL=new string(tmpStr);
				}
				sqlite3_finalize(stmt);
			}
			else
			{
				throw string(sqlite3_errmsg(sqlite.db));
			}
		}
	}
				
}
void buildCategs(vector<ns2__MCategory*> &ret,int categoryId,sqliteInit &sqlite)
{
static const char request[]={"select categoryId from ChildCategories where parentCategoryId=?"};
const char *tail;
sqlite3_stmt *stmt;
int rc;
ns2__MCategory *pCateg;
	rc = sqlite3_prepare(sqlite.db, request, -1, &stmt, &tail);
	if(rc == SQLITE_OK)
	{
		rc=sqlite3_bind_int(stmt,1,categoryId);
		if(rc == SQLITE_OK)
		{
			for(;sqlite3_step(stmt) == SQLITE_ROW;)
			{
				categoryId=sqlite3_column_int(stmt,0);
				pCateg=new ns2__MCategory();
				ret.push_back(pCateg);
				fillCategory(pCateg,categoryId,sqlite);
				buildCategs(pCateg->childCategories,categoryId,sqlite);
			}
			sqlite3_finalize(stmt);
		}
	}
	else
	{
		throw string("Can't prepared request");
	}
}
void testPrintCategs(vector<ns2__MCategory*> val,string ident)
{
vector<ns2__MCategory*>::iterator iter=val.begin();
	for(;iter!=val.end();iter++)
	{
		cout<<ident<<"Category Id: "<<*((*iter)->id)<<endl
			<<ident<<*((*iter)->name)<<endl;
		if((*iter)->imageURL)
			cout<<ident<<*((*iter)->imageURL)<<endl;
		cout<<ident<<"--------"<<endl;
		testGetProductList(*((*iter)->id),string(ident+"\t"));
		testPrintCategs((*iter)->childCategories,string(ident+"\t"));
	}
}
void testBuildCategs()
{
vector<ns2__MCategory*> val;
sqliteInit sql;
	buildCategs(val,-1,sql);
	testPrintCategs(val,"");
}
///////////////////////////////////////////////////////////
void getProductOffers(int id,vector<ns2__MProductOffer * > &offers,sqliteInit &sqlite)
{
static const char request[]={"SELECT model,details,maunufacturer,currency,shipmentCost,productURL,price "
							 "FROM ProductOffer INNER JOIN OffersList ON OffersList.productId=? "
							 "WHERE ProductOffer.id=OffersList.productOfferId"};
const char *tail;
sqlite3_stmt *stmt;
int rc;
//int tmpInt;
const char *tmpStr;
ns2__MProductOffer *pOffer;
double tmpDbl;
	rc = sqlite3_prepare(sqlite.db, request, -1, &stmt, &tail);
	if(rc == SQLITE_OK)
	{
		rc=sqlite3_bind_int(stmt,1,id);
		if(rc == SQLITE_OK)
		{
			for(;sqlite3_step(stmt) == SQLITE_ROW;)
			{
				pOffer=new ns2__MProductOffer();
				tmpStr=(const char*)sqlite3_column_text(stmt,0);//model
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pOffer->model=new string(tmpStr);
				tmpStr=(const char*)sqlite3_column_text(stmt,1);//details
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pOffer->details=new string(tmpStr);
				tmpStr=(const char*)sqlite3_column_text(stmt,2);//manufacturer
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pOffer->manufacturer=new string(tmpStr);
				tmpStr=(const char*)sqlite3_column_text(stmt,3);//currency
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pOffer->currency=new string(tmpStr);
				tmpDbl=sqlite3_column_double(stmt,4);//shipmentCost
				pOffer->shipmentCost=new float(tmpDbl);
				tmpStr=(const char*)sqlite3_column_text(stmt,5);//productURL
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pOffer->productURL=new string(tmpStr);
				tmpDbl=sqlite3_column_double(stmt,4);//price
				pOffer->price=new float(tmpDbl);
				offers.push_back(pOffer);
			}
		}
		sqlite3_finalize(stmt);
	}
				
}
SOAP_FMAC5 int SOAP_FMAC6 __ns3__getProductDetails(struct soap*, _ns1__getProductDetails *ns1__getProductDetails, _ns1__getProductDetailsResponse *ns1__getProductDetailsResponse)
{
static const char request[]={"SELECT DetailedProduct.id,name,imageURL,"
							 "DetailedProduct.reviewURL,DetailedProduct.amazonURL "
							 "FROM Product INNER JOIN DetailedProduct ON Product.id=DetailedProduct.productId "
							 "WHERE DetailedProduct.productId=?;"};
sqliteInit sqlite;
const char *tail;
sqlite3_stmt *stmt;
int rc;
int tmpInt;
const char *tmpStr;
int retVal=SOAP_OK;
ns2__MDetailedProduct *pProduct=new ns2__MDetailedProduct();
	rc = sqlite3_prepare(sqlite.db, request, -1, &stmt, &tail);
	if(rc == SQLITE_OK)
	{
		rc=sqlite3_bind_int(stmt,1,*(ns1__getProductDetails->param0));
		if(rc == SQLITE_OK)
		{
			if(sqlite3_step(stmt) == SQLITE_ROW)
			{
				tmpInt=sqlite3_column_int(stmt,0);//id
				pProduct->id=new int(tmpInt);
				tmpStr=(const char*)sqlite3_column_text(stmt,1);//name
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pProduct->name=new string(tmpStr);
				tmpStr=(const char*)sqlite3_column_text(stmt,2);//imageURL
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pProduct->imageURL=new string(tmpStr);
				tmpStr=(const char*)sqlite3_column_text(stmt,3);//reviewURL
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pProduct->reviewURL=new string(tmpStr);
				tmpStr=(const char*)sqlite3_column_text(stmt,3);//amazonURL
				if( (tmpStr) && (tmpStr[0] != '\0') )
					pProduct->amazonURL=new string(tmpStr);
				getProductOffers(tmpInt,pProduct->offers,sqlite);
			}
		}
		sqlite3_finalize(stmt);
	}
	ns1__getProductDetailsResponse->return_=pProduct;
	
	return retVal;
}
///////////////////////////////////////////////////////////////
SOAP_FMAC5 int SOAP_FMAC6 __ns3__getCategoryList(struct soap*, _ns1__getCategoryList *ns1__getCategoryList, _ns1__getCategoryListResponse *pRes)
{
int retVal=SOAP_OK;
	try
	{
	sqliteInit sqlite;
		buildCategs(pRes->return_,-1,sqlite);
		testPrintCategs(pRes->return_,"");
	}
	catch(string &str)
	{
		cout<<str<<endl;
		retVal=SOAP_ERR;
	}
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns3__getBusinessList(struct soap*, _ns1__getBusinessList *ns1__getBusinessList, _ns1__getBusinessListResponse *ns1__getBusinessListResponse)
{
int retVal=SOAP_OK;
	return retVal;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
void buildProductList(vector<class ns2__MProduct * > &retVal,int categId,sqliteInit &sql)
{
static const char request[]={"select id,name,imageURL from Product where categoryId=?"};
const char *tail;
sqlite3_stmt *stmt;
int rc;
ns2__MProduct *pProduct;
const char *tmpStr;
	rc = sqlite3_prepare(sql.db, request, -1, &stmt, &tail);
	if(rc == SQLITE_OK)
	{
		rc=sqlite3_bind_int(stmt,1,categId);
		if(rc == SQLITE_OK)
		{
			for(;sqlite3_step(stmt) == SQLITE_ROW;)
			{
				pProduct=new ns2__MProduct();
				pProduct->id=new int(sqlite3_column_int(stmt,0));
				pProduct->name=new string((const char*)sqlite3_column_text(stmt,1));
				if( ( (tmpStr=(const char*)sqlite3_column_text(stmt,2)) != NULL) && (tmpStr[0] != '\0') )
				{
					pProduct->imageURL=new string(tmpStr);
				}
				retVal.push_back(pProduct);
			}
			sqlite3_finalize(stmt);
		}
		else
		{
			throw string(sqlite3_errmsg(sql.db));
		}
	}
	else
	{
		throw string(sqlite3_errmsg(sql.db));
	}
}
void testPrintProductList(vector<class ns2__MProduct *> &retVal,string footer)
{
vector<class ns2__MProduct *>::iterator iter;
	for(iter=retVal.begin();iter!=retVal.end();iter++)
	{
		cout<<footer<<"Product id: "<<*((*iter)->id)<<endl
		<<footer<<*((*iter)->name)<<endl;
		if((*iter)->imageURL)
			cout<<(*(*iter)->imageURL)<<endl;
		cout<<footer<<"++++++++++++++"<<endl;
	}
}
void testGetProductList(int categId,string footer)
{
vector<class ns2__MProduct *> retVal;
	try
	{
	sqliteInit sqlite;
		buildProductList(retVal,categId,sqlite);
		testPrintProductList(retVal,footer);
	}
	catch(std::string &err)
	{
		cout<<err<<endl;
	}
}
SOAP_FMAC5 int SOAP_FMAC6 __ns3__getProductList(struct soap*, _ns1__getProductList *ns1__getProductList, _ns1__getProductListResponse *ns1__getProductListResponse)
{
int retVal=SOAP_OK;
	try
	{
	sqliteInit sqlite;
		buildProductList(ns1__getProductListResponse->return_,*ns1__getProductList->param0,sqlite);
		testPrintProductList(ns1__getProductListResponse->return_,"");
	}
	catch(std::string &err)
	{
		cout<<err<<endl;
		retVal=SOAP_ERR;
	}
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns3__getBusinessDetails(struct soap*, _ns1__getBusinessDetails *ns1__getBusinessDetails, _ns1__getBusinessDetailsResponse *ns1__getBusinessDetailsResponse)
{
int retVal=SOAP_OK;
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns4__getProductDetails(struct soap*, _ns1__getProductDetails *ns1__getProductDetails, _ns1__getProductDetailsResponse *ns1__getProductDetailsResponse)
{
int retVal=SOAP_OK;
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns4__getCategoryList(struct soap*, _ns1__getCategoryList *ns1__getCategoryList, _ns1__getCategoryListResponse *ns1__getCategoryListResponse)
{
int retVal=SOAP_OK;
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns4__getBusinessList(struct soap*, _ns1__getBusinessList *ns1__getBusinessList, _ns1__getBusinessListResponse *ns1__getBusinessListResponse)
{
int retVal=SOAP_OK;
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns4__getProductList(struct soap*, _ns1__getProductList *ns1__getProductList, _ns1__getProductListResponse *ns1__getProductListResponse)
{
int retVal=SOAP_OK;
	return retVal;
}

SOAP_FMAC5 int SOAP_FMAC6 __ns4__getBusinessDetails(struct soap*, _ns1__getBusinessDetails *ns1__getBusinessDetails, _ns1__getBusinessDetailsResponse *ns1__getBusinessDetailsResponse)
{
int retVal=SOAP_OK;
	return retVal;
}

