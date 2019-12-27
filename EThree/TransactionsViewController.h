//
//  TransactionsViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/23/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *transactionesTableView;
@property (weak, nonatomic) IBOutlet UIButton *addMoneyButton;

@end

@interface TransactionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end

