//
//  OrderListCell.m
//  triprice
//
//  Created by MZY on 16/3/15.
//
//

#import "OrderListCell.h"

@interface OrderListCell ()
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *orderTimeLabel;
@property (nonatomic , strong) UILabel *goTimeLabel;
@property (nonatomic , strong) UILabel *moneyLabel;
@property (nonatomic , strong) UILabel *commentLabel;
@property (nonatomic , strong) NSDictionary *infoDic;

@end

@implementation OrderListCell


-(void)createView{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, Screen_weight+2, 130)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderColor = cellLineColorTp.CGColor;
    backView.layer.borderWidth = 1;
    [self addSubview:backView];

    _titleLabel = [UILabel createWithFrame:CGRectMake(11, 10, 100, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    [backView addSubview:_titleLabel];

    _orderTimeLabel = [UILabel createWithFrame:CGRectMake(0, 10, 200, 12) withFont:12 withTextAligment:NSTextAlignmentRight withTextColor:lightTextColor];
    _orderTimeLabel.right = Screen_weight - 10;
    [backView addSubview:_orderTimeLabel];

    _nameLabel = [UILabel createWithFrame:CGRectMake(10, 0, 200, 16) withFont:16 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _nameLabel.top = _titleLabel.bottom+15;
    [backView addSubview:_nameLabel];

    _goTimeLabel = [UILabel createWithFrame:CGRectMake(12, 0, 200, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _goTimeLabel.top = _nameLabel.bottom + 10;
    [backView addSubview:_goTimeLabel];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 1)];
    line.backgroundColor = cellLineColorTp;
    line.top = _goTimeLabel.bottom+10;
    [backView addSubview:line];

    _moneyLabel = [UILabel createWithFrame:CGRectMake(10, 0, 200, 16) withFont:16 withTextAligment:NSTextAlignmentLeft withTextColor:[UIColor colorWithRed:0.988 green:0.533 blue:0.169 alpha:1.00]];
    _moneyLabel.centerY = (backView.height - line.bottom)/2+line.bottom;
    [backView addSubview:_moneyLabel];

    _commentLabel = [UILabel createWithFrame:CGRectMake(0, 0, 75, 25) withFont:16 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _commentLabel.backgroundColor = [UIColor colorWithRed:0.988 green:0.533 blue:0.169 alpha:1.00];
    _commentLabel.layer.cornerRadius = 3;
    _commentLabel.layer.masksToBounds = YES;
    _commentLabel.text = @"发表评论";
    _commentLabel.centerY = _moneyLabel.centerY;
    _commentLabel.right = Screen_weight - 10;

    OrderListCell *__weak weakSelf = self;

    [_commentLabel whenTapped:^{
        if (weakSelf.action) {
            if (weakSelf.infoDic) {
                weakSelf.action(_infoDic);
            }
        }
    }];
    [backView addSubview:_commentLabel];


    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)setInfoWithDic:(NSDictionary *)dic{
    _infoDic = [[NSDictionary alloc]initWithDictionary:dic];
    if ([dic objectForKeyNotNull:@"category"]) {
        if ([dic[@"category"] intValue] == 2) {
            _titleLabel.text = @"自由行";
        }else{
            _titleLabel.text = @"目的地项目";
        }
    }

    _orderTimeLabel.text = [dic objectForKeyNotNull:@"create_time"];

    _nameLabel.text = [dic objectForKeyNotNull:@"title"];

    _goTimeLabel.text = [NSString stringWithFormat:@"%@出行",[dic objectForKeyNotNull:@"use_date"]];

    _moneyLabel.text = [NSString stringWithFormat:@"¥%d",[[dic objectForKeyNotNull:@"price"] intValue]];
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
