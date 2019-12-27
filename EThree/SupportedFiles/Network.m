//
//  Network.m
//  ChickyCharChar
//
//  Created by Kardas Veeresham on 1/2/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "Network.h"

@implementation Network
{
    CompletionBlockWithData categorieComplete;
    CompletionBlockWithData subCategorieComplete;
}

static Network *_sharedMySingleton = nil;
+(Network *)networkManager {
    @synchronized([Network class]) {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
        return _sharedMySingleton;
    }
    return nil;
}
+ (NSData *)synConnectionForUrl:(NSString *)urlString bodyAttachment:(NSDictionary *)bodyAttachment response:(NSURLResponse **)response error:(NSError **)error
{
    NSError *attachmentError = nil;;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyAttachment
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&attachmentError];
    if(attachmentError)
        return nil;
    NSString *jsonString = nil;
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", attachmentError);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSData *postData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    if(url == nil)
        return nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if(request == nil)
        return nil;
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/application-json" forHTTPHeaderField:@"Content-Type"];//x-www-form-urlencoded
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/application-json" forHTTPHeaderField:@"Accept"];
    //[request setHTTPBody:postData];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return data;
}

// parameters

-(void)loadRequestForUrl:(NSString *)urlString methodType:(NSString*)methodType dic:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSError * error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPMethod:methodType];
    [request setHTTPBody:jsonData];
     [request setValue:@"1234" forHTTPHeaderField:@"e3restKey"];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSError *parseError;
                                                    if(data == nil || data.length == 0)
                                                    {
                                                        complete(nil, response, error);
                                                    }
                                                    else
                                                    {
                                                        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                        complete(json, response, error);
                                                    }
                                                }];
    [dataTask resume];
}


// parms

-(void)loadRequestWithOutBodyForUrl:(NSString *)urlString methodType:(NSString*)methodType complete:(CompletionBlockWithData )complete
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:methodType];
     [request setValue:@"1234" forHTTPHeaderField:@"e3restKey"];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSError *parseError;
                                                    if(data == nil || data.length == 0)
                                                    {
                                                        complete(nil, response, error);
                                                    }
                                                    else
                                                    {
                                                        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                        complete(json, response, error);
                                                    }
                                                    
                                                    
                                                }];
    [dataTask resume];
}



-(NSString *)urlStringFromDictionary:(NSDictionary *)dictionary
{
    NSString *string = @"";
    NSArray *keys = dictionary.allKeys;
    NSInteger count = keys.count;
    for (int i=0; i<count; i++)
    {
        NSString *key = keys[i];
        NSString *value = dictionary[key];
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        if(i+1 != count)
        {
            string = [string stringByAppendingString:@"&"];
        }
    }
    return string;
}

//http://ethree.in/api/bannerList
-(void)bannerList:(NSString*)UrlString complete:(CompletionBlockWithData )complete
{
    // NSString* urlString = @"http://ethree.in/api/bannerList";
    [self loadRequestWithOutBodyForUrl:UrlString methodType:@"GET" complete:complete];
}
- (void)vendorproductsData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    //http://ethree.in/api/vendorproduct
    NSString* urlString = @"http://ethree.in/api/vendorproduct";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}


-(void)vendorListData:(NSString*)UrlString complete:(CompletionBlockWithData )complete
{
    // NSString* urlString = @"http://ethree.in/api/vendorList";
    [self loadRequestWithOutBodyForUrl:UrlString methodType:@"POST" complete:complete];
}
- (void)login:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    //http://ethree.in/api/vendorproduct
    NSString* urlString = @"http://ethree.in/api/userLogin";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}
- (void)signUp:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    //http://ethree.in/api/vendorproduct
    NSString* urlString = @"http://ethree.in/api/signUp";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}


- (void)userProfileData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    /*
     {
     "userId":"1"
     }
     */
    //http://ethree.in/api
    NSString* urlString = @"http://ethree.in/api/userProfile";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}

- (void)verifyOtpData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    
    NSString* urlString = @"http://ethree.in/api/verifyOtp";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}


- (void)userordersData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    
    NSString* urlString = @"http://ethree.in/api/userorders";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}

- (void)mySingleOrdersData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    /*
     {
     "userCode": "61",
     "user_token": "123",
     "orderId": "529592"
     }
     */
    
    NSString* urlString = @"http://ethree.in/api/mySingleOrders";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:parameters complete:complete];
}

- (void)cardDetailsData:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    NSString *parametersString = [self urlStringFromDictionary:parameters];
    NSString* urlString = @"http://ethree.in/api/cardDetail";
    NSString *completeUrlString = [NSString stringWithFormat:@"%@?%@",urlString,parametersString];
    completeUrlString = [completeUrlString stringByAddingPercentEscapesUsingEncoding:
                         NSUTF8StringEncoding];
     [self loadRequestWithOutBodyForUrl:completeUrlString methodType:@"GET" complete:complete];
}




-(void)PaytmGetCheckSum:(NSString *) url  withParam:(NSDictionary*)params complete:(CompletionBlockWithData)complete
{
    //?ORDER_ID=MYSER-FOODlec650
    NSString *parametersString = [self urlStringFromDictionary:params];
    NSString *urlString = url;
    NSString *completeUrlString = [NSString stringWithFormat:@"%@?%@",urlString,parametersString];
    completeUrlString = [completeUrlString stringByAddingPercentEscapesUsingEncoding:
                         NSUTF8StringEncoding];
    [self loadRequestWithOutBodyForUrl:@"" methodType:@"GET" complete:complete];
   // [self loadGetRequestForUrl:completeUrlString complete:complete];
    //[self loadRequestForUrl:completeUrlString complete:complete];
}
///=========================

-(void)loadPaytmCheckSum:(CompletionBlockWithString)complete
{
    //    [self loadRequestForUrl:@"https://myservant.com/Paytm_App_Checksum_Kit_PHP-master/" methodType:@"GET" complete:complete];
    
    NSDictionary *headers = @{ @"Cache-Control": @"no-cache"};
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://myservant.com/Paytm_App_Checksum_Kit_PHP-master/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSError *parseError;
                                                    if(data == nil || data.length == 0)
                                                    {
                                                        complete(nil, response, error);
                                                    }
                                                    else
                                                    {
                                                        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                        complete(string, response, error);
                                                    }
                                                    
                                                    
                                                }];
    [dataTask resume];
}




-(void)loadChickSum:(CompletionBlockWithData)complete
{
    //    [self loadRequestForUrl:@"https://myservant.com/Paytm_App_Checksum_Kit_PHP-master/" methodType:@"GET" complete:complete];
    {
        NSDictionary *headers = @{ @"Cache-Control": @"no-cache"};
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://myservant.com/Paytm_App_Checksum_Kit_PHP-master/"]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10.0];
        [request setHTTPMethod:@"GET"];
        [request setAllHTTPHeaderFields:headers];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        NSError *parseError;
                                                        if(data == nil || data.length == 0)
                                                        {
                                                            complete(nil, response, error);
                                                        }
                                                        else
                                                        {
                                                            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                            complete(json, response, error);
                                                        }
                                                    }];
        [dataTask resume];
    }
}

@end
