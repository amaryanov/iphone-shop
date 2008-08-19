//
//  CustomUIImageView.h
//  ivTest
//
//  Created by Anton Maryanov on 8/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSliderController.h"


@interface CustomUIImageView : UIImageView {
	IBOutlet ImageSliderController *cntrl;
}
@property(retain, nonatomic) ImageSliderController *cntrl;

@end
