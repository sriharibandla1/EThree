//
//  Network.h
//  ChickyCharChar
//
//  Created by Kardas Veeresham on 1/2/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERID [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"]
typedef void(^CompletionBlockWithData)(NSDictionary *jsonDict, NSURLResponse *response, NSError *error);
typedef void(^CompletionBlockWithString)(NSString *string, NSURLResponse *response, NSError *error);
@interface Network : NSObject
+(Network *)networkManager;

-(void)bannerList:(NSString*)UrlString complete:(CompletionBlockWithData )complete;
-(void)vendorListData:(NSString*)UrlString complete:(CompletionBlockWithData )complete;
- (void)vendorproductsData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;


- (void)login:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
- (void)signUp:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
- (void)userProfileData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
- (void)verifyOtpData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
- (void)userordersData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
- (void)mySingleOrdersData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
- (void)cardDetailsData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;

-(void)PaytmGetCheckSum:(NSString *) url  withParam:(NSDictionary*)params complete:(CompletionBlockWithData)complete;
-(void)loadPaytmCheckSum:(CompletionBlockWithString)complete;
-(void)PaytmGetCheckSum:(NSDictionary*)userDetails complete:(CompletionBlockWithData)complete;
@end


