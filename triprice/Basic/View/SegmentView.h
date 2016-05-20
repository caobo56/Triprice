//
//  SegmentView.h
//  SegmentTest
//
//  Created by MZY on 14-5-20.
//  Copyright (c) 2014年 Mzy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SegmentDelegate <NSObject>
@optional
-(void)changeValue:(NSInteger)index;
@end

@interface SegmentView : UIControl
@property (nonatomic) BOOL newSegment;


@property(nonatomic,assign) id<SegmentDelegate> delegate;

-(void)setStringArray:(NSArray *)array textColor:(UIColor *)textColor textFont:(UIFont *)textFont index:(NSInteger)index;

-(void)setStringArray:(NSArray *)array textColor:(UIColor *)textColor textFont:(UIFont *)textFont backGroundColor:(UIColor *) bgColor index:(NSInteger)index;

-(void)changeView:(NSInteger) index;

-(void)setBottomLineWidth:(CGFloat) width;

-(void)showLine:(BOOL) isShow;
@end
