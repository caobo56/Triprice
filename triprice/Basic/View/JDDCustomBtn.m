//
//  JDDCustomBtn.m
//  TabView
//
//  Created by caobo56 on 15/10/26.
//  Copyright © 2015年 jdd. All rights reserved.
//

#import "JDDCustomBtn.h"
#import <QuartzCore/QuartzCore.h>

@implementation JDDCustomBtn


- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.titleLabel setTextColor:[UIColor redColor]];
    [self setTitleColor:HexRGBAlpha(0x26323B, 1.0) forState:stateType];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

- (void) setHomeImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType{
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-20.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.titleLabel setTextColor:[UIColor redColor]];
    [self setTitleColor:HexRGBAlpha(0x26323B, 1.0) forState:stateType];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(52.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}


- (void) setHorizontalImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    //    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [self setTitleColor:HexRGBAlpha(0x26323B, 1.0) forState:stateType];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                              3.0,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

- (void) setHorizontalLeftImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font{
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [self setTitleColor:HexRGBAlpha(0x26323B, 1.0) forState:stateType];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                              3.0,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

- (void) setCharactersWithTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font andWithSize:(CGSize)size{
    self.size = size;
    [self setShowsTouchWhenHighlighted:YES];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:2.0];
    [self.layer setBorderWidth:1.0];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [HexRGBAlpha(0xdd2727, 1.0) CGColor];
    [self setTitleColor:HexRGBAlpha(0xdd2727, 1.0) forState:stateType];
    [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [self setTitle:title forState:stateType];
}

- (void) setCharactersSelectWithTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font andWithSize:(CGSize)size{
    self.size = size;
    [self setShowsTouchWhenHighlighted:YES];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:2.0];
    [self.layer setBorderWidth:0.0];
    self.backgroundColor = HexRGBAlpha(0xdd2727, 1.0);
    [self setTitleColor:[UIColor whiteColor] forState:stateType];
    [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [self setTitle:title forState:stateType];
}


@end
