//
//  JDDAPI.h
//  jingduoduo
//
//  Created by caobo on 15/6/25.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DictionaryResultsBlock)(NSDictionary * dict, NSString *error);


@interface JDDAPIs : NSObject

+ (JDDAPIs *)sharedJDDAPIs;


//post方法
- (void)postUrl:(NSString *)url withParameters:(NSDictionary *)parameters callback:(DictionaryResultsBlock)callback;

/**
 *  获取首页背景图链接
 */
- (void)getHomeBgImageURLWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;


/**
 *  获取每周推荐列表
 */
- (void)getRecommendSearchAllWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 *  获取每周推荐详情
 */
- (void)getRecommendDetailWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 * 目的地产品列表
 */
- (void)getDestinationSearchWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 *  获取目的地产品详情
 */
- (void)getDestinationDetailWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 *  获取目的地产品详情列表
 */
- (void)getDestinationDetailListWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;


/**
 *  获取目的地列表
 */
-(void)getDestinationSearchHot:(id)parameters withBlock:(DictionaryResultsBlock)callback;


/**
 * 发布需求
 */
- (void)publishRequireWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 *预订产品
 */
-(void)bookingAddOrderWithParmeters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;


/**
 * 登录
 */
-(void)loginWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 * 获取手机验证码
 */
-(void)getAuthCodeWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 * 注册
 */
-(void)userRegistWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 * 修改密码
 */
-(void)resetPasswordByMobileNumWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 * 更新个人信息
 */
-(void)updateUserInfoWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 * 查询用户信息byId
 */
-(void)searchUserByIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 *  2.2.9	查询目的地国家
 * destination/searchDestinationCountry.do
 */
-(void)searchDestinationCountryWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 根据国家查询城市
 destination/searchDestinationCity.do
 */
-(void)searchDestinationCityWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 2.2.11	根据城市查询景点
destination/searchTouristItemByCity.do
 */
-(void)searchTouristItemByCityWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 *特色自由行
 *kspecialSearchAll
 */
-(void)specialSearchAllWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 特色自由行详情
 special/searchSpecialById.do
 */
-(void)searchSpecialByIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 特色自由行详情详细行程
 special/searchScheduleBySpecialId.do
 */
-(void)searchScheduleBySpecialIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 需求详情
 solution/searchSolutionById.do
 */
-(void)searchSolutionByIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;

/**
 需求详情详细行程
 solution/searchSolutionBySolutionId.do
 */
-(void)searchSolutionBySolutionIdWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;


/**
 获取自由行可预定日期
 */
-(void)getFreeTravlingDatesWithParameters:(id)parameters WithBlock:(DictionaryResultsBlock)callback;


@end
