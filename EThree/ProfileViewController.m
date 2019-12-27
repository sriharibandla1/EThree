//
//  ProfileViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/22/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "ProfileViewController.h"
#import "SupportedFiles/HMSegmentedControl.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/ProgressViewController.h"


@interface ProfileViewController (){
     BOOL cardOpen;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cardOpen = false;
    
    
    [self userProfileData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary * item = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER"];
     self.profileNameLabel.text = item[@"username"];
}

- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)myDetailsBtnAction:(UIButton *)sender {
    self.E3CardView.hidden = YES;
    self.myDetailsLabel.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:35.0/255.0 blue:109.0/255.0 alpha:1];
    self.e3CardLabel.backgroundColor = [UIColor whiteColor];
}

- (IBAction)e3CardBtnAction:(UIButton *)sender {
    self.E3CardView.hidden = NO;
    self.myDetailsLabel.backgroundColor = [UIColor whiteColor];
    self.e3CardLabel.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:35.0/255.0 blue:109.0/255.0 alpha:1];
}

- (IBAction)imageBtnAction:(UIButton *)sender {
    
    if (cardOpen) {
        cardOpen = false;
        UIImage * image  = [UIImage imageNamed:@"ATMCard"];
        [self.imageBtn setImage:image forState:UIControlStateNormal];
        [UIView transitionWithView:self.imageBtn duration:0.5 options: UIViewAnimationOptionTransitionFlipFromLeft animations:^(void){
            // [view setHidden:hidden];
        } completion:nil];
    }
    else
    {
        cardOpen = true;
        UIImage * image  = [UIImage imageNamed:@"CVV"];
        [self.imageBtn setImage:image forState:UIControlStateNormal];
        [UIView transitionWithView:self.imageBtn duration:0.5 options: UIViewAnimationOptionTransitionFlipFromRight animations:^(void){
            // [view setHidden:hidden];
        } completion:nil];
    }
}




-(void)userProfileData
{
    [self.view addSubview:[ProgressViewController sharedProgressVC].view];
    NSDictionary * item = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER"];
    NSDictionary * parameters = @{@"userId":item[@"id"]};
    [[Network networkManager]userProfileData:parameters complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                self.cardNumberlabel.text = jsonDict[@"card_number"];
                self.mobailNuLabel.text =  jsonDict[@"mobile"];
                self.emailLabel.text =  jsonDict[@"email"];
                
            }else{
                
            }
            [ProgressViewController sharedProgressVC].view.hidden = YES;;
           
        });
    }];
}

@end
