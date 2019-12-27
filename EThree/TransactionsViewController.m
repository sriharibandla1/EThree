//
//  TransactionsViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/23/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "TransactionsViewController.h"

@implementation TransactionsTableViewCell

@end
@interface TransactionsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TransactionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transactionesTableView.showsVerticalScrollIndicator = false;
    self.addMoneyButton.layer.cornerRadius = self.addMoneyButton.frame.size.height/2;
}



- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransactionsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionsTableViewCellId"];
    
    
    cell.cellView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.cellView.layer.shadowOpacity = 1;
     cell.cellView.layer.shadowOffset = CGSizeMake(.5f,1);
     cell.cellView.layer.shadowRadius = 2;
     cell.cellView.layer.masksToBounds = false;
    cell.cellView.layer.cornerRadius = 10;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (IBAction)addmoneyBtnAction:(UIButton *)sender {
    
}

@end
