//
//  TestYoutube.h
//  iShop
//
//  Created by Anton Maryanov on 8/22/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataYouTube.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MyYouTube : NSObject
{
	NSString *movieId;
	id objToPost;
}

-(MyYouTube*)initWithYoutubeUrl:(NSString*)urlString postToObject:(id)objToPost;
+ (GDataServiceGoogleYouTube *)youTubeService;

@end

@interface TestYoutube : UIViewController {
	IBOutlet UITextField* txt;
}
- (IBAction) loadMovie:(id)sender;
@property(retain, nonatomic) UITextField* txt;
@end
