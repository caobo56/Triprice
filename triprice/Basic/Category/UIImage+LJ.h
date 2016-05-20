//
//  UIImage+LJ.h
//  commontFrameWork
//
//  Created by mary on 15/4/2.
//  Copyright (c) 2015年 MLJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LJ)
/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

/**
 *  图片裁剪（圆形）
 *
 *  @param name        裁剪图片的名字
 *  @param borderWidth 边界宽度
 *  @param borderColor 边界的颜色
 *
 *  @return 返回图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  屏幕截图
 *
 *  @param view 要截取的view
 *
 *  @return 返回图片
 */
+ (instancetype)captureWithView:(UIView *)view;

/**
 *  返回一张自由拉伸的图片
 *
 *  @param name 图片名称
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  图片旋转
 */
+ (UIImage *)rotatedImageWithName:(NSString *)name ByDegrees:(CGFloat)degrees;
@end
