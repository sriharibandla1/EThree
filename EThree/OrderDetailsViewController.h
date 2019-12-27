//
//  OrderDetailsViewController.h
//  E3
//
//  Created by Kardas Veeresham on 4/1/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *orderDetailsTableView;
@property (weak, nonatomic) IBOutlet UILabel *iteamTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *texeslabel;
@property (weak, nonatomic) IBOutlet UILabel *discountChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totallabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryLabel;




@property NSString * orderIdString;
@end

@interface OrderDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *iteamPriceLabel;

@end

NS_ASSUME_NONNULL_END
