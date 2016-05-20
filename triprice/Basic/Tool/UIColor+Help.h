//
//  UIColor+Help.h
//  jingduoduo
//
//  Created by 刁俊忠 on 15/6/24.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Help)

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
