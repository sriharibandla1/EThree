//
//  CartViewController.m
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "CartViewController.h"
#import "SupportedFiles/ForCoreDataMethods.h"
#import "CheckOutViewController.h"
#import "HomeViewController.h"
//#import "Paytm Sdk/include/PaymentsSDK.h"
#import "SupportedFiles/Network.h"
@implementation CartTableViewCell
@end

static NSString *kMerchantChecksumGenURL = @"http://ethree.in/api/generateChecksum";
static NSString *kMerchantChecksumValURL = @"https://myservant.com/Paytm_App_Checksum_Kit_PHP-master/verifyChecksum.php";

#define MID                     @"CMRVIC06523215343586"
#define CHANNELID               @"WAP"
#define INDUSTRYTYPEID          @"Grocery"
#define WEBSITE                 @"CMRVICWAP"
#define CALLBACKURL             @"https://securegw.paytm.in/theia/paytmCallback"
#define MERCHANTID              @"CMRVIC06523215343586"
#define WEBSITE                 @"CMRVICWAP"
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property NSArray*dataFromCoreData;
@property NSInteger positionInCart;
@property(nonatomic, strong)NSDictionary *transaction;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromServer];
    
    self.cartTableView.tableFooterView = [UIView new];
    [self.placeOrderButton addTarget:self action:@selector(forCheckOutAction) forControlEvents:UIControlEventTouchUpInside];
    //self.placeOrderButton.layer.cornerRadius = self.placeOrderButton.frame.size.height/2;
}
-(void)getDataFromServer
{
    self.dataFromCoreData = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    [self setPriceLabel];
    
    if (self.dataFromCoreData.count == 0) {
        self.emptyCartView.hidden = NO;
//        self.totalAmountView.hidden = YES;
//        self.feeLabel.hidden = YES;
//        self.feeMainLabel.hidden = YES;
//        self.subTotalValueLabel.hidden = YES;
//        self.subTotalLabel.hidden = YES;
        
    }else{
        self.emptyCartView.hidden = YES;
//        self.totalAmountView.hidden = NO;
//        self.feeLabel.hidden = NO;
//        self.feeMainLabel.hidden = NO;
//        self.subTotalValueLabel.hidden = NO;
//        self.subTotalLabel.hidden = NO;
        
    }
    [self.cartTableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataFromCoreData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CartTableViewCellId"];
    NSDictionary*item = self.dataFromCoreData[indexPath.row];
    cell.addBt.tag = indexPath.row;
    cell.subBt.tag = indexPath.row;
    cell.delectBt.tag = indexPath.row;
    cell.nameOfItemLabel.text = item[@"product_name"];
    cell.quantityLabel.text = item[@"qtyList"];
    cell.priceOfItemLabel.text = [NSString stringWithFormat:@"Rs.%li",[item[@"product_price"]integerValue]];
    cell.totalCostOfItemLabel.text = [NSString stringWithFormat:@"Sub Total Rs.%li",[item[@"product_price"]integerValue]*[item[@"qtyList"]integerValue]];
    cell.cellView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.cellView.layer.shadowOpacity = 1;
    cell.cellView.layer.shadowOffset = CGSizeMake(.5f,1);
    cell.cellView.layer.shadowRadius = 2;
    cell.cellView.layer.masksToBounds = false;
    cell.cellView.layer.cornerRadius = 15;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)delectAction:(UIButton *)sender {
    [[ForCoreDataMethods networkManager]delectItemFromCoreData:self.dataFromCoreData[sender.tag]];
    [self getDataFromServer];
}
- (IBAction)addAction:(UIButton *)sender {
    [self addItemInCart:self.dataFromCoreData[sender.tag]];
}
- (IBAction)subAction:(UIButton *)sender {
    [self subItemInCart:self.dataFromCoreData[sender.tag]];
}

- (IBAction)homeBtnAction:(UIButton *)sender {
    HomeViewController * view  = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewControllerId"];
    
    [self.navigationController pushViewController:view animated:YES];
}

-(void)addItemInCart:(NSDictionary*)item
{
    [self isInCart:item];
    NSInteger quantity = [item[@"qtyList"]integerValue];
    quantity = quantity + 1;
    [[ForCoreDataMethods networkManager]upDataInCoreData:self.positionInCart product_code:item[@"product_code"] product_price:item[@"product_price"] qtyList:[NSString stringWithFormat:@"%li",quantity] product_weight_id:item[@"product_weight_id"] product_weight:item[@"product_weight"] product_name:item[@"product_name"]];
    [self getDataFromServer];
}
-(void)subItemInCart:(NSDictionary*)item
{
    
    [self isInCart:item];
    NSInteger quantity = [item[@"qtyList"]integerValue];
    quantity = quantity - 1;
    if (quantity == 0) {
        [[ForCoreDataMethods networkManager]delectItemFromCoreData:item];
    }
    else
    {
        [[ForCoreDataMethods networkManager]upDataInCoreData:self.positionInCart product_code:item[@"product_code"] product_price:item[@"product_price"] qtyList:[NSString stringWithFormat:@"%li",quantity] product_weight_id:item[@"product_weight_id"] product_weight:item[@"product_weight"] product_name:item[@"product_name"]];
    }
    [self getDataFromServer];
    
}
-(BOOL)isInCart:(NSDictionary*)item {
    NSArray * itemArray = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    
    for (int i = 0; i<itemArray.count; i++) {
        if ([item[@"product_code"] isEqualToString:[[itemArray objectAtIndex:i]valueForKey:@"product_code"]]) {
            self.positionInCart = i;
            return YES;
        }
    }
    return NO;
}
-(void)setPriceLabel
{
     NSInteger total = 0;
    NSArray*cartArray = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    for (int i = 0 ; i < cartArray.count; i++) {
        NSDictionary * item = cartArray[i];
        total = total + [item[@"product_price"]integerValue] * [item[@"qtyList"]integerValue];
    }
    self.itemAndPriceLabel.text = [NSString stringWithFormat:@"Total Amount Rs.%li",total];
//    self.subTotalValueLabel.text = [NSString stringWithFormat:@"Rs.%li",total];
//    self.finalTotalLabel.text = [NSString stringWithFormat:@"Rs.%li",total + 40];
}
-(void)forCheckOutAction
{
    CheckOutViewController*view = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckOutViewControllerId"];
    [self.navigationController pushViewController:view animated:YES];
}
//- (void)setDefaultMerchantParamsAndFields
//{
//    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"Client" ofType:@"p12"];
//    
//    PGMerchantConfiguration *merchant = [PGMerchantConfiguration defaultConfiguration];
//    merchant.clientSSLCertPath = certPath;
//    merchant.clientSSLCertPassword = @"admin";
//    merchant.merchantID = MERCHANTID;
//    merchant.website = WEBSITE;
//    merchant.industryID = INDUSTRYTYPEID;
//    merchant.checksumGenerationURL = kMerchantChecksumGenURL;
//    merchant.theme = @"javas";
//}
//+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix
//{
//    srand ( (unsigned)time(NULL) );
//    NSInteger randomNo = rand();
//    NSString *orderID = [NSString stringWithFormat:@"%@%ld", prefix, (long)randomNo];
//    return orderID;
//}
//+(NSString*)generateCustomerID
//{
//    srand ( (unsigned)time(NULL) );
//    NSInteger randomNo = rand();
//    NSString *orderID = [NSString stringWithFormat:@"CUST%ld", (long)randomNo];
//    return orderID;
//}
//- (void)updateMerchantConfigurationWithLatestValues
//{
//    PGMerchantConfiguration *defaultConfig = [PGMerchantConfiguration defaultConfiguration];
//    defaultConfig.merchantID = self.merchantID;
//    defaultConfig.channelID = self.channelID;
//    defaultConfig.industryID = self.industryTypeID;
//    defaultConfig.website = self.website;
//    defaultConfig.theme = self.theme;
//    [PGMerchantConfiguration defaultConfiguration].checksumGenerationURL = nil;
//    [PGMerchantConfiguration defaultConfiguration].checksumValidationURL = nil;
//}
//-(NSString *)getRandomPINString:(NSInteger)length
//{
//    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
//    
//    NSString *numbers = @"0123456789";
//    
//    // First number cannot be 0
//    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
//    for (int i = 1; i < length; i++)
//    {
//        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
//    }
//    
//    return returnString;
//}
//
//-(void)completeTransaction:(NSDictionary *)checkSumResponse
//{
//    NSMutableDictionary *payTmTxn = [NSMutableDictionary dictionaryWithDictionary:self.transaction];
//    [payTmTxn setValue:[NSString stringWithFormat:@"%@?ORDER_ID=%@",CALLBACKURL, self.paytmOrderID] forKey:@"CALLBACK_URL"];
//    [payTmTxn setValue:checkSumResponse[@"CHECKSUMHASH"] forKey:@"CHECKSUMHASH"];
//    //[payTmTxn setValue:@"DEFAULT" forKey:@"REQUEST_TYPE"];
//    
//    PGOrder *order = [PGOrder orderForOrderID:self.paytmOrderID
//                                   customerID:@"333"
//                                       amount:@"22"
//                                 customerMail:self.custeMail
//                               customerMobile:self.custMobileNo];
//    order.params =   payTmTxn;
//    [PGServerEnvironment createProductionEnvironment];
//    // [PGServerEnvironment selectServerDialog:self.view completionHandler:^(ServerType type)
//    {
//        PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
//        txnController.loggingEnabled = YES;
//        
//        //if (type != eServerTypeNone)
//        //   txnController.serverType = eServerTypeNone;
//        //else return;
//        txnController.merchant = [PGMerchantConfiguration defaultConfiguration];
//        txnController.delegate = self;
//        //txnController.tabBarController.navigationController.navigationBarHidden = YES;
//        //tl84shzNwsvUDsMxDROQ1RKHWdBmKKxEYScOj5ycxSXFYHBVKA
//        [self.navigationController pushViewController:txnController animated:YES];
//        
//    }//];
//}
//-(void)goPaytmViewController
//{
//    //========= need to change the amount================
//    // self.totalAmount = self.finalAmountAfterAddGST;
//    self.customerID = [@"CUST" stringByAppendingString:[self getRandomPINString:8]];
//    self.paytmOrderID = [@"ORDE" stringByAppendingString:[self getRandomPINString:8]];
//    self.transaction = @{
//                         @"MID" : MID,
//                         @"ORDER_ID": self.paytmOrderID,
//                         @"CUST_ID" : @"333",
//                         @"CHANNEL_ID": CHANNELID,
//                         @"INDUSTRY_TYPE_ID": INDUSTRYTYPEID,
//                         @"WEBSITE": WEBSITE,
//                         @"TXN_AMOUNT": @"22",
//                         @"CALLBACK_URL":CALLBACKURL
//                         };
//    /*http://ethree.in/api/generateChecksum
//     {
//     "ORDER_ID": "61",
//     "CUST_ID": "123",
//     "CHANNEL_ID": "529592",
//     "WEBSITE": "529592",
//     "TXN_AMOUNT": "100",
//     "INDUSTRY_TYPE_ID":"WEB"
//     }*/
//    NSDictionary*dicToGenCheckSum = @{@"ORDER_ID": self.paytmOrderID,
//                                      @"CUST_ID" : @"333",
//                                      @"TXN_AMOUNT": @"22"
//                                      };
//    [self.tabBarController.navigationController setNavigationBarHidden:true];
//    self.tabBarController.navigationController.navigationBarHidden = true;
//   // NSLog(@"Transaction:%@",self.transaction);
//    [[Network networkManager] PaytmGetCheckSum:kMerchantChecksumGenURL withParam:dicToGenCheckSum  complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
//        NSLog(@"Paytm CheckSum:%@",jsonDict);
//        NSLog(@"Response: %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self completeTransaction:jsonDict];
//        });
//    }];
//}

@end
