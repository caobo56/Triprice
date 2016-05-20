//
//  JDDAPI.m
//  jingduoduo
//
//  Created by caobo on 15/6/25.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import "JDDAPIs.h"
#import "APIClient.h"

#define kHostUrlString SERVER_URL   

#define kHomeBgImageURL           @"user/searchBgPic.do"
#define kRecommendSearchAll       @"recommend/searchAll.do"
#define kRecommendSearchDetail    @"recommend/searchRecommendDetail.do"
#define kDestinationSearch        @"destination/searchProject.do"
#define kDestinationDetailSearch  @"destination/searchProjectById.do"
#define kDestinationDetailListSearch  @"destination/searchProjectDetail.do"

#define kPublishRequire           @"require/publishRequire.do"
#define kBookingAddOrder          @"booking/addOrder.do"

#define kUserLogin                @"user/login.do"
#define kUserGetAuthCode          @"user/getAuthCode.do"
#define kUserRegist               @"user/regist.do"
#define kResetPasswordByMobileNum @"user/resetPasswordByMobileNum.do"
#define kUpdateUserInfo           @"user/updateUserInfo.do"
#define kSearchUserById           @"user/searchUserById.do"
#define ksearchDestinationCountry @"destination/searchDestinationCountry.do"
#define ksearchDestinationCity    @"destination/searchDestinationCity.do"

#define ksearchTouristItemByCity  @"destination/searchTouristItemByCity.do"

#define kspecialSearchAll         @"special/searchAll.do"
#define kspecialSearchSpecialById @"special/searchSpecialById.do"
#define ksearchScheduleBySpecialId @"special/searchScheduleBySpecialId.do"

#define ksearchSolutionById @"solution/searchSolutionById.do"
#define ksearchSolutionBySolutionId @"solution/searchSolutionBySolutionId.do"
#define kGetFreeTravlingDates @"special/searchSellDateBySpecialId.do"

@implementation JDDAPIs

+ (JDDAPIs *)sharedJDDAPIs
{
    static JDDAPIs *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[super alloc]init];
    });
    return _sharedClient;
}


/**
 *  网络请求
 */
- (void)postUrl:(NSString *)url withParameters:(NSDictionary *)parameters callback:(DictionaryResultsBlock)callback
{
    [[APIClient sharedClient] request:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject && [responseObject[@"isSuccess"] integerValue] == 1) {
            callback(responseObject, nil);
        }else if(responseObject && [responseObject[@"isSuccess"] integerValue] != 1){
            callback(nil, responseObject[@"errorMsg"]);
        }else {
            callback(nil, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //NSLog(@"网络请求失败");
        callback(nil, nil);
    }];
}

/**
 *  获取首页背景图链接
 */
- (void)getHomeBgImageURLWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kHomeBgImageURL];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *  获取每周推荐列表
 */
- (void)getRecommendSearchAllWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kRecommendSearchAll];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *  获取每周推荐详情
 */
- (void)getRecommendDetailWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kRecommendSearchDetail];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *  获取目的地列表
 */
-(void)getDestinationSearchHot:(id)parameters withBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:@""];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}


/**
 * 目的地产品列表
 */
- (void)getDestinationSearchWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kDestinationSearch];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *  获取目的地产品详情
 */
- (void)getDestinationDetailWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kDestinationDetailSearch];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *  获取目的地产品详情列表
 */
- (void)getDestinationDetailListWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kDestinationDetailListSearch];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}


/**
 * 发布需求
 */
- (void)publishRequireWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kPublishRequire];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *预订产品
 */
-(void)bookingAddOrderWithParmeters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kBookingAddOrder];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 * 登录
 */
-(void)loginWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    
    [urlString appendString:kHostUrlString];
    [urlString appendString:kUserLogin];
    
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 * 获取手机验证码
 */
-(void)getAuthCodeWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kUserGetAuthCode];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 * 注册
 */
-(void)userRegistWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kUserGetAuthCode];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 * 修改密码
 */
-(void)resetPasswordByMobileNumWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kResetPasswordByMobileNum];
    [self postUrl:urlString withParameters:parameters callback:callback];
}


/**
 * 更新个人信息
 */
-(void)updateUserInfoWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kUpdateUserInfo];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 * 查询用户信息byId
 */
-(void)searchUserByIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kSearchUserById];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *  2.2.9	查询目的地国家
 * destination/searchDestinationCountry.do
 */
-(void)searchDestinationCountryWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:ksearchDestinationCountry];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 根据国家查询城市
 destination/searchDestinationCity.do
 */
-(void)searchDestinationCityWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:ksearchDestinationCity];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 2.2.11	根据城市查询景点
 destination/searchTouristItemByCity.do
 */
-(void)searchTouristItemByCityWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:ksearchTouristItemByCity];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 *特色自由行
 *kspecialSearchAll
 */
-(void)specialSearchAllWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kspecialSearchAll];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 特色自由行详情
 special/searchSpecialById.do
 */
-(void)searchSpecialByIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kspecialSearchSpecialById];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 特色自由行详情详细行程
 special/searchScheduleBySpecialId.do
 */
-(void)searchScheduleBySpecialIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:ksearchScheduleBySpecialId];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 需求详情
 solution/searchSolutionById.do
 */
-(void)searchSolutionByIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:ksearchSolutionById];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 需求详情详细行程
 solution/searchSolutionBySolutionId.do
 */
-(void)searchSolutionBySolutionIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:ksearchSolutionBySolutionId];
    [self postUrl:urlString withParameters:parameters callback:callback];
}

/**
 获取自由行可预定日期
 */
-(void)getFreeTravlingDatesWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback{
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendString:kHostUrlString];
    [urlString appendString:kGetFreeTravlingDates];
    [self postUrl:urlString withParameters:parameters callback:callback];
}


@end
