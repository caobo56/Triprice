//
//  APIClient.h
//  PoFeng
//
//  Created by Jia Xiaochao on 15/3/26.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface APIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)requestLogout:(NSString *)path
                       parameters:(id)params
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)request:(NSString *)path
                       parameters:(id)params
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)requestPath:(NSString *)path
                             parameters:(NSDictionary *)params
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

@end
