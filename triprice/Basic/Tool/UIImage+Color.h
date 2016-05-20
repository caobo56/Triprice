//
//  UIImage+Color.h
//  jingduoduo
//
//  Created by 刁俊忠 on 15/6/24.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
