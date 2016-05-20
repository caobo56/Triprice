//
//  TPUserTest.h
//  triprice
//
//  Created by caobo56 on 16/3/28.
//
//


/**
 ESJsonFormat
 与MJExtension配合使用
 TPUserTest * userinfo=[TPUserTest objectWithKeyValues:(NSDictionary*)netresult];
 */

#import <Foundation/Foundation.h>

@interface TPUserTest : NSObject



@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, copy) NSString *user_im_password;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_im_id;

@end
