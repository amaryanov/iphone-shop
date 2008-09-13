//
//  ProductDetailsViewCotroller.mm
//  iShop
//
//  Created by Andrey Konovalov on 20.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductDetailCellView.h"
#import "ProductDescriptCellView.h"
#import "OffersTable.h"

#import "ShopDetailViewController.h"

#include "soapMobileServiceSoap12BindingProxy.h"
using namespace std;
class CProductDataContainer
{
public:
	CProductDataContainer()
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSObject*);i++)
			arr[i]=nil;
	}
	~CProductDataContainer()
	{
		for(int i=0;i<sizeof(arr)/sizeof(NSObject*);i++)
			if(arr[i])
				[arr[i] release];
	}
	CProductDataContainer &operator = (const ns2__MDetailedProduct *pProd)
	{
		if(pProd->id)
			this->id=*(pProd->id);
		if(pProd->details)
			details=[NSString stringWithUTF8String:pProd->details->c_str()];
		if(pProd->features.size())
		{
		std::vector<std::string >::const_iterator iter;
			features=[[NSMutableString alloc] init];
			for(iter=pProd->features.begin();iter!=pProd->features.end();iter++)
			{
				[features appendString:@"• "];
				[features appendString:[NSString stringWithUTF8String:iter->c_str()]];
				[features appendString:@"\r"];
			}
		}
		if(pProd->rating)
			rating=*(pProd->rating);
		if(pProd->name)
			name=[NSString stringWithUTF8String:pProd->name->c_str()];
		if(pProd->imageURL)
			imageURL=[NSString stringWithUTF8String:pProd->imageURL->c_str()];
		if(pProd->amazonURL)
			amazonURL=[NSString stringWithUTF8String:pProd->amazonURL->c_str()];
		if(pProd->reviewURL)
			reviewURL=[NSString stringWithUTF8String:pProd->reviewURL->c_str()];
		if(pProd->videoURL)
			videoURL = [NSString stringWithUTF8String:pProd->videoURL->c_str()];
		if(pProd->highlight1)
			highlight1=[NSString stringWithUTF8String:pProd->highlight1->c_str()];
		if(pProd->highlight2)
			highlight2=[NSString stringWithUTF8String:pProd->highlight2->c_str()];
		if(pProd->galleryImageUrls.size())
		{
		std::vector<std::string >::const_iterator linksIter;
			galleryImageUrls=[NSMutableArray arrayWithCapacity:pProd->galleryImageUrls.size()];
			for(linksIter=pProd->galleryImageUrls.begin();linksIter != pProd->galleryImageUrls.end();linksIter++)
			{
				if(linksIter->length())
					[galleryImageUrls addObject:[NSString stringWithUTF8String:linksIter->c_str()]];
			}
		}
			
		return *this;
	}
public:
	int id;
	int stores;
	float rating;
	union
	{
		struct
		{
			NSString *name;
			NSString *imageURL;
			NSString *highlight1;
			NSString *highlight2;
			NSString *details;
			NSString *videoURL;
			NSString *amazonURL;
			NSString *reviewURL;
			NSMutableString *features;
			NSMutableArray  *galleryImageUrls;
		};
		NSObject *arr[10];
	};
};

@implementation ProductDetailsViewController

