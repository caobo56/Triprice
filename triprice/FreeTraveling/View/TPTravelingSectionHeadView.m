//
//  TPTravelingSectionHeadView.m
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import "TPTravelingSectionHeadView.h"
#import "TPTravelingGirdView.h"
#import "TPCustomTool.h"

@implementation TPTravelingSectionHeadView{
    UIImageView * imageView;
    UILabel * placeLable;
    UILabel * daysLable;
    TPTravelingGirdView * girdView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}



-(void)initUI{
    self.size = CGSizeMake(Screen_weight, ((Screen_weight-40)/2/23*12+30));
    self.contentView.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc]init];
    imageView.size = CGSizeMake((Screen_weight-40)/2, (Screen_weight-40)/2/23*12);
    imageView.left = 20;
    imageView.centerY = self.height/2;
    [self addSubview:imageView];
    
    girdView = [[TPTravelingGirdView alloc]init];
//    girdView.size = imageView.size;
    girdView.left = Screen_weight/2;
    girdView.top = imageView.top;
    [self addSubview:girdView];
    
    placeLable =[[UILabel alloc]init];
    placeLable.size = CGSizeMake(imageView.width, 20);
    placeLable.textColor = darkTextColor;
    placeLable.textAlignment = NSTextAlignmentCenter;
    placeLable.centerX = imageView.right + imageView.width/2;
    placeLable.top = girdView.top+10;
    placeLable.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:placeLable];
    
    daysLable = [[UILabel alloc]init];
    daysLable.size = CGSizeMake(imageView.width-20, 50);
    daysLable.top = placeLable.bottom;
    daysLable.centerX = placeLable.centerX;
    daysLable.textColor = HexRGBAlpha(0x2776A6, 1.0);
    daysLable.textAlignment = NSTextAlignmentCenter;
    daysLable.font = [UIFont systemFontOfSize:13.0f];
    daysLable.numberOfLines = 0;
    [self addSubview:daysLable];

}

-(void)loadDataWithDict:(NSDictionary *)dict{
    [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    placeLable.text = [dict objectForKeyNotNull:@"title"];
    daysLable.height = [self daysLableTextHeight:[dict objectForKeyNotNull:@"outline"]];
    [girdView removeFromSuperview];
    girdView = nil;
    girdView = [[TPTravelingGirdView alloc]init];
    girdView.left = Screen_weight/2;
    girdView.top = imageView.top;
    girdView.size = CGSizeMake(imageView.width, daysLable.height+placeLable.height+15);
    [self addSubview:girdView];
}

-(float)daysLableTextHeight:(NSString *)outline{
    NSArray * daysArr = [outline componentsSeparatedByString:NSLocalizedString(@"-", nil)];
    float rowHeight = [TPCustomTool heightForString:daysArr[0] fontSize:13.0 andWidth:daysLable.width];
    NSMutableString * str = [[NSMutableString alloc]init];
    for (int i = 0; i<daysArr.count; i++) {
        if (i == 0) {
            [str appendString:daysArr[i]];
        }else{
            [str appendString:@"\n"];
            [str appendString:daysArr[i]];
        }
    }
    daysLable.text = str;
    return rowHeight*daysArr.count;
}

@end
