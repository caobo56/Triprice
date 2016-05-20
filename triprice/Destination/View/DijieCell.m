//
//  DijieCell.m
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import "DijieCell.h"

@interface DijieCell (){

}
@property (strong, nonatomic) UIImageView *headV;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *sexImg;
@property (strong, nonatomic) UILabel *isVLabel;
@property (strong, nonatomic) UILabel *guideLabel1;
@property (strong, nonatomic) UILabel *guideLabel2;
@property (strong, nonatomic) UILabel *carLabel1;
@property (strong, nonatomic) UILabel *carLabel2;
@property (strong, nonatomic) UILabel *orderLabel1;
@property (strong, nonatomic) UILabel *orderLabel2;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UILabel *skillLabel;
@property (strong, nonatomic) NSMutableArray *skills;

@end

@implementation DijieCell

-(void)createView{

// 头像部分
    _headV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 84, 84)];
    _headV.centerX = Screen_weight/2;
    _headV.top = 10;
    _headV.backgroundColor = [UIColor greenColor];
    _headV.layer.cornerRadius = _headV.width/2.0;
    _headV.layer.masksToBounds = YES;
    [self addSubview:_headV];

    _nameLabel = [UILabel createWithFrame:CGRectZero withFont:16 withTextAligment:NSTextAlignmentCenter withTextColor:darkTextColor];
    _nameLabel.top = _headV.bottom+6;
    [self addSubview:_nameLabel];
    _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    _sexImg.top = _nameLabel.top;
    [self addSubview:_sexImg];

