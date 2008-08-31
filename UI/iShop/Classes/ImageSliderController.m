//
//  ImageSliderController.m
//  ivTest
//
//  Created by Anton Maryanov on 8/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ImageSliderController.h"


@implementation ImageSliderController

@synthesize buttons;
@synthesize current;
@synthesize imgView;
@synthesize mainButtons;
@synthesize playBtn;
@synthesize backBtn;
@synthesize fwdBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (IBAction)PlayBtnTouchInside:(id)sender
{
	if(sliderTimer == nil)
	{
		sliderTimer = [NSTimer timerWithTimeInterval:5 target:self selector: @selector(myTimerFireMethod:) userInfo:nil repeats:YES];
		[[NSRunLoop currentRunLoop] addTimer: sliderTimer forMode: NSDefaultRunLoopMode];
		self.tabBarController.view.alpha = 0.0;
		[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
		backBtn.alpha = 0;
		playBtn.alpha = 0;
		fwdBtn.alpha = 0;
	}
	else if([sliderTimer isValid])
	{
		[sliderTimer invalidate];
		[sliderTimer release];
		sliderTimer = nil;
		self.tabBarController.view.alpha = 0.7;
		[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
		backBtn.alpha = 1;
		playBtn.alpha = 1;
		fwdBtn.alpha = 1;
	}
}


-(void)backImg
{
	current--;
	if(current < 0)
		current = [buttons count] - 1;
	ImageButton *ib = [buttons objectAtIndex:current];
	imgView.image = [ib backgroundImageForState:UIControlStateNormal];
}
-(void)fwdImg
{
	current++;
	if(current >= [buttons count])
		current = 0;
	ImageButton *ib = [buttons objectAtIndex:current];
	imgView.image = [ib backgroundImageForState:UIControlStateNormal];
}
- (IBAction)BackBtnTouchInside:(id)sender
{
	[self backImg];
}
- (void)myTimerFireMethod:(NSTimer*)theTime
{
	[self fwdImg];
}
- (IBAction)FwdBtnTouchInside:(id)sender
{
	[self fwdImg];
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	
	CGFloat d = (320 - backBtn.frame.size.width - fwdBtn.frame.size.width - playBtn.frame.size.width) / 4;
	backBtn.frame = CGRectMake(d, 431 + (49 - backBtn.frame.size.height)/2, backBtn.frame.size.width, backBtn.frame.size.height);
	playBtn.frame = CGRectMake(d + backBtn.frame.origin.x + backBtn.frame.size.width, 431 + (49 - playBtn.frame.size.height)/2, playBtn.frame.size.width, playBtn.frame.size.height);
	fwdBtn.frame = CGRectMake(d + playBtn.frame.origin.x + playBtn.frame.size.width, 431 + (49 - fwdBtn.frame.size.height)/2, fwdBtn.frame.size.width, fwdBtn.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
}
- (void)viewWillAppear:(BOOL)animated
{
	//UIImageView *imgView = [self view];
	ImageButton *ib = [buttons objectAtIndex:current];
	imgView.image = [ib backgroundImageForState:UIControlStateNormal];
	[[[UIApplication sharedApplication] keyWindow] addSubview:imgView];
	[[[UIApplication sharedApplication] keyWindow] sendSubviewToBack:imgView];
	[[[UIApplication sharedApplication] keyWindow] addSubview:backBtn];
	[[[UIApplication sharedApplication] keyWindow] addSubview:fwdBtn];
	[[[UIApplication sharedApplication] keyWindow] addSubview:playBtn];
	[UIApplication sharedApplication].statusBarStyle = 1;
	self.tabBarController.view.alpha = 0.7;
	iShopAppDelegate *mainDelegate = [iShopAppDelegate MainDelegate];
	mainDelegate.tabBar.alpha = 0.0;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[imgView removeFromSuperview];
	[backBtn removeFromSuperview];
	[playBtn removeFromSuperview];
	[fwdBtn removeFromSuperview];
	[mainButtons removeFromSuperview];
	self.tabBarController.view.alpha = 1;
	iShopAppDelegate *mainDelegate = [iShopAppDelegate MainDelegate];
	mainDelegate.tabBar.alpha = 1;
	if([sliderTimer isValid])
	{
		[sliderTimer invalidate];
		[sliderTimer release];
		sliderTimer = nil;
	}
	//[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
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
}


@end
