//
//  NeedListCell.m
//  triprice
//
//  Created by MZY on 16/3/15.
//
//

#import "NeedListCell.h"

@interface NeedListCell ()
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *moneyLabel;
@property (nonatomic , strong) UILabel *descripLabel;
@property (nonatomic , strong) NSMutableArray *imagesArray;


@end

@implementation NeedListCell

-(void)createView{
    _timeLabel = [UILabel createWithFrame:CGRectMake(58, 20, 130, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    [self addSubview:_timeLabel];

    _moneyLabel = [UILabel createWithFrame:CGRectMake(0, 0, 50, 17) withFont:17 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor colorWithRed:0.988 green:0.533 blue:0.169 alpha:1.00]];
    _moneyLabel.centerY = _timeLabel.centerY;
    [self addSubview:_moneyLabel];

    UILabel *moneyL = [UILabel createWithFrame:CGRectMake(0, 0, 20, 16) withFont:16 withTextAligment:NSTextAlignmentCenter withTextColor:lightTextColor];
    moneyL.text = @"预算";
    [moneyL sizeToFit];
    moneyL.centerY = _timeLabel.centerY;
    moneyL.right = Screen_weight - 12;
    [self addSubview:moneyL];
    _moneyLabel.right = moneyL.left - 5;

    _descripLabel = [UILabel createWithFrame:CGRectMake(0, 0, 0, 60) withFont:15 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _descripLabel.top = _timeLabel.bottom+20;
    _descripLabel.left = _timeLabel.left;
    _descripLabel.width = Screen_weight - _timeLabel.left - 12;
    _descripLabel.numberOfLines = 0;
    _descripLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_descripLabel];

    UILabel *label = [UILabel createWithFrame:CGRectMake(0, 0, 100, 15) withFont:15 withTextAligment:NSTextAlignmentLeft withTextColor:[UIColor colorWithRed:0.988 green:0.533 blue:0.169 alpha:1.00]];
    label.left = _descripLabel.left+2;
    label.top = _descripLabel.bottom+5;
    label.text = @"需要的服务";
    [self addSubview:label];

    _imagesArray = [[NSMutableArray alloc]initWithCapacity:4];

    NSArray *imagesA = @[@"flyTicket",@"hotel",@"carService",@"ticketService"];
    NSArray *stringA = @[@"机票",@"酒店",@"用车",@"门票"];

    for (int i = 0; i <4; i++) {

        UIView *imageBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 105/2, 138/2.0)];
        imageBack.backgroundColor = [UIColor clearColor];
        imageBack.layer.borderColor = cellLineColorTp.CGColor;
        imageBack.layer.borderWidth = 1;
        imageBack.layer.cornerRadius = 3;
        imageBack.layer.masksToBounds = YES;
        imageBack.hidden = YES;
        imageBack.top = label.bottom+10;
        [self addSubview:imageBack];

        UILabel *label = [UILabel createWithFrame:CGRectMake(0, 0, 105/2, 20) withFont:12 withTextAligment:NSTextAlignmentCenter withTextColor:lightTextColor];
        label.top = 69-25;
        label.text = stringA[i];
        [imageBack addSubview:label];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
        image.centerX = 105/4.0;
        image.top = 15;
        image.image = [UIImage imageNamed:imagesA[i]];
        [imageBack addSubview:image];
        
        [_imagesArray addObject:imageBack];
    }

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 1)];
    line.backgroundColor = cellLineColorTp;
    line.bottom = 236;
    [self addSubview:line];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setInfoWithDic:(NSDictionary *)dic{
    _descripLabel.text = [dic objectForKeyNotNull:@"requireDesc"];
    _timeLabel.text = [dic objectForKeyNotNull:@"pubTime"];
    if ([dic objectForKeyNotNull:@"price"]) {
        if ([dic[@"price"] intValue]) {
            _moneyLabel.text = [NSString stringWithFormat:@"¥%d",[dic[@"price"] intValue]];
        }else{
            _moneyLabel.text = @"¥未定";
        }
    }else{
        _moneyLabel.text = @"¥未定";
    }
    [self setService:[dic objectForKeyNotNull:@"service"]];

}

-(void)setService:(NSString *)service{
    if (service.length) {
        CGFloat left = _descripLabel.left+2;
        for (int i = 1; i<5; i++) {
            UIView *image = _imagesArray[i-1];
            NSString *string = [NSString stringWithFormat:@"%d",i];
            if ([service rangeOfString:string].length) {
                image.hidden = NO;
                image.left = left;
                left += 75;
            }else{
                image.hidden = YES;
            }
        }
    }else{
        for (int i = 0; i<4; i++) {
            UIView *image = _imagesArray[i];
            image.hidden = YES;
        }
    }
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