//费用
    _guideLabel1 = [UILabel createWithFrame:CGRectMake(0, 0, 100, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _guideLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    _guideLabel1.left = 15;
    _guideLabel1.top = _sexImg.bottom+15;
    _guideLabel1.text = @"导游服务";
    [self addSubview:_guideLabel1];
    _guideLabel2 = [UILabel createWithFrame:CGRectMake(15, 0, 100, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _guideLabel2.top = _guideLabel1.bottom+10;
    _guideLabel1.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_guideLabel2];

    _carLabel1 = [UILabel createWithFrame:CGRectMake(0, 0, 100, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _carLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    _carLabel1.left = _guideLabel1.right+5;
    _carLabel1.top = _guideLabel1.top;
    _carLabel1.text = @"带车导游";
    _carLabel1.hidden = YES;
    [self addSubview:_carLabel1];
    _carLabel2 = [UILabel createWithFrame:CGRectMake(0, 0, 100, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _carLabel2.top = _carLabel1.bottom+10;
    _carLabel2.left = _carLabel1.left;
    _carLabel2.adjustsFontSizeToFitWidth = YES;
    _carLabel2.hidden = YES;
    [self addSubview:_carLabel2];

// 接单
    _orderLabel1 = [UILabel createWithFrame:CGRectMake(0, 0, 100, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _orderLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    _orderLabel1.left = 15;
    _orderLabel1.top = _guideLabel2.bottom+15;
    _orderLabel1.text = @"接单情况";
    [self addSubview:_orderLabel1];
    _orderLabel2 = [UILabel createWithFrame:CGRectMake(15, 0, 100, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _orderLabel2.top = _orderLabel1.bottom+10;
    _orderLabel2.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_orderLabel2];

    _images = [[NSMutableArray alloc]initWithCapacity:5];
    for (int i = 0; i < 5; i ++ ) {
        UIImageView *xingxing = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        xingxing.left = _orderLabel2.right +10 + i*16;
        xingxing.top = _orderLabel2.top;
        [_images addObject:xingxing];
        [self addSubview:xingxing];
    }

    _orderLabel3 = [UILabel createWithFrame:CGRectMake(15, 0, 150, 13) withFont:13 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _orderLabel3.top = _orderLabel2.bottom+12;
    _orderLabel3.text = @"查看评论(4) >>";
    [_orderLabel3 whenTapped:^{
        if (_commentAction) {
            _commentAction(_infoDic);
        }
    }];
    [self addSubview:_orderLabel3];

//
    _skillLabel = [UILabel createWithFrame:CGRectMake(0, 0, 100, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _skillLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    _skillLabel.left = 15;
    _skillLabel.top = _orderLabel3.bottom+15;
    _skillLabel.text = @"TA的技能";
    [self addSubview:_skillLabel];

    _skills = [[NSMutableArray alloc]initWithCapacity:4];

    NSArray *skillStrings = @[@"中文导游",@"摄影达人",@"会开车",@"可带车"];
    for (int i = 0; i<4; i++) {
        UILabel *label = [UILabel createWithFrame:CGRectZero withFont:13 withTextAligment:NSTextAlignmentCenter withTextColor:lightTextColor];
        label.top = _skillLabel.bottom+10;
        label.layer.cornerRadius = 3;
        label.layer.masksToBounds = YES;
        label.layer.borderColor = lightTextColor.CGColor;
        label.layer.borderWidth = 1;
        label.text = skillStrings[i];
        [label sizeToFit];
        label.height += 5;
        label.width += 5;
        label.hidden = YES;
        [self addSubview:label];
        [_skills addObject:label];
    }

    _isVLabel = [UILabel createWithFrame:CGRectMake(0, 0, 65, 25) withFont:15 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _isVLabel.top = 10;
    _isVLabel.right = Screen_weight - 12;
    _isVLabel.text = @"V 已认证";
    _isVLabel.layer.cornerRadius = 3;
    _isVLabel.layer.masksToBounds = YES;
    _isVLabel.backgroundColor = [UIColor colorWithRed:0.988 green:0.584 blue:0.153 alpha:1.00];
    _isVLabel.hidden = YES;
    [self addSubview:_isVLabel];

    _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _callBtn.size = CGSizeMake(70, 23);
    _callBtn.backgroundColor = NavBgColor;
    [_callBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [_callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _callBtn.centerY = _guideLabel1.centerY;
    _callBtn.right = Screen_weight - 12;
    _callBtn.layer.cornerRadius = 3;
    _callBtn.layer.masksToBounds = YES;
    _callBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_callBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_callBtn];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 0.5)];
    lineView.backgroundColor = lightTextColor;
    lineView.bottom = 320;
    [self addSubview:lineView];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setWithDic:(NSDictionary *)dic{
    NSLog([dic description],nil);
    _infoDic = dic;
    [_headV setImageWithURL:[NSURL URLWithString:[dic objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    _nameLabel.text = [dic objectForKeyNotNull:@"name"];
    [_nameLabel sizeToFit];
    _nameLabel.centerX = Screen_weight/2 - 10;
    _sexImg.left = _nameLabel.right +7;
    if ([dic objectForKeyNotNull:@"price"]) {
        _guideLabel2.text = [NSString stringWithFormat:@"%d RMB/天",[dic[@"price"] intValue]];
    }else{
        _guideLabel2.text = @"";
    }
    if ([dic objectForKeyNotNull:@"has_car"] &&[dic[@"has_car"] intValue]) {
        _carLabel1.hidden = NO;
        _carLabel2.hidden = NO;
        _carLabel2.text = [NSString stringWithFormat:@"%d RMB/天",[dic[@"w_car_price"] intValue]];
    }else{
        _carLabel1.hidden = YES;
        _carLabel2.hidden = YES;
    }

    float score = [dic[@"score"] floatValue];
    for (int i = 1; i<6 ; i++) {
        UIImageView *xingxing = _images[i-1];
        if (i == score) {
            xingxing.image = [UIImage imageNamed:@"d_star"];
        }else{
            if (i<score) {
                xingxing.image = [UIImage imageNamed:@"d_star"];
            }else{
                if (i == score + 0.5) {
                    xingxing.image = [UIImage imageNamed:@"d_star_n"];
                }else{
                    xingxing.image = [UIImage imageNamed:@"d_star_p"];
                }
            }
        }
    }

    _orderLabel2.text = [NSString stringWithFormat:@"%d 单已完成",[dic[@"orders"] intValue]];
    _orderLabel3.text =[NSString stringWithFormat:@"查看评论(%d) >>",[dic[@"discussCnt"] intValue]];

    if ([dic[@"auth"] intValue]) {
        _isVLabel.hidden = NO;
    }else{
        _isVLabel.hidden = YES;
    }

    NSArray *array2 = @[@"chiness",@"cameraman",@"driver",@"has_car"];
    UIView *preView = nil;
    for (int i = 0; i<4; i++) {
        UILabel *label = _skills[i];
        if ([dic[array2[i]] intValue]) {
            label.hidden = NO;
            if (!preView) {
                label.left = 15;
            }else{
                label.left = preView.right+10;
            }
            preView = label;
        }else{
            label.hidden = YES;
        }
    }

    if ([dic objectForKeyNotNull:@"genders"]) {
        if ([dic[@"genders"] intValue]) {
            _sexImg.image = [UIImage imageNamed:@"man1"];
        }else{
            _sexImg.image = [UIImage imageNamed:@"women2"];
        }

    }else{
        _sexImg.image = [UIImage imageNamed:@"man1"];
    }

}

-(void)callClick{
    if (_callAction) {
        _callAction(_infoDic);
    }
}

@end
