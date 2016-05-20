//
//  TPReservationFooterView.m
//  triprice
//
//  Created by caobo56 on 16/2/18.
//
//

#import "TPReservationFooterView.h"
#import <QuartzCore/QuartzCore.h>


@implementation TPReservationFooterView{
    UILabel * priceLable;
}

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
    
    priceLable = [[UILabel alloc]init];
    priceLable.size = tablogo.size;
    priceLable.left = 10;
    priceLable.centerY = self.height/2;
    priceLable.font = [UIFont systemFontOfSize:15.0f];
    priceLable.textColor = [UIColor whiteColor];
    [self addSubview:priceLable];
    
    _reservationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reservationBtn.size = CGSizeMake(72, 33);
    _reservationBtn.left = Screen_weight-_reservationBtn.width-10;
    _reservationBtn.centerY = self.height/2;
    [[_reservationBtn layer]setCornerRadius:3.0];//圆角
    _reservationBtn.backgroundColor = HexRGBAlpha(0xEDF7FF, 1.0);
    [_reservationBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    [_reservationBtn setTitleColor:HexRGBAlpha(0x1e83fb, 1.0) forState:UIControlStateNormal];
    _reservationBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:_reservationBtn];
}

-(void)setPrice:(NSString *)Price{
    NSString * str = [NSString stringWithFormat:@"¥%@",Price];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:10.0f]
                        range:NSMakeRange(0, 1)];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:15.0f]
                        range:NSMakeRange(1, str.length-1)];
    
    priceLable.attributedText = attriString;
    
}

@end
