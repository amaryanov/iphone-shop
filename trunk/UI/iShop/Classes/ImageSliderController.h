//
//  ImageSliderController.h
//  ivTest
//
//  Created by Anton Maryanov on 8/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import "iShopAppDelegate.h"


@class ImageButton;
@interface ImageSliderController : UIViewController {
	IBOutlet NSMutableArray *buttons;
	IBOutlet UIImageView *imgView;
	IBOutlet UIView *mainButtons;
	IBOutlet UIButton *backBtn;
	IBOutlet UIButton *fwdBtn;
	IBOutlet UIButton *playBtn;
	NSTimer *sliderTimer;
	int current;
}

@property (retain, nonatomic) NSMutableArray *buttons;
@property (retain, nonatomic) UIImageView *imgView;
@property (retain, nonatomic) UIView *mainButtons;
@property (retain, nonatomic) UIButton *backBtn;
@property (retain, nonatomic) UIButton *fwdBtn;
@property (retain, nonatomic) UIButton *playBtn;
@property (nonatomic) int current;

- (IBAction)PlayBtnTouchInside:(id)sender;
- (IBAction)BackBtnTouchInside:(id)sender;
- (IBAction)FwdBtnTouchInside:(id)sender;

-(void)backImg;
-(void)fwdImg;
@end
