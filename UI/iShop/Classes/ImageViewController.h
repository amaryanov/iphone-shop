//
//  FirstViewController.h
//  ivTest
//
//  Created by Anton Maryanov on 8/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataHTTPFetcher.h"
#import "ImageSliderController.h"

#define IMAGES_PER_LINE 4
#define IMAGE_WIDTH 320 / IMAGES_PER_LINE

@interface ImageViewController : UIViewController {
	IBOutlet ImageSliderController *slider;
	NSMutableArray *images;
	IBOutlet NSMutableArray *buttons;
}

@property ( nonatomic, retain) ImageSliderController *slider;
@property (retain, nonatomic) NSMutableArray *images;
@property (retain, nonatomic) NSMutableArray *buttons;
@end



@interface ImageButton : UIButton
{
	int imgNum;
}
@property (nonatomic) int imgNum;

@end
