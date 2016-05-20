//
//  TPFreeTravelingCell.m
//  triprice
//
//  Created by caobo56 on 16/3/6.
//
//

#import "TPFreeTravelingCell.h"

@implementation TPFreeTravelingCell

-(void)createView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.size = CGSizeMake(Screen_weight, cellH-rateLangth(10));
    bgView = [[UIImageView alloc]init];
    bgView.size = CGSizeMake(Screen_weight, cellH-rateLangth(10));
//    bgView.layer.masksToBounds = YES;
//    [[bgView layer]setCornerRadius:5.0];//圆角
    bgView.bottom = self.height;
    [self addSubview:bgView];
    
    descLable = [[UILabel alloc]init];
    descLable.size = CGSizeMake(Screen_weight-20, 30);
    descLable.bottom = self.height;
    descLable.left = 10;
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.textColor = [UIColor whiteColor];
    descLable.font = [UIFont systemFontOfSize:12.0f];
    descLable.numberOfLines = 0;
    descLable.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:descLable];
    
    timeLabel = [UILabel createWithFrame:CGRectMake(0, 0, 50, 30) withFont:12 withTextAligment:NSTextAlignmentRight withTextColor:[UIColor whiteColor]];
    timeLabel.top = descLable.top;
    timeLabel.right = Screen_weight - 10;
    [self addSubview:timeLabel];
    
    
    moneyLabel = [UILabel createWithFrame:CGRectMake(0, 0, 50, 30) withFont:12 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    moneyLabel.top = 30;
    moneyLabel.right = Screen_weight - 10;
    moneyLabel.backgroundColor = [UIColor colorWithRed:0.980 green:0.537 blue:0.165 alpha:1.00];
    [self addSubview:moneyLabel];
    
    
    lineView = [[UIView alloc]init];
    lineView.size = CGSizeMake(Screen_weight-20, 1);
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.bottom = descLable.top;
    lineView.centerX = Screen_weight/2;
    lineView.alpha = 0.4;
    [self addSubview:lineView];
    
    nameLable = [[UILabel alloc]init];
    nameLable.size = CGSizeMake(Screen_weight-20, 45);
    nameLable.bottom = lineView.top;
    nameLable.centerX = Screen_weight/2;
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:nameLable];
}

/**
 
 days = 7;
 endCity = "\U66fc\U8c37";
 id = 310366040002;
 outline = "\U8c61\U5c9b-\U4e1b\U6797\U6e9c\U7d22-\U9a91\U5927\U8c61-\U6e05\U8fc8\U5468\U672b\U96c6\U5e02";
 pic = "http://120.27.30.159/triprice/upload/images/freedom/36601020.jpg";
 price = 3500;
 startCity = "\U5317\U4eac";
 title = "\U66fc\U8c37 \U8c61\U5c9b \U6e05\U8fc8\U81ea\U7531\U884c";
 */

-(void)setWithDic:(NSDictionary *)dict{
    
    nameLable.text = [dict objectForKeyNotNull:@"title"];
    [bgView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    descLable.text = [dict objectForKeyNotNull:@"outline"];
    timeLabel.text = [NSString stringWithFormat:@"%@天",[dict objectForKeyNotNull:@"days"]];
    [timeLabel sizeToFit];
    timeLabel.right = Screen_weight - 10;
    
    if ([dict objectForKeyNotNull:@"price"]) {
        moneyLabel.text = [NSString stringWithFormat:@"%d/人",[dict[@"price"] intValue]];
    }else{
        moneyLabel.text = @"";
    }
    [moneyLabel sizeToFit];
    moneyLabel.width = moneyLabel.width+5;
    moneyLabel.right = Screen_weight - 10;
    
    descLable.width = Screen_weight - 20;
    [descLable sizeToFit];
    if (descLable.right < timeLabel.left) {
        descLable.bottom = self.height- 10;
        timeLabel.centerY = descLable.centerY;
        lineView.bottom = descLable.top-10;
        nameLable.bottom = lineView.top;
    }else{
        timeLabel.bottom = self.height - 10;
        descLable.bottom = timeLabel.top;
        lineView.bottom = descLable.top-10;
        nameLable.bottom = lineView.top;
    }
    
}



@end
