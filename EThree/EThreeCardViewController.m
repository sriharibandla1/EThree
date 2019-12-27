//
//  EThreeCardViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/22/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "EThreeCardViewController.h"
#import "SupportedFiles/Network.h"
#import "SuccessViewController.h"

@interface EThreeCardViewController (){
    BOOL cardOpen;
}

@end

@implementation EThreeCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cardOpen = false;
    
    //UIViewAnimationOptionTransitionCrossDissolve
}
-(void)viewWillAppear:(BOOL)animated{
    self.mobileNumberView.hidden = NO;
    self.submitButton.hidden = NO;
    self.availableBalanceView.hidden = YES;
     self.eThreeCardView.hidden = YES;
    if ([self.continueString isEqualToString:@"continue"]) {
        self.continueButton.hidden = NO;
    }
    else{
        self.continueButton.hidden = YES;
    }
}
- (IBAction)backBtnAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitBtnAction:(UIButton *)sender {
    if (!self.mobileNumberTextField.text.length || self.mobileNumberTextField.text.length > 10) {
        [self showAlert:@"Alert!" message:@"Enter Currect MobileNumber"];
    }else{
        [self cardDetailsData];
       
    }
}


- (IBAction)cardImageBtnAction:(UIButton *)sender {
    
    if (cardOpen) {
        cardOpen = false;
//        UIImage * image  = [UIImage imageNamed:@"ATMCard"];
//        [self.cardImageBtn setImage:image forState:UIControlStateNormal];
        
        [UIView transitionWithView:self.frountImageView duration:0.5 options: UIViewAnimationOptionTransitionFlipFromLeft animations:^(void){
            
        } completion:nil];
        self.frountImageView.hidden = NO;
        self.backImageView.hidden = YES;
    }
    else
    {
        cardOpen = true;
//        UIImage * image  = [UIImage imageNamed:@"CVV"];
//        [self.cardImageBtn setImage:image forState:UIControlStateNormal];
       
        [UIView transitionWithView:self.backImageView duration:0.5 options: UIViewAnimationOptionTransitionFlipFromRight animations:^(void){
            
        } completion:nil];
        self.frountImageView.hidden = YES;
        self.backImageView.hidden = NO;
    }
}

- (IBAction)continueBtnAction:(UIButton *)sender {
    SuccessViewController*view = [self.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewControllerId"];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)cardDetailsData
{
    NSDictionary * parameters = @{@"mobile":@"9966308879"};
    [[Network networkManager]cardDetailsData:parameters complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                self.mobileNumberView.hidden = YES;
                self.submitButton.hidden = YES;
                self.availableBalanceView.hidden = NO;
                self.eThreeCardView.hidden = NO;
                self.cardNumberLabel.text = [[jsonDict[@"list"]objectAtIndex:0]valueForKey:@"card_number"];
                self.cardHolderName.text = [[jsonDict[@"list"]objectAtIndex:0]valueForKey:@"username"];
                self.expiryDateLabel.text = [[jsonDict[@"list"]objectAtIndex:0]valueForKey:@"expiry_date"];
            }
            else
            {
                [self showAlert:@"Alert!" message:jsonDict[@"message"]];
            }
        });
    }];
}

@end