@synthesize productId;
@synthesize firstCell, secondCell, buttonsCell, videoButton;
@synthesize loadIndicator;
@synthesize table,offersTable,scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
NSInteger retVal=0;
	@synchronized(self)
	{
		if(itemWasLoad)
		{
			switch (section) 
			{
				case 0:
					retVal = 2;
					break;
				case 1:
					retVal = 1;
				default:
					break;
			}
		}
	}
	return retVal;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell *cell;
	switch ([indexPath indexAtPosition:0]) {
		case 0:
			switch([indexPath indexAtPosition:1])
			{
				case 0:
					cell = firstCell ;
					break;
				case 1:
					cell = secondCell;
					break;
			}
			break;
		case 1:
			cell = buttonsCell;
			break;
	}
	return cell;
}
- (IBAction)PlayVideo:(id)sender {
	if(youtubeVideoMP4URL)
	{
		[self initMoviePlayer];
    
		[mMoviePlayer play];
	}
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
	
    mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:youtubeVideoMP4URL]];
	
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
/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */
- (void)loadThread:(id)param
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
MobileServiceSoap12Binding client;
_ns2__getProductDetails srvRequest;
_ns2__getProductDetailsResponse srvResp;
//	srvRequest.productId=new int(0);
	srvRequest.productId=new int(productId);
	srvRequest.languageId=new int(0);

	if( SOAP_OK == client.__ns4__getProductDetails(&srvRequest,&srvResp) )
	{
	vector<ns2__MProductOffer * >::iterator iter=srvResp.return_->offers.begin();
		pProdData=new CProductDataContainer();
		*pProdData=srvResp.return_;
		[offersTable setOffers:(void*)(&srvResp.return_->offers)];
		firstCell.name.text=pProdData->name;
		//firstCell.rang.text=[[NSString alloc] initWithFormat:@"%1.2f",pProdData->rating];
		NSString *fullStarPath=[NSString stringWithFormat:@"%@/full-star.png",[[NSBundle mainBundle] bundlePath]];
		NSString *halfStarPath=[NSString stringWithFormat:@"%@/half-star.png",[[NSBundle mainBundle] bundlePath]];
		NSString *emptyStarPath=[NSString stringWithFormat:@"%@/empty-star.png",[[NSBundle mainBundle] bundlePath]];
		UIImage *img;
		UIImageView *imgV;
		for(int i=0,cnt=(int)pProdData->rating,half=((pProdData->rating-cnt)>0?1:0);i<5;i++)
		{
			if(cnt)
			{
				img=[UIImage imageWithContentsOfFile:fullStarPath];
				cnt--;
			}
			else if(half)
			{
				img=[UIImage imageWithContentsOfFile:halfStarPath];
				half=0;
			}
			else
				img=[UIImage imageWithContentsOfFile:emptyStarPath];
			imgV=[[UIImageView alloc] initWithImage:img];
			[imgV setFrame:CGRectMake(i*14,5,14,14)];
			[firstCell.rangView addSubview:imgV];
		}
		firstCell.highlight1.text=pProdData->highlight1;
		firstCell.highlight2.text=pProdData->highlight2;
		[firstCell loadingImage:pProdData->imageURL];
		[firstCell initLabelsFont];
		secondCell.details.text=pProdData->features;
		[secondCell initLabelsFont];
		/*MyYouTube* t =*/[[MyYouTube alloc] initWithYoutubeUrl:pProdData->videoURL postToObject:self];
		galleryImageUrls = pProdData->galleryImageUrls;
		[galleryImageUrls retain];

		[self.navigationItem setTitle:pProdData->name];
		@synchronized(self)
		{
			itemWasLoad=true;
		}
		scrollView.contentSize=CGSizeMake(320, 289/*detail table*/+27/*header*/+(srvResp.return_->offers.size()*68));
		CGRect frame=offersTable.frame;
		frame.size.height=27/*header*/+(srvResp.return_->offers.size()*68);
		[offersTable setFrame:frame];
		[table reloadData];
		[offersTable reloadData];
	}
	[loadIndicator stopAnimating];
	[pool release];
}
// If you need to do additional setup after loading the view, override viewDidLoad.
- (void) viewDidLoad
{
CGRect oldR=scrollView.bounds;
//	scrollView.frame=CGRectMake(oldR.origin.x,oldR.origin.y,320,500);
	itemWasLoad=false;
	[loadIndicator startAnimating];
	[offersTable setDelegate:offersTable];
	[offersTable setDataSource:offersTable];
	offersTable.parentController=self;
	[NSThread detachNewThreadSelector:@selector(loadThread:) toTarget:self withObject:nil];

}


- (IBAction)PlayGallery:(id)sender {
 	ImageViewController *imageViewer;
 	imageViewer = [[ImageViewController alloc] initWithNibName:@"ImageView" bundle:nil];
 	imageViewer.images = galleryImageUrls;
 	[[self navigationController] pushViewController:imageViewer animated:YES];
}


-(void)setYoutubeMovieURL:(NSString*)vidURL
{
	youtubeVideoMP4URL = vidURL;
	[youtubeVideoMP4URL retain];
	videoButton.enabled = YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
CGFloat retVal=37;
	if(indexPath.section == 0)
	{
		switch(indexPath.row)
		{
			case 0:
				retVal=firstCell.bounds.size.height;
				break;
			case 1:
				retVal=secondCell.bounds.size.height;
				break;
		}
	}
	return retVal;
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
	[youtubeVideoMP4URL release];
}


@end
