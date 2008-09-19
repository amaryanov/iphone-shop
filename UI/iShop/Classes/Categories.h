/*
 *  Categories.h
 *  iShop
 *
 *  Created by Andrey Konovalov on 9/18/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef _CATEGORY_CLASS_IMPL_
#define _CATEGORY_CLASS_IMPL_
#import <UIKit/UIKit.h>

#include <vector>
#include <map>

class ns2__MCategory;
class CCategory
{
public:
	static CCategory *getInstance();
	static CCategory *getSubCategory(int categoryId);
	~CCategory();
	
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
	std::vector<CCategory*> childs;
private:
	CCategory();
	CCategory(const CCategory &cl);
	CCategory(const ns2__MCategory *ct);
	void buildCategs(std::vector<CCategory*> &category,std::vector<ns2__MCategory*> &val);
	
	std::map<int,CCategory*> categoryMap;
	static CCategory *instance;
};
#endif
