//
//  main.m
//  iShop
//
//  Created by Anton Maryanov on 8/4/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
//#include "soapMobile/IMobileSoap12Binding.nsmap"
#include "soapRemote/MobileServiceSoap12Binding.nsmap"
#include <iostream>
using namespace std;
int main(int argc, char *argv[]) {
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
NSArray *arr=[UIFont familyNames];
NSArray *names;
NSString *str;
	for(NSEnumerator *en=[arr objectEnumerator];(str=[en nextObject]);)
	{
//		cout<<"Family name-------- "<<[str UTF8String]<<endl;
		names=[UIFont fontNamesForFamilyName:str];
		for(NSEnumerator *en2=[names objectEnumerator];(str=[en2 nextObject]);)
			cout<<"\""<<[str UTF8String]<<"\",";
	}
	int retVal = UIApplicationMain(argc, argv, nil, nil);
	[pool release];
	return retVal;
}

