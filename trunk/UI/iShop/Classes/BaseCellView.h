//
//  BaseCellView.h
//  iShop
//
//  Created by Andrey Konovalov on 27.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef RGB
	#define RGB(x) (((float)x)/255)
#endif

@class GDataHTTPFetcher;
@interface BaseCellView : UITableViewCell
{

	IBOutlet UIActivityIndicatorView *indicator;
}
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

- (void) loadingImage:(NSString *)urlStr;
- (void)imageFetcher:(GDataHTTPFetcher *)fetcher finishedWithData:(NSData *)data;
- (void)imageFetcher:(GDataHTTPFetcher *)fetcher failedWithStatus:(int)status data:(NSData *)data;
- (void)imageFetcher:(GDataHTTPFetcher *)fetcher failedWithError:(NSError *)error;

@end
