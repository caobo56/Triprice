//
//  JDDGuidanceView.m
//  jingduoduo
//
//  Created by caobo on 15/8/13.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import "JDDGuidanceView.h"

@interface JDDGuidanceView()

@end

static JDDGuidanceView *shareGuidView = nil;

@implementation JDDGuidanceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(JDDGuidanceView *)shareGuidanceView{
    @synchronized(self){
        if (shareGuidView == nil) {
            shareGuidView = [[self alloc]init];
            [shareGuidView initUI];
        }
    }
    return shareGuidView;
}

-(void)initUI{
    UIImageView * imv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, Screen_height)];
    UIImage * img1 = [UIImage imageNamed:@"guidance1.jpg"];
    imv1.image = img1;
    
    UIImageView * imv2 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_weight, 0, Screen_weight, Screen_height)];
    UIImage * img2 = [UIImage imageNamed:@"guidance2.jpg"];
    imv2.image = img2;
    
    UIImageView * imv3 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_weight*2, 0, Screen_weight, Screen_height)];
    UIImage * img3 = [UIImage imageNamed:@"guidance3.jpg"];
    imv3.image = img3;
    
    UIImage * img = [UIImage imageNamed:@"openBtn.png"];
    _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBtn setImage:img forState:UIControlStateNormal];
    _goBtn.frame = CGRectMake(0, 0, img.size.width*1.5, img.size.height*1.5);
    _goBtn.center = imv3.center;
    _goBtn.frame = CGRectMake(_goBtn.frame.origin.x, 420, img.size.width, img.size.height);
    
    if (Screen_weight == 414.0f) {
        _goBtn.top = 625;
    }else if (Screen_weight == 375.0f){
        _goBtn.top = 570;
    }else if (Screen_weight == 320.0f){
        _goBtn.top = 480;
    }
    if (Screen_height == 480.f) {
        _goBtn.size = CGSizeMake(img.size.width, img.size.height);
        _goBtn.top = 395;
        UIImage * img1 = [UIImage imageNamed:@"4sguidance1.jpg"];
        imv1.image = img1;
        UIImage * img2 = [UIImage imageNamed:@"4sguidance2.jpg"];
        imv2.image = img2;
        UIImage * img3 = [UIImage imageNamed:@"4sguidance3.jpg"];
        imv3.image = img3;
    }
    _goBtn.centerX = Screen_weight*2.5;
    self.frame = CGRectMake(0, 0, Screen_weight, Screen_height);
    self.contentSize = CGSizeMake(Screen_weight*3, Screen_height);
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    self.pagingEnabled=YES;
    [self addSubview:imv1];
    [self addSubview:imv2];
    [self addSubview:imv3];
    [self addSubview:_goBtn];
}

-(void)show{
    self.hidden = NO;
}

-(void)dismess{
    self.hidden = YES;
}

-(BOOL)isShow{
    return !self.hidden;
}



@end
