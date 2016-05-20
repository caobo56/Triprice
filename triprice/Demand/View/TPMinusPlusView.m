//
//  TPMinusPlusView.m
//  triprice
//
//  Created by caobo56 on 16/2/20.
//
//

#import "TPMinusPlusView.h"
#import <QuartzCore/QuartzCore.h>


@implementation TPMinusPlusView{
    UILabel * titleLable;
    UILabel * countLable;
    UIButton * plusBtn;
    UIButton * minusBtn;
    
    int _leastValue;

    float viewH;
    float viewW;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        viewW = (Screen_weight-15*3)/2;
        [self initUI];
        _account = 0;
        _leastValue = 0;
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    titleLable.text = title;
}

-(void)setLeastValue:(int)value{
    
    _leastValue = value;
}

-(void)setTitleFocusd:(NSString *)title{
    NSString * str = [NSString stringWithFormat:@"%@*",title];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13.0f]
                        range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:10.0f]
                        range:NSMakeRange(str.length-1, 1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:HexRGBAlpha(0x26323B, 1.0) range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length-1, 1)];
    titleLable.attributedText = attriString;
}

-(void)setAccount:(int)account{
    _account = account;
    countLable.text = [NSString stringWithFormat:@"%d",_account];
}

-(void)initUI{
    UIImage * mtMinus_Normal = [UIImage imageNamed:@"mtMinus_Normal"];
    UIImage * mtPlus_highlight = [UIImage imageNamed:@"mtPlus_highlight"];
    UIImage * mtMinus_highlight = [UIImage imageNamed:@"mtMinus_highlight"];
    UIImage * mtPlus_Normal = [UIImage imageNamed:@"mtPlus_Normal"];
    UIImage * mtMinus_unenable = [UIImage imageNamed:@"mtMinus_unenable"];

    viewH = mtPlus_Normal.size.height;
    
    self.size = CGSizeMake(viewW, viewH*2);
    
    titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(viewW, viewH);
    titleLable.origin = CGPointMake(0, 0);
    titleLable.font = [UIFont systemFontOfSize:13.0f];
    titleLable.textColor = HexRGBAlpha(0x26323B, 1.0);
    [self addSubview:titleLable];
    
    countLable = [[UILabel alloc]init];
    countLable.size = CGSizeMake(viewW-2*viewH, viewH);
    countLable.centerX = self.width/2;
    countLable.bottom = self.height;
    countLable.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    countLable.layer.borderWidth = 0.5;
    countLable.font = [UIFont systemFontOfSize:13.0f];
    countLable.text = [NSString stringWithFormat:@"%d",_account];
    countLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countLable];
    
    minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.size = CGSizeMake(viewH, viewH);
    minusBtn.centerY = countLable.centerY;
    minusBtn.right = countLable.left;
    minusBtn.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    minusBtn.layer.borderWidth = 0.5;
    [minusBtn setImage:mtMinus_Normal forState:UIControlStateNormal];
    [minusBtn setImage:mtMinus_highlight forState:UIControlStateHighlighted];
    [minusBtn setImage:mtMinus_unenable forState:UIControlStateDisabled];
    [minusBtn addTarget:self action:@selector(minusBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minusBtn];
    
    
    plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    plusBtn.size = CGSizeMake(viewH, viewH);
    plusBtn.centerY = countLable.centerY;
    plusBtn.left = countLable.right;
    plusBtn.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    plusBtn.layer.borderWidth = 0.5;
    [plusBtn setImage:mtPlus_Normal forState:UIControlStateNormal];
    [plusBtn setImage:mtPlus_highlight forState:UIControlStateHighlighted];
    [plusBtn addTarget:self action:@selector(plusBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusBtn];
}

-(void)minusBtnPress{
    
    if (_account == _leastValue) {
        minusBtn.enabled = NO;
        return;
    }
    [self setAccount:(_account-1)];
    if (_account == _leastValue) {
        minusBtn.enabled = NO;
        return;
    }
}

-(void)plusBtnPress{
    if (_account > _leastValue) {
        minusBtn.enabled = YES;
    }
    [self setAccount:(_account+1)];
}

@end
