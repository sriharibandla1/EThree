//
//  VerifyOtpViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportedFiles/BaseViewController.h"

@interface VerifyOtpViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UITextField *thiredTextField;
@property (weak, nonatomic) IBOutlet UITextField *fourthtextField;
@property (weak, nonatomic) IBOutlet UIView *firstTfldView;
@property (weak, nonatomic) IBOutlet UIView *secondTfldView;
@property (weak, nonatomic) IBOutlet UIView *thiredTfldView;
@property (weak, nonatomic) IBOutlet UIView *fourthTfldView;

@property (weak, nonatomic) IBOutlet UIButton *verifyOtpButton;
- (IBAction)verifyOtpBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *resendPasswordBtn;
- (IBAction)resendPasswordBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *resend30SecLabel;
@end
