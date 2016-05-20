//
//  JDDCustomBtn.h
//  TabView
//
//  Created by caobo56 on 15/10/26.
//  Copyright © 2015年 jdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDDCustomBtn : UIButton

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

- (void) setHomeImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;


- (void) setHorizontalImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font;

- (void) setHorizontalLeftImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font;


- (void) setCharactersWithTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font andWithSize:(CGSize)size;

- (void) setCharactersSelectWithTitle:(NSString *)title forState:(UIControlState)stateType andWithFont:(float)font andWithSize:(CGSize)size;

@end
