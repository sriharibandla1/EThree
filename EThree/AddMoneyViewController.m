//
//  AddMoneyViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "AddMoneyViewController.h"

@interface AddMoneyViewController ()

@end

@implementation AddMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self AddMoneyViewCurverdCode];
    self.proceedBtn.layer.cornerRadius = self.proceedBtn.frame.size.height/2;
}

-(void)AddMoneyViewCurverdCode
{
    self.hunderedView.layer.borderWidth = 2;
    self.hunderedView.layer.borderColor = (UIColor.grayColor).CGColor;
    self.hunderedView.clipsToBounds = YES;
    self.hunderedView.layer.cornerRadius = self.hunderedView.frame.size.height/2;
    
    self.twoHunderedView.layer.borderWidth = 2;
    self.twoHunderedView.layer.borderColor = (UIColor.grayColor).CGColor;
    self.twoHunderedView.clipsToBounds = YES;
    self.twoHunderedView.layer.cornerRadius = self.twoHunderedView.frame.size.height/2;
    
    self.fiveHunderedView.layer.borderWidth = 2;
    self.fiveHunderedView.layer.borderColor = (UIColor.grayColor).CGColor;
    self.fiveHunderedView.clipsToBounds = YES;
    self.fiveHunderedView.layer.cornerRadius = self.fiveHunderedView.frame.size.height/2;
    
    self.thousendView.layer.borderWidth = 2;
    self.thousendView.layer.borderColor = (UIColor.grayColor).CGColor;
    self.thousendView.clipsToBounds = YES;
    self.thousendView.layer.cornerRadius = self.thousendView.frame.size.height/2;
    
    self.fifteenHunderdView.layer.borderWidth = 2;
    self.fifteenHunderdView.layer.borderColor = (UIColor.grayColor).CGColor;
    self.fifteenHunderdView.clipsToBounds = YES;
    self.fifteenHunderdView.layer.cornerRadius = self.fifteenHunderdView.frame.size.height/2;
    
    self.twothousendView.layer.borderWidth = 2;
    self.twothousendView.layer.borderColor = (UIColor.grayColor).CGColor;
    self.twothousendView.clipsToBounds = YES;
    self.twothousendView.layer.cornerRadius = self.twothousendView.frame.size.height/2;
    
    self.addMoneyView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
     self.addMoneyView.layer.shadowOpacity = 1;
     self.addMoneyView.layer.shadowOffset = CGSizeMake(.5f,1);
    self.addMoneyView.layer.shadowRadius = 2;
     self.addMoneyView.layer.masksToBounds = false;
     self.addMoneyView.layer.cornerRadius = 5;
    
}
-(void)addingNumber :(NSUInteger)sender
{
    long int i = [self.enterAmountTextField.text intValue];
    
    switch (sender) {
        case 1:
            self.enterAmountTextField.text = [NSString stringWithFormat:@"%ld",i + 100];
            break;
        case 2:
            self.enterAmountTextField.text = [NSString stringWithFormat:@"%ld",i + 200];
            break;
        case 3:
            self.enterAmountTextField.text = [NSString stringWithFormat:@"%ld",i + 500];
            break;
        case 4:
            self.enterAmountTextField.text = [NSString stringWithFormat:@"%ld",i + 1000];
            break;
        case 5:
            self.enterAmountTextField.text = [NSString stringWithFormat:@"%ld",i + 1500];
            break;
        case 6:
            self.enterAmountTextField.text = [NSString stringWithFormat:@"%ld",i + 2000];
            break;
        default:
            break;
    }
   
}


- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)peoceedBtnAction:(UIButton *)sender {
   
}
- (IBAction)hunderedBtnAction:(UIButton *)sender {
    [self addingNumber:sender.tag];
}
- (IBAction)twoHunderBtnAction:(UIButton *)sender {
    [self addingNumber:sender.tag];
}
- (IBAction)fiveHunderedBtnAction:(UIButton *)sender {
    [self addingNumber:sender.tag];
}
- (IBAction)thousendBtnAction:(UIButton *)sender {
    [self addingNumber:sender.tag];
}
- (IBAction)fifteenHunderdBtnAction:(UIButton *)sender {
    [self addingNumber:sender.tag];
}
- (IBAction)teoThousendBtnAction:(UIButton *)sender {
    [self addingNumber:sender.tag];
}


@end
