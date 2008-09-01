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
#import "ImageViewController.h"

class CProductDataContainer;
@class ProductDetailCellView;
@class ProductDescriptCellView;
@interface ProductDetailsViewController : UIViewController {
	int productId;
	CProductDataContainer *pProdData;
    MPMoviePlayerController *mMoviePlayer;
	NSString* youtubeVideoMP4URL;
	NSMutableArray						*galleryImageUrls;
	IBOutlet ProductDetailCellView		*firstCell;
	IBOutlet ProductDescriptCellView	*secondCell;
	IBOutlet UITableViewCell			*buttonsCell;
	IBOutlet UIButton					*videoButton;
	IBOutlet UIImageView				*fullStar;
	IBOutlet UIImageView				*halfStar;
	IBOutlet UIImageView				*emptyStar;
}
@property(readwrite) int productId;
@property(retain, nonatomic) ProductDetailCellView		*firstCell;
@property(retain, nonatomic) ProductDescriptCellView	*secondCell;
@property(retain, nonatomic) UITableViewCell			*buttonsCell;
@property(retain, nonatomic) UIButton					*videoButton;
@property(retain, nonatomic) UIImageView				*fullStar;
@property(retain, nonatomic) UIImageView				*halfStar;
@property(retain, nonatomic) UIImageView				*emptyStar;

- (IBAction)PlayVideo:(id)sender;
- (IBAction)PlayGallery:(id)sender;
-(void)initMoviePlayer;

@end
