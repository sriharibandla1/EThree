//
//  RegisterViewController.h
//  E3
//
//  Created by Hari on 25/03/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportedFiles/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *haveE3CardImage;
@property (weak, nonatomic) IBOutlet UIImageView *noE3CardImage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UILabel *conirmPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@property (weak, nonatomic) IBOutlet UIButton *sendOTPBT;
- (IBAction)sendotpAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (weak, nonatomic) IBOutlet UIView *sendOTPView;
@property (weak, nonatomic) IBOutlet UITextField *otp1TF;
@property (weak, nonatomic) IBOutlet UITextField *otpTF2;
@property (weak, nonatomic) IBOutlet UITextField *otpTF3;
@property (weak, nonatomic) IBOutlet UITextField *otpTF4;

@property (weak, nonatomic) IBOutlet UIView *otpView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIView *transVc;

@end

NS_ASSUME_NONNULL_END
