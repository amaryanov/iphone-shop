//
//  OffersTableDelegate.h
//  iShop
//
//  Created by Andrey Konovalov on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersTable : UITableView <UITableViewDataSource, UITableViewDelegate>
{

}
-(void) setOffers:(void */*std::vector<ns2__MProductOffer * >**/)offersVector;
@end
