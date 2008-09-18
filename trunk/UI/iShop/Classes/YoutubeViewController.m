//
//  RootViewController.m
//  iShop
//
//  Created by Andrey Konovalov on 05.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "YoutubeViewController.h"



@implementation YoutubeViewController


- (GDataServiceGoogleYouTube *)youTubeService {
    static GDataServiceGoogleYouTube *service = nil;
    if (!service) {
        service = [[GDataServiceGoogleYouTube alloc] init];
        //[service setShouldCacheDatedData:YES];
		//[service setAuthToken:@"AIwbFAT5d7FIz8ZMy158BEM9eGNRMnodkPtAh2BrxyNx3gksiu95lNW5z9abJoabSmeIQUztXcghhqCw-wxQ9pst1SU5DV0SH1IQNr8KeOCWAVi78WB13S7BxkzYYxATWgaYJyk2Jz214F2icTfV37XavhH39acp5QPa4LwwnZvWJR_y9layHCI"];
    }
    return service;
}
- (void)entryListFetchTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedBase *)feed {
    self->vfeed = (GDataEntryBase*)feed;
	[feed retain];
	[[self view] reloadData];
    /*int i;
    for (i = 0; i < [[vfeed entries] count]; i++) {
        GDataEntryBase *entry = [[vfeed entries] objectAtIndex:i];
		printf("Index of tapped item: %d\r\n", i);
        NSLog(@"Title: %@", [[entry title] stringValue]);
    }*/
}

- (void)entryListFetchTicket:(GDataServiceTicket *)ticket failedWithError:(NSError *)error {
    NSLog(@"Error %@", error);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}
/****************************************
 * UITableViewDelegate Protocol Reference
 ****************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	if(vfeed != nil)
	{
        cell.text = [[vfeed title] stringValue];
	}
	// Configure the cell
	return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
UITableViewCellAccessoryType retVal=UITableViewCellAccessoryDetailDisclosureButton;
	return retVal;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
/*RootViewController *root;
	root=[[RootViewController alloc] initWithNibName:self.nibName bundle:self.nibBundle];
	//[targetViewController setDelegate:prefControl];
	[[self navigationController] pushViewController:root animated:YES];
 */        
	//GDataEntryBase *entry = [[vfeed entries] objectAtIndex:indexPath.row];
	if (![vfeed respondsToSelector:@selector(mediaGroup)]) return;
	GDataEntryYouTubeVideo *video = (GDataEntryYouTubeVideo *)vfeed;
	NSString *url = [[[[video mediaGroup] mediaContents] objectAtIndex:0] URLString];
	mMovieURL = [NSURL URLWithString:url];
	[mMovieURL retain];
	[self initMoviePlayer];
    
    [mMoviePlayer play];
	NSLog(url);
}

-(void)initMoviePlayer
{
    /*
	 
	 Because it takes time to load movie files into memory, MPMoviePlayerController
	 automatically begins loading your movie file shortly after you initialize a new 
	 instance. When it is done preloading the movie file, it sends the
	 MPMoviePlayerContentPreloadDidFinishNotification notification to any registered 
	 observers. If an error occurred during loading, the userInfo dictionary of the 
	 notification object contains the error information. If you call the play method 
	 before preloading is complete, no notification is sent and your movie begins 
	 playing as soon as it is loaded into memory.
	 
	 */
	
    // Register to receive a notification when the movie is in memory and ready to play.
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePreloadDidFinish:) 
												 name:MPMoviePlayerContentPreloadDidFinishNotification 
											   object:nil];
    /*
	 
	 Now create a MPMoviePlayerController object using the movie file provided in our bundle.
	 
	 The MPMoviePlayerController class supports any movie or audio files that already play 
	 correctly on an iPod or iPhone. For movie files, this typically means files with the extensions 
	 .mov, .mp4, .mpv, and .3gp and using one of the following compression standards:
	 
	 - H.264 Baseline Profile Level 3.0 video, up to 640 x 480 at 30 fps. Note that B frames 
	 are not supported in the Baseline profile.
	 
	 - MPEG-4 Part 2 video (Simple Profile)
	 
	 If you use this class to play audio files, it displays a black screen while the audio plays. For 
	 audio files, this class class supports AAC-LC audio at up to 48 kHz.
	 
	 */
	
    mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[self movieURL]];
	
    /*
	 In addition to the MPMoviePlayerContentPreloadDidFinishNotification notification,
	 the MPMoviePlayerPlaybackDidFinishNotification notification is sent to
	 registered observers when the movie has finished playing, and the 
	 MPMoviePlayerScalingModeDidChangeNotification notification is sent when the 
	 movie scaling mode has changed.
	 */
    
    // Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:mMoviePlayer];
	
    // Register to receive a notification when the movie scaling mode has changed. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(movieScalingModeDidChange:) 
												 name:MPMoviePlayerScalingModeDidChangeNotification 
											   object:mMoviePlayer];
	
    /* Set movie player settings (scaling, controller type and background color) to the currently set values
	 as specified in the Settings application */
	
    /* 
	 Movie scaling mode can be one of: MPMovieScalingModeNone, MPMovieScalingModeAspectFit,
	 MPMovieScalingModeAspectFill, MPMovieScalingModeFill.
	 */
    
    /* 
	 Movie control mode can be one of: MPMovieControlModeDefault, MPMovieControlModeVolumeOnly,
	 MPMovieControlModeHidden.
	 */
	
    /*
	 The color of the background area behind the movie can be any UIColor value.
	 */
	
}

// return a URL for the movie file in our bundle
-(NSURL *)movieURL
{
    return mMovieURL;
}


// Implement loadView if you want to create a view hierarchy programmatically
/*- (void)loadView {
	self->vfeed = nil;
	[super loadView];
}*/


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad 
{
    GDataServiceTicket *ticket;
	self.navigationItem.title=@"Youtube";
	GDataServiceGoogleYouTube *service = [self youTubeService];
	
    //NSURL *feedURL = [GDataServiceGoogleYouTube youTubeURLForFeedID:@"recently_featured"];
	NSURL *feedURL = [GDataServiceGoogleYouTube youTubeURLForVideoID:@"GJOjrpaVZpk"];
	//NSLog([videoFeedUrl absoluteString]);
    ticket = [service fetchYouTubeFeedWithURL:feedURL
                                     delegate:self
                            didFinishSelector:@selector(entryListFetchTicket:finishedWithFeed:)
                              didFailSelector:@selector(entryListFetchTicket:failedWithError:)];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
	[vfeed release];
	
    //[mMovieURL release];
    
    // remove movie notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerContentPreloadDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:mMoviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerScalingModeDidChangeNotification
                                                  object:mMoviePlayer];
	
    // free our movie player
    //[mMoviePlayer release];
}
//  Notification called when the movie finished preloading.
- (void) moviePreloadDidFinish:(NSNotification*)notification
{
    /* 
	 < add your code here >
	 */
}

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	[mMoviePlayer release];
}

//  Notification called when the movie scaling mode has changed.
- (void) movieScalingModeDidChange:(NSNotification*)notification
{
    /* 
	 < add your code here >
	 
	 For example:
	 MPMoviePlayerController* theMovie=[aNotification object];
	 etc.
	 */
}


@end
