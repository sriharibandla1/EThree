//
//  RegisterViewController.m
//  E3
//
//  Created by Hari on 25/03/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "RegisterViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/ProgressViewController.h"
#import "HomeViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate>
@property NSString * registerTypeString;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerTypeString = @"haveE3Card";
   // self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width,900);
    self.otpTF4.delegate = self;
    self.otpTF2.delegate = self;
    self.otp1TF.delegate = self;
    self.otpTF3.delegate = self;
   
    // Do any additional setup after loading the view.
}
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)containsE3CardAction:(UIButton *)sender {
    self.haveE3CardImage.image = [UIImage imageNamed:@"radioOn"];
    self.noE3CardImage.image = [UIImage imageNamed:@"radioOff"];
     self.registerTypeString = @"haveE3Card";
    self.cardView.hidden = NO;
   
}
- (IBAction)noE3CardAction:(UIButton *)sender {
    self.haveE3CardImage.image = [UIImage imageNamed:@"radioOff"];
    self.noE3CardImage.image = [UIImage imageNamed:@"radioOn"];
     self.registerTypeString = @"notHaveE3Card";
    self.cardView.hidden = YES;
}


#pragma mark - Navigation

- (IBAction)firstTextFD:(UITextField *)sender {
//    NSString * text = sender.text;
//    if (text.length >= 1) {
//        [self.otpTF2 becomeFirstResponder];
//    }
}

- (IBAction)secondTF:(UITextField *)sender {
//    NSString * text = sender.text;
//    if (text.length >= 1) {
//        [self.otpTF3 becomeFirstResponder];
//    }
}

- (IBAction)thirdTF:(UITextField *)sender {
//    NSString * text = sender.text;
//    if (text.length >= 1) {
//        [self.otpTF4 becomeFirstResponder];
//    }
}
- (IBAction)fourthTF:(UITextField *)sender {
//    NSString * text = sender.text;
//    if (text.length >= 1) {
//
//        [self.otpTF4 becomeFirstResponder];
//    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString* )string {
    if (string.length > 0) {
        textField.text = [string substringToIndex:1];
        if (textField == self.otp1TF) {
            [self.otpTF2 becomeFirstResponder];
        } else if (textField == self.otpTF2) {
            [self.otpTF3 becomeFirstResponder];
        } else if (textField == self.otpTF3) {
            [self.otpTF4 becomeFirstResponder];
        } else {
            [textField resignFirstResponder];
        }
        
        return NO;
    }
    
    return YES;
}

- (IBAction)sendotpAction:(UIButton *)sender {
    
    NSString *successMsg = [self validateData];

    if(successMsg == nil)
    {
        [self forSignUp];
    }
    else{
        [self showAlert:@"Data Validation Failed!" message:successMsg];
    }
   
}

- (IBAction)verifyOtpBtnAction:(UIButton *)sender {
    [self otpData];
}
- (IBAction)reSendBtnAction:(UIButton *)sender {
}

