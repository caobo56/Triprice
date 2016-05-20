//
//  TPWeekRecommendFooterView.m
//  triprice
//
//  Created by caobo56 on 16/2/18.
//
//

#import "TPWeekRecommendFooterView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TPWeekRecommendFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.size = CGSizeMake(Screen_weight, TabBarH);
    self.backgroundColor = NavBgColorAl;
    
    UIImage * tablogo =[UIImage imageNamed:@"tablogo"];
    UIImageView * tablogoView = [[UIImageView alloc]init];
    tablogoView.size = tablogo.size;
    tablogoView.left = 10;
    tablogoView.centerY = self.height/2;
    tablogoView.backgroundColor = [UIColor whiteColor];
    [[tablogoView layer]setCornerRadius:3.0];//圆角
    tablogoView.image = tablogo;
    [self addSubview:tablogoView];
    
    _reservationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reservationBtn.size = CGSizeMake(72, 33);
    _reservationBtn.left = Screen_weight-_reservationBtn.width-10;
    _reservationBtn.centerY = self.height/2;
    [[_reservationBtn layer]setCornerRadius:3.0];//圆角
    _reservationBtn.backgroundColor = HexRGBAlpha(0xEDF7FF, 1.0);
    [_reservationBtn setTitle:@"预订产品" forState:UIControlStateNormal];
    [_reservationBtn setTitleColor:HexRGBAlpha(0x1e83fb, 1.0) forState:UIControlStateNormal];
    _reservationBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:_reservationBtn];
    
    _requirementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _requirementBtn.size = CGSizeMake(72, 33);
    _requirementBtn.left = _reservationBtn.left-10-_requirementBtn.width;
    _requirementBtn.centerY = self.height/2;
    [[_requirementBtn layer]setCornerRadius:3.0];//圆角
    _requirementBtn.backgroundColor = HexRGBAlpha(0xEDF7FF, 1.0);
    [_requirementBtn setTitle:@"发布需求" forState:UIControlStateNormal];
    [_requirementBtn setTitleColor:HexRGBAlpha(0xFF7F05, 1.0) forState:UIControlStateNormal];
    _requirementBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:_requirementBtn];

    
    
}

@end
