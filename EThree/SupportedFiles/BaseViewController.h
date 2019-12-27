//
//  BaseViewController.h
//  MyServant
//
//  Created by Gopal on 05/01/18.
//  Copyright © 2018 Gopal. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "IFNetworkManager.h"

#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height


@interface BaseViewController : UIViewController

-(void)showAlert:(NSString *)title message:(NSString *)message;
-(void)showResponseAlert:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion;
-(void)showAlert:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion;

+(BOOL)isValidePhonuNumber:(NSString *)phoneNumber;
+(BOOL)isValideEmail:(NSString *)email;
+(BOOL)isValidePassword:(NSString *)Password;


+(NSString *)dateStringFromDate:(NSDate *)date;
+(NSString *)timeStringFromDate:(NSDate *)date;

@end
