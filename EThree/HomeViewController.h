//
//  HomeViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *transVc;
@property (weak, nonatomic) IBOutlet UIView *slideVc;
- (IBAction)slideBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *slideMenuButton;
@property (weak, nonatomic) IBOutlet UICollectionView *homeResturentCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *homeBannerCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *refurYourFriendBt;

@property (weak, nonatomic) IBOutlet UIButton *playZoneButton;
@property (weak, nonatomic) IBOutlet UIButton *foodCourtsButton;
@property (weak, nonatomic) IBOutlet UIButton *culturalStageButton;
@property (weak, nonatomic) IBOutlet UIButton *breweryButton;
@property (weak, nonatomic) IBOutlet UIButton *exhibitionButton;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *thirdViewOne;
@property (weak, nonatomic) IBOutlet UIView *thirdViewTwo;
@property (weak, nonatomic) IBOutlet UIView *thirdViewThree;
@property (weak, nonatomic) IBOutlet UILabel *nameInSlidemenu;
@property (weak, nonatomic) IBOutlet UILabel *mailInSlideMenu;

@end

@interface HomeRestaurantsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@end
@interface HomeBannerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bannerimage;

@end

@interface FavoriteRestaurantsCollectionViewCell : UICollectionViewCell

@end

