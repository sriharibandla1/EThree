//
//  OrdersViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;
@property (weak, nonatomic) IBOutlet UILabel *norecordsLabel;

@end



@interface OrdersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountlabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@end
