//
//  constant.h
//  PoFeng
//
//  Created by Jia Xiaochao on 15/3/26.
//  Copyright (c) 2015年 totem. All rights reserved.
//




#define kHOST_ProDuct 1      //1 是生产环境    0 测试环境


#if kHOST_ProDuct            // 1 生产  0 测试
//正式服务器
#define SERVER_URL           @"http://triprice.cn/triprice/"
#else
//测试服务器
#define SERVER_URL           @"http://triprice.cn/triprice/"
#endif


#if kHOST_ProDuct// 1 生产  0 测试

#define APNS_CERT_NAME          @"apns_pro"

#else

#define APNS_CERT_NAME          @"apns_dev"

#endif

#define nullCode 99999999
#define SUCCESS_CODE 1


#define TextBlueColor  [UIColor colorWithRed:0.227 green:0.557 blue:0.824 alpha:1.00]


#define kVersion ([[UIDevice currentDevice].systemVersion doubleValue])

#define kDeviceToken @"deviceToken"

#define NavBgColor  HexRGBAlpha(0x36353b, 1.0)
#define NavBgColorAl HexRGBAlpha(0x36353b, 0.6)

#define accuratePrice(num) [NSString stringWithFormat:@"%.1f",[num floatValue]]


#define cellH rateLangth(210)

#define F10 rateLangth(10)
#define F11 rateLangth(11)
#define F12 rateLangth(12)
#define F13 rateLangth(13)
#define F14 rateLangth(14)
#define F15 rateLangth(15)
#define F16 rateLangth(16)
#define F17 rateLangth(17)
#define F18 rateLangth(18)
#define F19 rateLangth(19)
#define F20 rateLangth(20)
#define F21 rateLangth(21)
#define F22 rateLangth(22)
#define F23 rateLangth(23)
#define F24 rateLangth(24)
#define F25 rateLangth(25)
#define F26 rateLangth(26)

#define Screen_weight [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

#define rateLangth(a) (a*(Screen_weight/320.0f))

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define lightTextColor  [UIColor colorWithRed:0.404 green:0.404 blue:0.404 alpha:1.00]
#define darkTextColor  [UIColor colorWithRed:0.133 green:0.145 blue:0.165 alpha:1.00]
#define cellLineColorTp HexRGBAlpha(0xd1d8df, 1.0)



#define StateBarH 20
#define NavBarH 44
#define TabBarH 55
#define middleBarH 45


#define SharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define TabVC  (JDDTabBarController *)([[UIApplication sharedApplication] delegate].window.rootViewController)


