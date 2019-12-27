//
//  EThreeCardViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/22/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportedFiles/BaseViewController.h"


@interface EThreeCardViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *cardImageBtn;
- (IBAction)cardImageBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UIView *availableBalanceView;
@property (weak, nonatomic) IBOutlet UILabel *availableBalanceLable;
@property (weak, nonatomic) IBOutlet UIView *mobileNumberView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *eThreeCardView;
@property (weak, nonatomic) IBOutlet UIView *frountImageView;
@property (weak, nonatomic) IBOutlet UIView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardHolderName;
@property (weak, nonatomic) IBOutlet UILabel *expiryDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property NSString * continueString;
@end
