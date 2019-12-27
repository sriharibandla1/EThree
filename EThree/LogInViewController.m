//
//  LogInViewController.m
//  E3
//
//  Created by Hari on 25/03/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "LogInViewController.h"
#import "RegisterViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/ProgressViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logInButton.layer.cornerRadius = 20;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"USER"] != nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)loginAction:(UIButton *)sender {
    
   
    NSString *successMsg = [self validateData];
    
    if(successMsg == nil)
    {
        [self toLogIn];
    }
    else{
        [self showAlert:@"Data Validation Failed!" message:successMsg];
    }
}

-(NSString *)validateData
{
    NSString *successMessage = nil;
    
    if(!self.passwordTF.text.length)
    {
        successMessage = @"Please Enter Password";
        return successMessage;
    }
    
    if(!self.userNameTF.text.length)
    {
        successMessage = @"Please Enter MobileNumber";
        return successMessage;
    }
    if(self.userNameTF.text.length > 10)
    {
        successMessage = @"Please Enter Currect MobileNumber";
        return successMessage;
    }

    return successMessage;
}
- (IBAction)sigUpAction:(UIButton *)sender {
    RegisterViewController * registerPage = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewControllerId"];
    [self presentViewController:registerPage animated:YES completion:nil];
    
}

- (IBAction)passwordDidBeginEdting:(UITextField *)sender {
    self.passwordLabel.backgroundColor = UIColor.redColor;
    self.userNameLabel.backgroundColor = UIColor.lightGrayColor;
}

- (IBAction)userDidBeginEditing:(UITextField *)sender {
    self.userNameLabel.backgroundColor = UIColor.redColor;
    self.passwordLabel.backgroundColor = UIColor.lightGrayColor;
}
-(void)toLogIn
{
[self.view addSubview:[ProgressViewController sharedProgressVC].view];
    [[Network networkManager]login:@{@"mobile":self.userNameTF.text,@"password":self.passwordTF.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"json data = %@",jsonDict);
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                [[NSUserDefaults standardUserDefaults]setValue:jsonDict[@"list"] forKey:@"USER"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [self showAlert:@"Sorry" message:jsonDict[@"message"]];
            }
            [ProgressViewController sharedProgressVC].view.hidden = YES;

        });
    }];
}
@end
