//
//  VerifyOtpViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "VerifyOtpViewController.h"
#import "TabBarViewController.h"

@interface VerifyOtpViewController ()<UITextFieldDelegate>
@property NSString * otpNumber;
@end

@implementation VerifyOtpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.navigationController setNavigationBarHidden:YES];
    self.resendPasswordBtn.hidden = YES;
    self.verifyOtpButton.layer.cornerRadius = self.verifyOtpButton.frame.size.height/2;
    self.firstTfldView.layer.cornerRadius = 10;
    self.secondTfldView.layer.cornerRadius = 10;
    self.thiredTfldView.layer.cornerRadius = 10;
    self.fourthTfldView.layer.cornerRadius = 10;
    
    NSString*firstTextString = self.firstTextField.text;
    NSString*secondTextString = self.secondTextField.text;
    NSString*thirdTextString = self.thiredTextField.text;
    NSString*fourthString =  self.fourthtextField.text;
    self.otpNumber = [NSString stringWithFormat:@"%@%@%@%@",firstTextString,secondTextString,thirdTextString,fourthString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)verifyOtpBtnAction:(UIButton *)sender {
    
    
    NSString *successMsg = [self VerifyvalidateData];
    
    if(successMsg == nil)
    {
        TabBarViewController * homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarId"];
        homeVc.selectedViewController = homeVc.viewControllers[0];
        [self.navigationController pushViewController:homeVc animated:YES];
    }
    else{
        [self showAlert:@"Data Validation Failed!" message:successMsg];
    }
    
   
}
- (IBAction)resendPasswordBtnAction:(UIButton *)sender {
   
}

- (IBAction)firstTF:(UITextField *)sender {
    NSString * text = sender.text;
    if (text.length >= 1) {
        [self.secondTextField becomeFirstResponder];
    }
}

- (IBAction)secondTF:(UITextField *)sender {
    NSString * text = sender.text;
    if (text.length >= 1) {
        [self.thiredTextField becomeFirstResponder];
    }
}

- (IBAction)thirdTF:(UITextField *)sender {
    NSString * text = sender.text;
    if (text.length >= 1) {
        [self.fourthtextField becomeFirstResponder];
    }
    
}
- (IBAction)fourthTF:(UITextField *)sender {
    NSString * text = sender.text;
    if (text.length >= 1) {
        [self.fourthtextField becomeFirstResponder];
    }
}

-(NSString *)VerifyvalidateData
{
    NSString *successMessage = nil;
    if(!self.firstTextField.text.length || !self.secondTextField.text.length || !self.thiredTextField.text.length || !self.fourthtextField.text.length)
    {
        successMessage = @"Please Enter CorrectOtp";
        return successMessage;
    }
    
    return successMessage;
}

@end
