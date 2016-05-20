//
//  TPtravlingTitleBar.m
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import "TPtravlingTitleBar.h"

@implementation TPtravlingTitleBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* path1Path = [UIBezierPath bezierPath];
    [path1Path moveToPoint: CGPointMake(15, 0)];
    [path1Path addLineToPoint: CGPointMake(15, 34)];
    [path1Path addLineToPoint: CGPointMake(54, 34)];
    [path1Path addLineToPoint: CGPointMake(58, 40)];
    [path1Path addLineToPoint: CGPointMake(62, 34)];
    [path1Path addLineToPoint: CGPointMake(Screen_weight-15, 34)];
    [path1Path addLineToPoint: CGPointMake(Screen_weight-15, 0)];
    [path1Path addLineToPoint: CGPointMake(15, 0)];
    [path1Path closePath];
    // 设置填充颜色
    UIColor *fillColor = HexRGBAlpha(0x008FFE, 1.0);
    [fillColor set];
    [path1Path fill];
    
    [path1Path stroke];
    
}


-(void)initUI{
    self.size = CGSizeMake(Screen_weight, 40);
    self.backgroundColor = [UIColor whiteColor];
    _titleLable = [[UILabel alloc]init];
    _titleLable.size = CGSizeMake(Screen_weight-40, 34);
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentLeft;
    _titleLable.left = 20;
    _titleLable.top = 0;
    _titleLable.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:_titleLable];
}

@end
