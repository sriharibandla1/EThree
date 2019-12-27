//
//  CartViewController.h
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Paytm Sdk/include/PaymentsSDK.h"
NS_ASSUME_NONNULL_BEGIN

@interface CartViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UILabel *cartNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderButton;
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;
//@property (weak, nonatomic) IBOutlet UILabel *subTotalValueLabel;
//@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *finalTotalLabel;
@property (weak, nonatomic) IBOutlet UIView *emptyCartView;
//@property (weak, nonatomic) IBOutlet UIView *totalAmountView;
//@property (weak, nonatomic) IBOutlet UILabel *feeMainLabel;
//@property (weak, nonatomic) IBOutlet UILabel *subTotalLabel;





@property NSString * totalAmount;
@property(nonatomic, strong)NSDictionary *orderDetail;
@property NSString * orderId;
@property NSString * customerID;
@property NSString * paytmOrderID;
//@property NSString * transactionAmount;
@property NSString * custeMail;
@property NSString * custMobileNo;
@property NSString * merchantID;
@property NSString * channelID;
@property NSString * industryTypeID;
@property NSString * website;
@property (weak, nonatomic) IBOutlet UILabel *itemAndPriceLabel;
@property NSString * theme;
@end





@interface CartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfItemLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBt;
@property (weak, nonatomic) IBOutlet UIButton *subBt;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIButton *delectBt;
@property (weak, nonatomic) IBOutlet UILabel *totalCostOfItemLabel;

@end
NS_ASSUME_NONNULL_END
