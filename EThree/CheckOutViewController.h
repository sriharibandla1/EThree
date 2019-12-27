//
//  CheckOutViewController.h
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckOutViewController : UIViewController
- (IBAction)WalletAction:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UIButton *payWithYourE3CardButton;
@property (weak, nonatomic) IBOutlet UIButton *codButton;
@property (weak, nonatomic) IBOutlet UIButton *onlinePaymentButton;
@property (weak, nonatomic) IBOutlet UIButton *coninueButton;
@property (weak, nonatomic) IBOutlet UIImageView *codRadioImage;
@property (weak, nonatomic) IBOutlet UIImageView *payTmRadioImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *grandTotalLabel;
@property BOOL walletIsSelected;
@property (weak, nonatomic) IBOutlet UIImageView *payUsingWalletRadioImage;
@end

NS_ASSUME_NONNULL_END
