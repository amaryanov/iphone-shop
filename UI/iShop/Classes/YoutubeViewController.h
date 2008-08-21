//
//  RootViewController.h
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "GDataYouTube.h"
#import <MediaPlayer/MediaPlayer.h>

@interface YoutubeViewController : UIViewController {
    MPMoviePlayerController *mMoviePlayer;
	GDataEntryBase *vfeed;
    NSURL *mMovieURL;
}
-(NSURL *)movieURL;
- (GDataServiceGoogleYouTube *)youTubeService;
-(void)initMoviePlayer;
-(IBAction)playMovie:(id)sender;

@end
