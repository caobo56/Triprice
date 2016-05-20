//
//  DestinationMoreCell.m
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import "DestinationMoreCell.h"

@implementation DestinationMoreCell

-(void)createView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.size = CGSizeMake(Screen_weight, cellH);
    bgView = [[UIImageView alloc]init];
    bgView.size = CGSizeMake(Screen_weight, cellH-rateLangth(10));
    bgView.layer.masksToBounds = YES;
    [[bgView layer]setCornerRadius:5.0];//圆角
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

-(void)setWithDic:(NSDictionary *)dict{
    nameLable.text = [dict objectForKeyNotNull:@"name"];
    [bgView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    descLable.text = [dict objectForKeyNotNull:@"out_line"];
    timeLabel.text = [dict objectForKeyNotNull:@"play_time"];
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
