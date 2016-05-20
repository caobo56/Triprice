//
//  TPHomeTopView.m
//  triprice
//
//  Created by caobo56 on 16/2/14.
//
//

#import "TPHomeTopView.h"

@implementation TPHomeTopView{
    UILabel * titleLable;
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
    self.size = CGSizeMake(Screen_weight, NavBarH+StateBarH);
    self.backgroundColor = HexRGBAlpha(0x000000, 0.4);
    self.origin = CGPointMake(0, 0);
    titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(Screen_weight, NavBarH);
    titleLable.bottom = self.height;
    titleLable.centerX = self.width/2;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = HexRGBAlpha(0xFFFFFF, 1.0);
    titleLable.font = [UIFont systemFontOfSize:17.0f];
    [self addSubview:titleLable];
}


-(void)setTitle:(NSString *)title{
    titleLable.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
