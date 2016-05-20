//
//  TPCustomTool.h
//  triprice
//
//  Created by caobo56 on 16/2/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TPCustomTool : NSObject

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 ** startPoint:     虚线的起始位置
 ** endPoint:       虚线的结束位置
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的宽度
 */
+ (float) widthForString:(NSString *)value font:(UIFont *)font;

@end
