//
//  TPTravelingGirdView.m
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import "TPTravelingGirdView.h"

@implementation TPTravelingGirdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* path1Path = [UIBezierPath bezierPath];
    [path1Path moveToPoint: CGPointMake(10, 0)];
    [path1Path addLineToPoint: CGPointMake(10, 20)];
    [path1Path addLineToPoint: CGPointMake(0, 30)];
    [path1Path addLineToPoint: CGPointMake(10, 40)];
    [path1Path addLineToPoint: CGPointMake(10, self.height)];
    [path1Path addLineToPoint: CGPointMake(self.width-10, self.height)];
    [path1Path addLineToPoint: CGPointMake(self.width-10, 0)];
    [path1Path addLineToPoint: CGPointMake(10, 0)];
    [path1Path closePath];
    // 设置边框颜色
    UIColor *strokeColor = HexRGBAlpha(0x2776A6, 1.0);
    [strokeColor setStroke];
    [path1Path stroke];
}

@end
