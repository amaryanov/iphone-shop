//
//  FirstViewController.h
//  ivTest
//
//  Created by Anton Maryanov on 8/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSliderController.h"

#define IMAGES_PER_LINE 4
#define IMAGE_WIDTH 320 / IMAGES_PER_LINE

@interface ImageViewController : UIViewController {
	IBOutlet ImageSliderController *slider;
	IBOutlet NSMutableArray *images;
	IBOutlet UITabBar *tabBar;
}

@property ( nonatomic, retain) ImageSliderController *slider;
@property (nonatomic, retain) UITabBar *tabBar;
@property (retain, nonatomic) NSMutableArray *images;
@end



@interface ImageButton : UIButton
{
	int imgNum;
}
@property (nonatomic) int imgNum;

@end
