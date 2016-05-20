//
//  TPWeekRecomendHeadView.m
//  triprice
//
//  Created by caobo56 on 16/2/16.
//
//

#import "TPWeekRecomendHeadView.h"


#import "TPCustomTool.h"



@implementation TPWeekRecomendHeadView{
    UIImageView * imageView;
    UILabel * descLable;
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
    self.size = CGSizeMake(Screen_weight, cellH-rateLangth(10)+270);
    imageView = [[UIImageView alloc]init];
    imageView.size = CGSizeMake(Screen_weight, cellH-rateLangth(10));
    imageView.origin = CGPointMake(0, 0);
    [self addSubview:imageView];
    
    UIView * lableBgView = [[UIView alloc]init];
    lableBgView.size = CGSizeMake(Screen_weight, rateLangth(40));
    lableBgView.bottom = imageView.bottom;
    lableBgView.left = 0;
    lableBgView.backgroundColor = HexRGBAlpha(0x26323B, 1.0);
    lableBgView.alpha = 0.2;
    [self addSubview:lableBgView];
    
    descLable = [[UILabel alloc]init];
    descLable.size = CGSizeMake(Screen_weight-10, lableBgView.height);
    descLable.left = 5;
    descLable.bottom = lableBgView.bottom;
    descLable.textColor = [UIColor whiteColor];
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:descLable];
    
 
    
}

-(void)setHeadData:(NSDictionary *)dict{
    descLable.text = [dict objectForKeyNotNull:@"out_line"];
    [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    
    NSString * comment = [dict objectForKeyNotNull:@"comment"];
    float stringH = [TPCustomTool heightForString:comment fontSize:14.0f andWidth:(Screen_weight-35)];
    
    UIView * topLine = [[UIView alloc]init];
    topLine.size = CGSizeMake(Screen_weight-20, stringH+20);
    [TPCustomTool drawDashLine:topLine lineLength:5 lineSpacing:5 lineColor:[UIColor grayColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(topLine.width, 0)];
    [TPCustomTool drawDashLine:topLine lineLength:5 lineSpacing:5 lineColor:[UIColor grayColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, topLine.height)];
    [TPCustomTool drawDashLine:topLine lineLength:5 lineSpacing:5 lineColor:[UIColor grayColor] startPoint:CGPointMake(topLine.width, 0) endPoint:CGPointMake(topLine.width, topLine.height)];
    [TPCustomTool drawDashLine:topLine lineLength:5 lineSpacing:5 lineColor:[UIColor grayColor] startPoint:CGPointMake(0, topLine.height) endPoint:CGPointMake(topLine.width, topLine.height)];
    topLine.centerX = Screen_weight/2;
    topLine.top = imageView.bottom + 8;
    topLine.backgroundColor = HexRGBAlpha(0xF1F1F1, 1.0);
    [self addSubview:topLine];
    
    UILabel * commentLable = [[UILabel alloc]init];
    commentLable.size = CGSizeMake((Screen_weight-35), stringH+10);
    commentLable.textAlignment = NSTextAlignmentLeft;
    commentLable.textColor = HexRGBAlpha(0x000000, 1.0);
    commentLable.center = topLine.center;
    commentLable.font = [UIFont systemFontOfSize:14.0f];
    commentLable.text = comment;
    commentLable.numberOfLines = 0;
    commentLable.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:commentLable];
    
    UILabel * reasonTitle = [[UILabel alloc]init];
    reasonTitle.size = CGSizeMake(200, 20);
    reasonTitle.centerX = Screen_weight/2;
    reasonTitle.top = topLine.bottom+17;
    reasonTitle.textAlignment = NSTextAlignmentCenter;
    reasonTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    reasonTitle.textColor = HexRGBAlpha(0x26323B, 1.0);
    reasonTitle.text = @"推荐理由";
    [self addSubview:reasonTitle];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = HexRGBAlpha(0x26323B, 1.0);
    lineView.size = CGSizeMake(Screen_weight-212, 1);
    lineView.centerX = Screen_weight/2;
    lineView.top = reasonTitle.bottom+5;
    [self addSubview:lineView];
    self.height = lineView.bottom;
}

@end
