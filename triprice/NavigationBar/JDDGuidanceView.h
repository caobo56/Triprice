//
//  JDDGuidanceView.h
//  jingduoduo
//
//  Created by caobo on 15/8/13.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDDGuidanceView : UIScrollView

@property(nonatomic,strong)UIButton * goBtn;

+(JDDGuidanceView *)shareGuidanceView;

-(void)show;

-(void)dismess;

-(BOOL)isShow;


@end
