//
//  TPTRavelingFootView.m
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import "TPTRavelingFootView.h"
#import "TPtravlingTitleBar.h"

@implementation TPTRavelingFootView{
    UILabel * priceContainLable;
    UILabel * priceNotContain;
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
    self.size = CGSizeMake(Screen_weight, 196+40);
    self.backgroundColor = [UIColor whiteColor];
    
    TPtravlingTitleBar * titleBar = [[TPtravlingTitleBar alloc]init];
    titleBar.titleLable.text = @"费用相关";
    [self addSubview:titleBar];
    
    UILabel * containTitle = [[UILabel alloc]init];
    containTitle.size = CGSizeMake(Screen_weight-40, 20);
    containTitle.left = 20;
    containTitle.top = 40+10;
    containTitle.textColor = HexRGBAlpha(0x2776A6, 1.0);
    containTitle.textAlignment = NSTextAlignmentLeft;
    containTitle.text = @"费用包含";
    containTitle.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:containTitle];
    
    priceContainLable = [[UILabel alloc]init];
    priceContainLable.size = CGSizeMake(Screen_weight-40, 20);
    priceContainLable.left = 20;
    priceContainLable.top = containTitle.bottom+10;
    priceContainLable.textColor = darkTextColor;
    priceContainLable.textAlignment = NSTextAlignmentLeft;
    priceContainLable.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:priceContainLable];
    
    UILabel * containNotTitle = [[UILabel alloc]init];
    containNotTitle.size = CGSizeMake(Screen_weight-40, 20);
    containNotTitle.left = 20;
    containNotTitle.top = priceContainLable.bottom+10;
    containNotTitle.textColor = HexRGBAlpha(0x2776A6, 1.0);
    containNotTitle.textAlignment = NSTextAlignmentLeft;
    containNotTitle.text = @"费用不包含";
    containNotTitle.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:containNotTitle];

    priceNotContain = [[UILabel alloc]init];
    priceNotContain.size = CGSizeMake(Screen_weight-40, 20);
    priceNotContain.left = 20;
    priceNotContain.top = containNotTitle.bottom+10;
    priceNotContain.textColor = darkTextColor;
    priceNotContain.textAlignment = NSTextAlignmentLeft;
    priceNotContain.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:priceNotContain];
}

/**
 priceContain = "1\U3001\U673a\U7968\Uff1b
 \n2\U3001\U9152\U5e97";
 priceNotContain = "1\U3001\U7b7e\U8bc1\U8d39\Uff1b
 \n2\U3001\U5168\U7a0b\U9910\U996e\U8d39\U7528\Uff1b
 \n3\U3001\U672a\U63d0\U53ca\U5176\U4ed6\U8d39\U7528\U3002";
 */

-(void)loadDataWithDict:(NSDictionary *)dict{
    priceContainLable.text = [dict objectForKeyNotNull:@"priceContain"];
    priceNotContain.text = [dict objectForKeyNotNull:@"priceNotContain"];
}


@end
