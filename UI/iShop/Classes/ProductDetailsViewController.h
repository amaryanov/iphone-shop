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
@class OffersTable;
@interface ProductDetailsViewController : UIViewController {
	int		productId;
	bool	itemWasLoad;
	CProductDataContainer *pProdData;
    MPMoviePlayerController *mMoviePlayer;
	NSString* youtubeVideoMP4URL;
	NSMutableArray						*galleryImageUrls;
	IBOutlet ProductDetailCellView		*firstCell;
	IBOutlet ProductDescriptCellView	*secondCell;
	IBOutlet UITableViewCell			*buttonsCell;
	IBOutlet UIButton					*videoButton;
	IBOutlet UIActivityIndicatorView	*loadIndicator;
	IBOutlet UITableView				*table;
	IBOutlet OffersTable				*offersTable;
	IBOutlet UIScrollView				*scrollView;
}
@property(readwrite) int productId;
@property(retain, nonatomic) ProductDetailCellView		*firstCell;
@property(retain, nonatomic) ProductDescriptCellView	*secondCell;
@property(retain, nonatomic) UITableViewCell			*buttonsCell;
@property(retain, nonatomic) UIButton					*videoButton;
@property(retain, nonatomic) UIActivityIndicatorView	*loadIndicator;
@property(retain, nonatomic) UITableView				*table;
@property(retain, nonatomic) OffersTable				*offersTable;
@property(retain, nonatomic) UIScrollView				*scrollView;

- (IBAction)PlayVideo:(id)sender;
- (IBAction)PlayGallery:(id)sender;
-(void)initMoviePlayer;

@end
