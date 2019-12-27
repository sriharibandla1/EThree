//
//  CheckOutViewController.m
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "CheckOutViewController.h"
#import "SuccessViewController.h"
#import "EThreeCardViewController.h"
#import "SupportedFiles/ForCoreDataMethods.h"
#import "paytmSDK/bitcodeDisable/include/PaymentsSDK.h"
#import "SupportedFiles/Network.h"
@interface CheckOutViewController ()


@property(nonatomic, strong)NSDictionary *transaction;
//@property NSString*forTypeOfMode;
@property NSString * CALLBACK_URL;
@property NSString * paytmOrderID;
@property NSString * customerID;
@property NSString * typeOfPayment;
@end
//https://securegw.paytm.in/theia/paytmCallback
//http://ethree.in/api/generateChecksum
static NSString *kMerchantChecksumGenURL = @"http://ethree.in/api/generateChecksum";
/*http://ethree.in/api/generateChecksum
 {
 "ORDER_ID": "61",
 "CUST_ID": "123",
 "CHANNEL_ID": "529592",
 "WEBSITE": "529592",
 "TXN_AMOUNT": "100",
 "INDUSTRY_TYPE_ID":"WEB"
 }*/
#define CHANNELID               @"WAP"
#define INDUSTRYTYPEID          @"Retail109"
//#define WEBSITE                 @"CMRVICWAP"
//#define CALLBACKURL             @"https://securegw.paytm.in/theia/paytmCallback"
#define MERCHANTID              @"JAANEN72806224056120"
#define WEBSITE                 @"APPPROD"
#define TOTALAMOUNT             @"200"
#define CUST_ID                 @"123"
@implementation CheckOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.payWithYourE3CardButton.layer.cornerRadius = self.payWithYourE3CardButton.frame.size.height/2;
    self.walletIsSelected = NO;
    [self setPriceLabel];
    self.codButton.layer.cornerRadius = self.codButton.frame.size.height/2;
    self.codButton.layer.cornerRadius = self.codButton.frame.size.height/2;
    self.onlinePaymentButton.layer.cornerRadius = self.onlinePaymentButton.frame.size.height/2;
}



- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)codBtnAction:(UIButton *)sender {
   // self.codButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:144.0/255.0 blue:81.0/255.0 alpha:1];
    self.payTmRadioImage.image = [UIImage imageNamed:@"radioOff"];
    self.codRadioImage.image = [UIImage imageNamed:@"chickCircleWith"];
   // self.onlinePaymentButton.backgroundColor = [UIColor lightGrayColor];
    self.typeOfPayment = @"cod";
     self.coninueButton.hidden = NO;
    
}
- (IBAction)onlinePaymentBtnAction:(UIButton *)sender {
    //self.codButton.backgroundColor = [UIColor lightGrayColor];
   // self.onlinePaymentButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:144.0/255.0 blue:81.0/255.0 alpha:1];
    self.payTmRadioImage.image = [UIImage imageNamed:@"chickCircleWith"];
    self.typeOfPayment = @"Paytm";
    self.codRadioImage.image = [UIImage imageNamed:@"radioOff"];
     self.coninueButton.hidden = NO;
}
- (IBAction)continueBtnAction:(UIButton *)sender {
    if ([self.typeOfPayment isEqualToString:@"Paytm"]) {
        [self goPaytmViewController];
    }
    else
    {
    SuccessViewController*view = [self.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewControllerId"];
    [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)setPriceLabel
{
    float total = 0;
    NSArray*cartArray = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    for (int i = 0 ; i < cartArray.count; i++) {
        NSDictionary * item = cartArray[i];
        total = total + [item[@"product_price"]floatValue] * [item[@"qtyList"]floatValue];
    }
    float gst = total * 5 / 100;
        self.totalAmountLabel.text = [NSString stringWithFormat:@"Rs.%.02f",total + gst];
    
    self.itemTotalLabel.text = [NSString stringWithFormat:@"Rs.%.02f",total];
    self.taxLabel.text = [NSString stringWithFormat:@"+Rs.%.02f",gst];
    self.walletTitleLabel.text = @"EThree Card Balance : Rs. 50.00";
    if (self.walletIsSelected) {
        self.grandTotalLabel.text = [NSString stringWithFormat:@"Rs.%.02f",total + gst - 50];
        self.walletAmountLabel.text = @"-Rs.50.00";
    }
    else
    {
         self.grandTotalLabel.text = [NSString stringWithFormat:@"Rs.%.02f",total + gst];
        self.walletAmountLabel.text = @"-Rs.00.00";
    }
}
- (IBAction)WalletAction:(UIButton *)sender {
    if (self.walletIsSelected) {
        self.walletIsSelected = NO;
        self.payUsingWalletRadioImage.image = [UIImage imageNamed:@"Unclicked"];
    }
    else
    {
        self.walletIsSelected = YES;
        self.payUsingWalletRadioImage.image = [UIImage imageNamed:@"clicked"];
    }
    [self setPriceLabel];
}
-(void)didFinishedResponse:(PGTransactionViewController *)controller response:(NSString *)responseString
{
    NSLog(@"finished response");
    [controller.navigationController popViewControllerAnimated:YES];
}
-(void)didCancelTrasaction:(PGTransactionViewController *)controller
{
    NSLog(@"fail response");
    [controller.navigationController popViewControllerAnimated:YES];
}
-(void)errorMisssingParameter:(PGTransactionViewController *)controller error:(NSError *) error
{
    NSLog(@"error response");
    
    [controller.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setDefaultMerchantParamsAndFields
{
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"Client" ofType:@"p12"];
    
    PGMerchantConfiguration *merchant = [PGMerchantConfiguration defaultConfiguration];
    merchant.clientSSLCertPath = certPath;
    merchant.clientSSLCertPassword = @"admin";
    merchant.merchantID = MERCHANTID;
    merchant.website = WEBSITE;
    merchant.industryID = INDUSTRYTYPEID;
    merchant.channelID = CHANNELID;
    merchant.checksumGenerationURL = kMerchantChecksumGenURL;
    merchant.theme = @"javas";
}
+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix
{
    srand ( (unsigned)time(NULL) );
    NSInteger randomNo = rand();
    NSString *orderID = [NSString stringWithFormat:@"%@%ld", prefix, (long)randomNo];
    return orderID;
}
+(NSString*)generateCustomerID
{
    srand ( (unsigned)time(NULL) );
    NSInteger randomNo = rand();
    NSString *orderID = [NSString stringWithFormat:@"CUST%ld", (long)randomNo];
    return orderID;
}

- (void)updateMerchantConfigurationWithLatestValues
{
    PGMerchantConfiguration *defaultConfig = [PGMerchantConfiguration defaultConfiguration];
    defaultConfig.merchantID = MERCHANTID;
    defaultConfig.channelID = CHANNELID;
    defaultConfig.industryID = INDUSTRYTYPEID;
    defaultConfig.website = WEBSITE;
    defaultConfig.theme = @"javas";
    [PGMerchantConfiguration defaultConfiguration].checksumGenerationURL = nil;
    [PGMerchantConfiguration defaultConfiguration].checksumValidationURL = nil;
}

-(NSString *)getRandomPINString:(NSInteger)length
{
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    for (int i = 1; i < length; i++)
    {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    
    return returnString;
}
-(void)completeTransaction:(NSDictionary *)checkSumResponse
{
    /*paramMap.put("CALLBACK_URL", callback_url);
     paramMap.put("CHANNEL_ID", "WAP");
     paramMap.put("CHECKSUMHASH", checkSum1);
     paramMap.put("CUST_ID", custid);
     paramMap.put("INDUSTRY_TYPE_ID", "Retail");
     paramMap.put("MID", "JAANEN34747061729929");
     paramMap.put("ORDER_ID", orderId);
     paramMap.put("TXN_AMOUNT", grandTotal);
     paramMap.put("MOBILE_NO", mobileNo);
     paramMap.put("EMAIL", emailId);
     //        paramMap.put("TXN_AMOUNT", "1.00" );
     paramMap.put("WEBSITE", "WEBSTAGING");*/
    self.CALLBACK_URL = [[checkSumResponse valueForKey:@"parameterlist"]valueForKey:@"CALLBACK_URL"];
    NSMutableDictionary *payTmTxn = [NSMutableDictionary dictionaryWithDictionary:self.transaction];
    [payTmTxn setValue:self.CALLBACK_URL forKey:@"CALLBACK_URL"];
    [payTmTxn setValue:CHANNELID forKey:@"CHANNEL_ID"];
    [payTmTxn setValue:INDUSTRYTYPEID forKey:@"INDUSTRY_TYPE_ID"];
    [payTmTxn setValue:MERCHANTID forKey:@"MID"];
    [payTmTxn setValue:WEBSITE forKey:@"WEBSITE"];
    //[payTmTxn setValue:@"DEFAULT" forKey:@"REQUEST_TYPE"];
    
    PGOrder *order = [PGOrder orderForOrderID:self.paytmOrderID
                                   customerID:@"366"
                                       amount:TOTALAMOUNT
                                 customerMail:@"sriharibandla1@gmail.com"
                               customerMobile:@"7777777777"
                      ];
    order.params =   payTmTxn;
    [PGServerEnvironment createProductionEnvironment];
    {
        PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
        txnController.loggingEnabled = YES;
        txnController.merchant = [PGMerchantConfiguration defaultConfiguration];
        txnController.delegate = self;
        
        [self.navigationController pushViewController:txnController animated:YES];
        
    }//];
}
- (void)beginPayment:(NSDictionary*)item{
    self.CALLBACK_URL = [[item valueForKey:@"parameterlist"]valueForKey:@"CALLBACK_URL"];
    PGOrder *order = [PGOrder orderForOrderID:self.paytmOrderID
                                   customerID:self.customerID
                                       amount:TOTALAMOUNT
                                 customerMail:@"sriharibandla1@gmail.com"
                               customerMobile:@"7777777777"];
    order.params =   @{@"MID" : MERCHANTID,
                       @"ORDER_ID": self.paytmOrderID,
                       @"CUST_ID" : @"366",
                       @"MOBILE_NO" : @"7777777777",
                       @"EMAIL" : @"sriharibandla1@gmail.com",
                       @"CHANNEL_ID": CHANNELID,
                       @"WEBSITE": WEBSITE,
                       @"TXN_AMOUNT": TOTALAMOUNT,
                       @"INDUSTRY_TYPE_ID": INDUSTRYTYPEID,
                       @"CHECKSUMHASH":item[@"CHECKSUMHASH"],
                       @"CALLBACK_URL":self.CALLBACK_URL
                       };
    PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
    txnController.loggingEnabled = YES;
    
    txnController.merchant = [PGMerchantConfiguration defaultConfiguration];
    txnController.delegate = self;
    [self.navigationController pushViewController:txnController animated:YES];
}
-(void)goPaytmViewController
{
    
    //========= need to change the amount================
    // self.totalAmount = self.finalAmountAfterAddGST;
    self.customerID = [@"CUST" stringByAppendingString:[self getRandomPINString:8]];
    self.paytmOrderID = [@"ORDE" stringByAppendingString:[self getRandomPINString:8]];
    self.transaction = @{
                         @"MID" : MERCHANTID,
                         @"ORDER_ID": self.paytmOrderID,
                         @"CUST_ID" : @"366",
                         @"CHANNEL_ID": CHANNELID,
                         @"INDUSTRY_TYPE_ID": INDUSTRYTYPEID,
                         @"WEBSITE": WEBSITE,
                         @"MOBILE_NO":@"7777777777",
                         @"EMAIL":@"sriharibandla1@gmail.com",
                         @"TXN_AMOUNT": TOTALAMOUNT
                         //,
                         //@"CALLBACK_URL":CALLBACKURL
                         };
    
    NSDictionary*dicToGenCheckSum = @{
                                      @"ORDER_ID": self.paytmOrderID,
                                      @"CUST_ID": @"366",
                                      @"TXN_AMOUNT": TOTALAMOUNT,
                                      @"MOBILE_NO":@"7777777777",
                                      @"EMAIL":@"sriharibandla1@gmail.com",
                                      @"INDUSTRY_TYPE_ID":INDUSTRYTYPEID,
                                      @"CHANNEL_ID":CHANNELID,
                                      @"WEBSITE":WEBSITE
                                      };
    [[Network networkManager] PaytmGetCheckSum:kMerchantChecksumGenURL withParam:dicToGenCheckSum  complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"Paytm CheckSum:%@",jsonDict);
        NSLog(@"Response: %@", response);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginPayment:jsonDict ];
            // [self completeTransaction:jsonDict];
        });
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.navigationController setNavigationBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO];
}
@end
