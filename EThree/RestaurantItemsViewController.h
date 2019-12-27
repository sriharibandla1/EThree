//
//  RestaurantItemsViewController.h
//  E3
//
//  Created by Kardas Veeresham on 3/21/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantItemsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *transView;
@property (weak, nonatomic) IBOutlet UILabel *cartNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *restaurantImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameInPickerViewLabel;
- (IBAction)donePickerViewAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *mainPickerView;

@property (weak, nonatomic) IBOutlet UIScrollView *restaurantItemsScrollView;
@property (weak, nonatomic) IBOutlet UIView *recommendedView;
@property (weak, nonatomic) IBOutlet UILabel *recommendedLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeAllButton;
@property (weak, nonatomic) IBOutlet UICollectionView *recommendedCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *restaurantItemsTableView;

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property NSString * venderCodeString;
@property NSString * imageURLString;
@end




@interface RecommendedCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *restaurantRecommendedIteamImage;
@property (weak, nonatomic) IBOutlet UILabel *IteamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *addNdSubView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeOfProductImage;
@property (weak, nonatomic) IBOutlet UIButton *typeOfWeightBt;
@property (weak, nonatomic) IBOutlet UIButton *plusBtInRec;
@property (weak, nonatomic) IBOutlet UIButton *subBtInRec;

@property (weak, nonatomic) IBOutlet UILabel *typeOfWeightLabel;
@property (weak, nonatomic) IBOutlet UIButton *addbtInRec;



@end

@interface RestaurantIteamTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *restaurantIteamCellView;
@property (weak, nonatomic) IBOutlet UIImageView *typeOfProductImage;
@property (weak, nonatomic) IBOutlet UILabel *wiightLabel;

@property (weak, nonatomic) IBOutlet UILabel *restaurantIteamPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantIteamNameLabel;
@property (weak, nonatomic) IBOutlet UIView *addNdSubView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;
@property (weak, nonatomic) IBOutlet UIButton *typeOfWeightBt;
@property (weak, nonatomic) IBOutlet UIButton *addBt;
@property (weak, nonatomic) IBOutlet UIButton *plusBt;
@property (weak, nonatomic) IBOutlet UIButton *subBt;

@end

NS_ASSUME_NONNULL_END
