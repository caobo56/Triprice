//
//  TPTravelingHeadView.m
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import "TPTravelingHeadView.h"
#import "TPCustomTool.h"
#import "TPtravlingTitleBar.h"

#import <QuartzCore/QuartzCore.h>

@implementation TPTravelingHeadView{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * priceLable;
    UILabel * startCityLable;
    UILabel * endCityLable;
    UILabel * descLable;
    TPtravlingTitleBar * titleBar;
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
    self.size = CGSizeMake(Screen_weight, 300);
    self.backgroundColor = [UIColor whiteColor];
    
    UIView * imageBgView0 = [[UIView alloc]init];
    imageBgView0.size = CGSizeMake(Screen_weight-30, (Screen_weight-60)/23*12+20);
    imageBgView0.centerX = Screen_weight/2;
    imageBgView0.top = 8;
    imageBgView0.backgroundColor = [UIColor whiteColor];
    [imageBgView0.layer setMasksToBounds:YES];
    [imageBgView0.layer setBorderWidth:1.0];//画线的宽度
    [imageBgView0.layer setBorderColor:cellLineColorTp.CGColor];//颜色
    [imageBgView0.layer setCornerRadius:5.0];//圆角
    
    UIView * imageBgView1 = [[UIView alloc]init];
    imageBgView1.size = imageBgView0.size;
    imageBgView1.centerX = Screen_weight/2;
    imageBgView1.top = 12;
    imageBgView1.backgroundColor = [UIColor whiteColor];
    [imageBgView1.layer setMasksToBounds:YES];
    [imageBgView1.layer setBorderWidth:1.0];//画线的宽度
    [imageBgView1.layer setBorderColor:cellLineColorTp.CGColor];//颜色
    [imageBgView1.layer setCornerRadius:5.0];//圆角
    
    UIView * imageBgView2 = [[UIView alloc]init];
    imageBgView2.size = imageBgView0.size;
    imageBgView2.centerX = Screen_weight/2;
    imageBgView2.top = 16;
    imageBgView2.backgroundColor = [UIColor whiteColor];
    [imageBgView2.layer setMasksToBounds:YES];
    [imageBgView2.layer setBorderWidth:1.0];//画线的宽度
    [imageBgView2.layer setBorderColor:cellLineColorTp.CGColor];//颜色
    [imageBgView2.layer setCornerRadius:5.0];//圆角
    
    [self addSubview:imageBgView2];
    [self addSubview:imageBgView1];
    [self addSubview:imageBgView0];
    
    headImage = [[UIImageView alloc]init];
    headImage.size = CGSizeMake(imageBgView0.width-30, (imageBgView0.height-20));
    headImage.centerX  = imageBgView0.width/2;
    headImage.centerY = imageBgView0.height/2;
    [imageBgView0 addSubview:headImage];
    
    nameLable = [[UILabel alloc]init];
    nameLable.size = CGSizeMake(Screen_weight-30, 20);
    nameLable.left = 15.0f;
    nameLable.top = imageBgView2.bottom+10;
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.textColor = HexRGBAlpha(0x2776A6, 1.0);
    nameLable.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:nameLable];
    
    UILabel * priceTitleLable = [[UILabel alloc]init];
    priceTitleLable.size = CGSizeMake(40, 30);
    priceTitleLable.left = 15.0f;
    priceTitleLable.top = nameLable.bottom+10;
    priceTitleLable.textAlignment = NSTextAlignmentLeft;
    priceTitleLable.textColor = lightTextColor;
    priceTitleLable.font = [UIFont systemFontOfSize:12.0f];
    priceTitleLable.text = @"售价：";
    [self addSubview:priceTitleLable];
    
    priceLable = [[UILabel alloc]init];
    priceLable.size = CGSizeMake(80, 30);
    priceLable.left = priceTitleLable.right;
    priceLable.bottom = priceTitleLable.bottom;
    priceLable.textAlignment = NSTextAlignmentLeft;
    priceLable.textColor = HexRGBAlpha(0xFF7F05, 1.0);
    priceLable.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:priceLable];
    
    UILabel * startCityTitle = [[UILabel alloc]init];
    startCityTitle.size = CGSizeMake(65, 20);
    startCityTitle.left = priceTitleLable.left;
    startCityTitle.top = priceTitleLable.bottom+15;
    startCityTitle.textAlignment = NSTextAlignmentLeft;
    startCityTitle.textColor = lightTextColor;
    startCityTitle.font = [UIFont systemFontOfSize:13.0f];
    startCityTitle.text = @"出发城市：";
    [self addSubview:startCityTitle];
    
    startCityLable = [[UILabel alloc]init];
    startCityLable.size = CGSizeMake(100, 20);
    startCityLable.left = startCityTitle.right;
    startCityLable.top = priceTitleLable.bottom+15;
    startCityLable.textAlignment = NSTextAlignmentLeft;
    startCityLable.textColor = darkTextColor;
    startCityLable.font = [UIFont systemFontOfSize:13.0f];
    startCityLable.text = @"";
    [self addSubview:startCityLable];
    
    UILabel * endCityTitle = [[UILabel alloc]init];
    endCityTitle.size = CGSizeMake(65, 20);
    endCityTitle.left = priceTitleLable.left;
    endCityTitle.top = startCityTitle.bottom;
    endCityTitle.textAlignment = NSTextAlignmentLeft;
    endCityTitle.textColor = lightTextColor;
    endCityTitle.font = [UIFont systemFontOfSize:13.0f];
    endCityTitle.text = @"结束城市：";
    [self addSubview:endCityTitle];
    
    endCityLable = [[UILabel alloc]init];
    endCityLable.size = CGSizeMake(100, 20);
    endCityLable.left = startCityTitle.right;
    endCityLable.top = startCityTitle.bottom;
    endCityLable.textAlignment = NSTextAlignmentLeft;
    endCityLable.textColor = darkTextColor;
    endCityLable.font = [UIFont systemFontOfSize:13.0f];
    endCityLable.text = @"";
    [self addSubview:endCityLable];
    
    UILabel * descTitle = [[UILabel alloc]init];
    descTitle.size = CGSizeMake(Screen_weight-30, 20);
    descTitle.left = 15.0f;
    descTitle.top = endCityLable.bottom+15;
    descTitle.textAlignment = NSTextAlignmentLeft;
    descTitle.textColor = HexRGBAlpha(0x2776A6, 1.0);
    descTitle.font = [UIFont systemFontOfSize:14.0f];
    descTitle.text = @"行程特色";
    [self addSubview:descTitle];
    
    descLable = [[UILabel alloc]init];
    descLable.size = CGSizeMake(Screen_weight-30, 50);
    descLable.centerX = Screen_weight/2;
    descLable.top = descTitle.bottom+5;
    descLable.textColor = HexRGBAlpha(0x5E5E5E, 1.0);
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.font = [UIFont systemFontOfSize:13.0f];
    descLable.numberOfLines = 0;
    [self addSubview:descLable];
    
    titleBar = [[TPtravlingTitleBar alloc]init];
    titleBar.titleLable.text = @"详细行程";
    titleBar.top = descLable.bottom+10;
    [self addSubview:titleBar];
}

-(void)loadDataWithDict:(NSDictionary *)dict{
    nameLable.text = [dict objectForKeyNotNull:@"title"];
    [headImage setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    priceLable.text = [NSString stringWithFormat:@"¥ %@/人",[dict objectForKeyNotNull:@"price"]];

    startCityLable.text = [dict objectForKeyNotNull:@"startCity"];
    endCityLable.text = [dict objectForKeyNotNull:@"gobackCity"];
    
    NSString * comment = [dict objectForKeyNotNull:@"feature"];
    float commentH = [TPCustomTool heightForString:comment fontSize:13.0 andWidth:(Screen_weight-30)]+5;
    descLable.size = CGSizeMake(Screen_weight-20, commentH);
    descLable.text = comment;
    titleBar.top = descLable.bottom;
    self.height = titleBar.bottom;
}

@end
