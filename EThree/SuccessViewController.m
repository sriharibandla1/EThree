//
//  SuccessViewController.m
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "SuccessViewController.h"
#import "HomeViewController.h"
#import "SupportedFiles/ForCoreDataMethods.h"

@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.successView.layer.cornerRadius = 50;
     self.continueButton.layer.cornerRadius = self.continueButton.frame.size.height/2;
    
}

- (IBAction)continueBtnAction:(UIButton *)sender {
    HomeViewController*view = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewControllerId"];
    [[ForCoreDataMethods networkManager]deleteData];
    [self.navigationController pushViewController:view animated:YES];
}

@end
