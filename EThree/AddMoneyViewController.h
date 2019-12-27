//
//  AddMoneyViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMoneyViewController : UIViewController
- (IBAction)backBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *availableBalanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *proceedBtn;
@property (weak, nonatomic) IBOutlet UITextField *enterAmountTextField;
@property (weak, nonatomic) IBOutlet UIView *hunderedView;
@property (weak, nonatomic) IBOutlet UIView *twoHunderedView;
@property (weak, nonatomic) IBOutlet UIView *fiveHunderedView;
@property (weak, nonatomic) IBOutlet UIView *thousendView;
@property (weak, nonatomic) IBOutlet UIView *fifteenHunderdView;
@property (weak, nonatomic) IBOutlet UIView *twothousendView;


@property (weak, nonatomic) IBOutlet UIView *addMoneyView;

@end