-(void)setColorToLabel:(NSInteger)tagValur
{
    if (tagValur == 1) {
        self.userLabel.backgroundColor = UIColor.redColor;
        self.emailLabel.backgroundColor = UIColor.lightGrayColor;
        self.mobileLabel.backgroundColor = UIColor.lightGrayColor;
        self.passwordLabel.backgroundColor = UIColor.lightGrayColor;
        self.conirmPasswordLabel.backgroundColor = UIColor.lightGrayColor;
        self.cardNumberLabel.backgroundColor = UIColor.lightGrayColor;
    }
    else if(tagValur == 2)
    {
        self.userLabel.backgroundColor = UIColor.lightGrayColor;
        self.emailLabel.backgroundColor = UIColor.redColor;
        self.mobileLabel.backgroundColor = UIColor.lightGrayColor;
        self.passwordLabel.backgroundColor = UIColor.lightGrayColor;
        self.conirmPasswordLabel.backgroundColor = UIColor.lightGrayColor;
        self.cardNumberLabel.backgroundColor = UIColor.lightGrayColor;
    }
    else if(tagValur == 3)
    {
        self.userLabel.backgroundColor = UIColor.lightGrayColor;
        self.emailLabel.backgroundColor = UIColor.lightGrayColor;
        self.mobileLabel.backgroundColor = UIColor.redColor;
        self.passwordLabel.backgroundColor = UIColor.lightGrayColor;
        self.conirmPasswordLabel.backgroundColor = UIColor.lightGrayColor;
        self.cardNumberLabel.backgroundColor = UIColor.lightGrayColor;
    }
    else if (tagValur == 4)
    {
        self.userLabel.backgroundColor = UIColor.lightGrayColor;
        self.emailLabel.backgroundColor = UIColor.lightGrayColor;
        self.mobileLabel.backgroundColor = UIColor.lightGrayColor;
        self.passwordLabel.backgroundColor = UIColor.redColor;
        self.conirmPasswordLabel.backgroundColor = UIColor.lightGrayColor;
        self.cardNumberLabel.backgroundColor = UIColor.lightGrayColor;
    }
    else if (tagValur == 5)
    {
        self.userLabel.backgroundColor = UIColor.lightGrayColor;
        self.emailLabel.backgroundColor = UIColor.lightGrayColor;
        self.mobileLabel.backgroundColor = UIColor.lightGrayColor;
        self.passwordLabel.backgroundColor = UIColor.lightGrayColor;
        self.conirmPasswordLabel.backgroundColor = UIColor.redColor;
        self.cardNumberLabel.backgroundColor = UIColor.lightGrayColor;
    }
    else
    {
        self.userLabel.backgroundColor = UIColor.lightGrayColor;
        self.emailLabel.backgroundColor = UIColor.lightGrayColor;
        self.mobileLabel.backgroundColor = UIColor.lightGrayColor;
        self.passwordLabel.backgroundColor = UIColor.lightGrayColor;
        self.conirmPasswordLabel.backgroundColor = UIColor.lightGrayColor;
        self.cardNumberLabel.backgroundColor = UIColor.redColor;
    }
}
-(NSString *)validateData
{
    NSString *successMessage = nil;
    
    if(!self.userNameTF.text.length)
    {
        successMessage = @"Please Enter Name";
        return successMessage;
    }
    if(!self.emailTF.text.length)
    {
        successMessage = @"Please Enter Email";
        return successMessage;
    }
    if(!self.passwordTF.text.length)
    {
        successMessage = @"Please Enter Password";
        return successMessage;
    }
    if(!self.confirmPasswordTF.text.length)
    {
        successMessage = @"Please Enter Confirm Password";
        return successMessage;
    }
    if (![self.passwordTF.text isEqualToString:self.confirmPasswordTF.text]) {
        successMessage = @"Please Enter currect Password And Confirm Password";
        return successMessage;
    }
    if(!self.mobileTF.text.length)
    {
        successMessage = @"Please Enter MobileNumber";
        return successMessage;
    }
    
    if ([self.registerTypeString isEqualToString:@"haveE3Card"]) {
        if(!self.cardNumberTF.text.length)
        {
            successMessage = @"Please Enter card number";
            return successMessage;
        }
        if (self.cardNumberTF.text.length != 16) {
            successMessage = @"Please Enter currect card number";
            return successMessage;
        }
    }
    return successMessage;
}


-(void)forSignUp
{
    
    [[Network networkManager]signUp:@{@"mobile":self.mobileTF.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                self.otpView.hidden = NO;
                self.transVc.hidden = NO;
                self.phoneNumberLabel.text = self.mobileTF.text;
            }
            else
            {
                [self showAlert:@"Sorry" message:jsonDict[@"message"]];
            }
        });
    }];
}


-(void)otpData
{
    NSString * firstOtp = self.otp1TF.text;
     NSString * secondOtp = self.otpTF2.text;
     NSString * thirdOtp = self.otpTF3.text;
     NSString * fourthOtp = self.otpTF4.text;
    NSString * otpString = [NSString stringWithFormat:@"%@%@%@%@",firstOtp,secondOtp,thirdOtp,fourthOtp];
    [self.view addSubview:[ProgressViewController sharedProgressVC].view];
    NSDictionary * parameters = @{@"username":self.userNameTF.text,@"email":self.emailTF.text,@"password":self.passwordTF.text,@"mobileToken":@"2",@"otp":otpString,@"mobile":self.mobileTF.text};
    [[Network networkManager]verifyOtpData:parameters complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                self.otpView.hidden = YES;
                self.transVc.hidden = YES;
                [[NSUserDefaults standardUserDefaults]setValue:[jsonDict[@"list"]objectAtIndex:0] forKey:@"USER"];
                [ProgressViewController sharedProgressVC].view.hidden = YES;
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [ProgressViewController sharedProgressVC].view.hidden = YES;
                [self showAlert:@"Sorry" message:jsonDict[@"message"]];
            }

        });
    }];
}
@end
