/*
 *  YTAuth.h
 *  certtest
 *
 *  Created by Anton Maryanov on 9/13/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */
#import "NSData-Base64Extensions.h"
#import "NSString-Base64Extensions.h"
@interface YTAuth : NSObject {
}
+ (NSString*) getToken;
+ (NSData*) signTheData:(NSData*) data;
@end
