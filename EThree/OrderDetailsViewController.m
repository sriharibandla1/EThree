//
//  OrderDetailsViewController.m
//  E3
//
//  Created by Kardas Veeresham on 4/1/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/ProgressViewController.h"

@implementation OrderDetailsTableViewCell @end
@interface OrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray * ordersDetailsArray;
@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ordersDetailsArray = [[NSMutableArray alloc]init];
    [self.orderDetailsTableView setShowsVerticalScrollIndicator:false];
    self.orderDetailsTableView.tableFooterView = [UIView new];
    [self orderDetailsData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsTableViewCellId"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (IBAction)shopAgainBtnAction:(UIButton *)sender {
    
}




-(void)orderDetailsData
{
    [self.view addSubview:[ProgressViewController sharedProgressVC].view];
     NSDictionary * item = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER"];
    NSDictionary * parameters = @{@"userCode":item[@"id"],@"user_token":@"123",@"orderId":self.orderIdString};
    [[Network networkManager]mySingleOrdersData:parameters complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSArray * array =  jsonDict[@"orderList"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jsonDict[@"responseCode"]integerValue] == 0) {
                for (int i = 0; i < array.count;i++) {
                    NSDictionary * item = array[i];
                    self.orderNumberLabel.text = item[@"orderId"];
                    self.discountChargeLabel.text = item[@"discountAmount"];
                    self.iteamTotalLabel.text = item[@"grandTotal"];
                  //  self.ordersDetailsArray = [[jsonDict valueForKey:@"orderList"] objectAtIndex:i];
                }
            }
            else{
                
            }
            [self.orderDetailsTableView reloadData];
            [ProgressViewController sharedProgressVC].view.hidden = YES;
        });
    }];
}


@end
