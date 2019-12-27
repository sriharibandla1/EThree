//
//  ForCoreDataMethods.h
//  asap
//
//  Created by Gopal Gundaram on 21/11/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForCoreDataMethods : NSObject
+(ForCoreDataMethods *)networkManager;
-(void)storeDataInCoreDataproduct_code:(NSString*)product_code product_price:(NSString*)product_price qtyList:(NSString*)qtyList product_weight_id:(NSString*)product_weight_id product_weight:(NSString*)product_weight product_name:(NSString*)product_name;
-(NSArray*)getDateFromCoreDate;
-(void)upDataInCoreData: (NSUInteger)postion product_code:(NSString*)product_code product_price:(NSString*)product_price qtyList:(NSString*)qtyList product_weight_id:(NSString*)product_weight_id product_weight:(NSString*)product_weight product_name:(NSString*)product_name;
-(void)delectItemFromCoreData:(NSDictionary*)position;
-(void)deleteData;
@end
