//
//  LogInViewController.h
//  E3
//
//  Created by Hari on 25/03/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportedFiles/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LogInViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)sigUpAction:(UIButton *)sender;
- (IBAction)passwordDidBeginEdting:(UITextField *)sender;
- (IBAction)userDidBeginEditing:(UITextField *)sender;

@end

NS_ASSUME_NONNULL_END
