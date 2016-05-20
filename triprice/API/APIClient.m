//
//  APIClient.m
//  PoFeng
//
//  Created by Jia Xiaochao on 15/3/26.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import "APIClient.h"
#import "AppDelegate.h"




static NSString * const BaseURLString = SERVER_URL;

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)requestLogout:(NSString *)path
                       parameters:(id)params
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary* newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *newPath = nil;
    if ([path hasPrefix:@"/"]){
        newPath = [path substringFromIndex:1];
    }else{
        newPath = path;
    }
    NSURLSessionDataTask *dataTask = [[APIClient sharedClient] POST:path
                                                         parameters:newParams
                                                            success:success
                                                            failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}



- (NSURLSessionDataTask *)request:(NSString *)path
                       parameters:(id)params
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary* newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *newPath = nil;
    if ([path hasPrefix:@"/"])
    {
        newPath = [path substringFromIndex:1];
    }
    else
    {
        newPath = path;
    }
    
    NSURLSessionDataTask *dataTask = [[APIClient sharedClient] POST:path
                                                         parameters:newParams
                                                            success:success
                                                            failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)requestPath:(NSString *)path
                             parameters:(NSDictionary *)params
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSDictionary *newParams = [self constructParameters:params];
    return [super POST:path parameters:newParams constructingBodyWithBlock:block success:success failure:failure];
}

- (NSDictionary *)constructParameters:(NSDictionary *)params
{
    NSMutableDictionary* newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    return newParams;
}
@end

