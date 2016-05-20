//
//  UILabel+MZYCustomLabel.m
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import "UILabel+MZYCustomLabel.h"

@implementation UILabel (MZYCustomLabel)

+(id)createWithFrame:(CGRect)frame withFont:(CGFloat )fontSize withTextAligment:(NSTextAlignment )alignment withTextColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    return label;
}


@end
