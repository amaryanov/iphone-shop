/*
 *  Categories.h
 *  iShop
 *
 *  Created by Andrey Konovalov on 9/18/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */
#import <UIKit/UIKit.h>

#include <vector>
#include <map>

class ns2__MCategory;
class CCategory
{
public:
	CCategory();
	CCategory(const CCategory &cl);
	CCategory(const ns2__MCategory *ct);
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
};

class CCategories
{
public:
	CCategories(){}
	void buildCategs(std::vector<CCategory*> &category,std::vector<ns2__MCategory*> &val);

	std::vector<CCategory*> categs;
	std::map<int,CCategory*> categoryMap;
};
