//
//  OrdersViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "OrdersViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/ProgressViewController.h"
#import "OrderDetailsViewController.h"

@implementation OrdersTableViewCell  @end

@interface OrdersViewController ()<UITableViewDelegate, UITableViewDataSource>
@property NSArray * orderListArray;
@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.navigationController setNavigationBarHidden:YES];
    self.ordersTableView.delegate = self;
    self.ordersTableView.dataSource = self;
    
    [self.ordersTableView setShowsVerticalScrollIndicator:false];
    self.ordersTableView.tableFooterView = [UIView new];
    [self orderData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdersTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersTableViewCellId"];
    NSDictionary * item = self.orderListArray[indexPath.row];
    NSString * orderid = [[[item valueForKey:@"ProductList"]objectAtIndex:0]valueForKey:@"orderId"];
    cell.orderIdLabel.text = [NSString stringWithFormat:@"Order Id: %@",orderid];
    cell.orderDateLabel.text = item[@"orderDate"];
    cell.totalAmountlabel.text = item[@"grandTotal"];
    cell.orderStatusLabel.text = [NSString stringWithFormat:@"Order Status:- %@",item[@"orderStatus"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * item = self.orderListArray[indexPath.row];
    NSString * orderid = [[[item valueForKey:@"ProductList"]objectAtIndex:0]valueForKey:@"orderId"];
    OrderDetailsViewController * view  = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailsViewControllerId"];
    view.orderIdString = orderid;
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 - (CGFloat)getLabelHeight:(NSString*)text
 {
 CGSize constraint = CGSizeMake(self.view.frame.size.width - 30, CGFLOAT_MAX);
 CGSize size;
 NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
 CGSize boundingBox = [text boundingRectWithSize:constraint
 options:NSStringDrawingUsesLineFragmentOrigin
 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}
 context:context].size;
 
 size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
 
 return size.height;
 }
 */


-(void)orderData
{
    [self.view addSubview:[ProgressViewController sharedProgressVC].view];
     NSDictionary * item = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER"];
    NSDictionary * parameters = @{@"userCode":item[@"id"],@"user_token":@"123"};
    [[Network networkManager]userordersData:parameters complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                self.orderListArray = jsonDict[@"orderList"];
                self.norecordsLabel.hidden = YES;
            }
            else{
                self.norecordsLabel.hidden = NO;
            }
            [self.ordersTableView reloadData];
            [ProgressViewController sharedProgressVC].view.hidden = YES;
        });
    }];
}

@end
