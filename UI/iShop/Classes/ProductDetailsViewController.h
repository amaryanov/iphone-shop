//
//  ProductDetailsViewCotroller.h
//  iShop
//
//  Created by Andrey Konovalov on 20.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TestYoutube.h"

class CProductDataContainer;
@class ProductDetailCellView;
@class ProductDescriptCellView;
@interface ProductDetailsViewController : UIViewController {
	int productId;
	CProductDataContainer *pProdData;
    MPMoviePlayerController *mMoviePlayer;
	NSString* youtubeVideoMP4URL;
	IBOutlet ProductDetailCellView		*firstCell;
	IBOutlet ProductDescriptCellView	*secondCell;
	IBOutlet UITableViewCell			*buttonsCell;
	IBOutlet UIButton					*videoButton;
}
@property(readwrite) int productId;
@property(retain, nonatomic) ProductDetailCellView		*firstCell;
@property(retain, nonatomic) ProductDescriptCellView	*secondCell;
@property(retain, nonatomic) UITableViewCell			*buttonsCell;
@property(retain, nonatomic) UIButton					*videoButton;
- (IBAction)PlayVideo:(id)sender;
-(void)initMoviePlayer;

@end
