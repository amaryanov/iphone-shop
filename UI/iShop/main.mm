//
//  main.m
//  iShop
//
//  Created by Anton Maryanov on 8/4/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "soapMobile/IMobileSoap12Binding.nsmap"
//#include "remoteSoap/MobileServiceSoap12Binding.nsmap"

int main(int argc, char *argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, nil);
	[pool release];
	return retVal;
}

