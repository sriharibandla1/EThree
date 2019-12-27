//
//  PlayZoneViewController.h
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayZoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *restaurantCollectionView;

@end






@interface RestaurantCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;

@end
NS_ASSUME_NONNULL_END
