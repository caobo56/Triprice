//
//  DestinationRootCell.m
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import "DestinationRootCell.h"

@interface DestinationRootCell ()

@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *countryLable;
@property (strong, nonatomic) UILabel *descripLabel;

@end

@implementation DestinationRootCell

- (void)awakeFromNib {

}

-(void)createView{

    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(167))];
    [self addSubview:_imageV];

    _nameLable = [UILabel createWithFrame:CGRectMake(0, 0,Screen_weight, 22) withFont:22 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _nameLable.top = rateLangth(38);
    [self addSubview:_nameLable];

    _countryLable = [UILabel createWithFrame:CGRectMake(0, 0, Screen_weight, 13) withFont:13 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _countryLable.top = _nameLable.bottom+F15;
    [self addSubview:_countryLable];

    _descripLabel = [UILabel createWithFrame:CGRectMake(0, 0, 45, 15) withFont:F10 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _descripLabel.layer.cornerRadius = 15/2.0;
    _descripLabel.layer.masksToBounds = YES;
    _descripLabel.backgroundColor = [UIColor colorWithRed:0.953 green:0.243 blue:0.329 alpha:1.00];
    _descripLabel.text = @"免签";
    _descripLabel.centerX = Screen_weight/2;
    _descripLabel.top = _countryLable.bottom+F15;
    [self addSubview:_descripLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setNameString:(NSString *)nameString{
    _nameString = nameString;
    _nameLable.text = nameString;
    [self addSubview:_nameLable];
}

-(void)setCountryString:(NSString *)countryString{
    _countryString = countryString;
    _countryLable.text = countryString;
    [self addSubview:_countryLable];
}

-(void)setDescripString:(NSString *)descripString{
    _descripString = descripString;
    _descripLabel.text = descripString;
}

-(void)setWithDic:(NSDictionary *)dic{
    _nameLable.text = dic[@"name"];
    _countryLable.text = dic[@"country"];

    if ([dic objectForKeyNotNull:@"visa"]) {
        if ([dic[@"visa"] intValue]  == 1) {
            _descripLabel.text = @"免签";
            _descripLabel.width = 45;
            _descripLabel.centerX = Screen_weight/2;

            _descripLabel.hidden = NO;
        }else if ([dic[@"visa"] intValue]  == 0){
            _descripLabel.text = @"需要签证";
            _descripLabel.width = 70;
            _descripLabel.centerX = Screen_weight/2;
            _descripLabel.hidden = NO;
        }else if ([dic[@"visa"] intValue]  == 2){
            _descripLabel.text = @"落地签";
            _descripLabel.width = 60;
            _descripLabel.centerX = Screen_weight/2;
            _descripLabel.hidden = NO;
        }
    }else{
        _descripLabel.hidden = YES;
    }
    if ([dic objectForKeyNotNull:@"pic"]) {
        [_imageV setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:nil];
    }
}

@end
