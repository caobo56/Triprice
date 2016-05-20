//
//  DDOtherCell.m
//  triprice
//
//  Created by MZY on 16/2/23.
//
//

#import "DDOtherCell.h"
#import "UIImageView+WebCache.h"

@interface DDOtherCell ()

@property (strong, nonatomic) UIImageView *bgImage;
@property (strong, nonatomic) UILabel *chNameLabel;
@property (strong, nonatomic) UILabel *enNameLabel;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UILabel *moneyLabel;

@end

@implementation DDOtherCell

-(void)createView{

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(168))];
    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(168))];
    _moneyLabel = [UILabel createWithFrame:CGRectMake(0, 0, 50,25) withFont:16 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _moneyLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    _moneyLabel.bottom = _bgImage.height - 20;
    _moneyLabel.hidden = YES;
    [_bgImage addSubview:_moneyLabel];

    [bgView addSubview:_bgImage];
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];

    _chNameLabel = [UILabel createWithFrame:CGRectMake(15, 0, Screen_weight-15, 16) withFont:16 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _chNameLabel.top = _bgImage.bottom+ 10;
    [self addSubview:_chNameLabel];

    _enNameLabel =  [UILabel createWithFrame:CGRectMake(15, 0, Screen_weight-15, 15) withFont:15 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _enNameLabel.top = _chNameLabel.bottom+6;
    [self addSubview:_enNameLabel];

    _images = [[NSMutableArray alloc]initWithCapacity:5];
    for (int i = 0; i<5; i++) {
        UIImageView *xingxing = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
        xingxing.left = 15 + i*16;
        xingxing.top = _enNameLabel.bottom+7;
        [_images addObject:xingxing];
        [self addSubview:xingxing];
    }

    UIView *view = _images.lastObject;
    _commentLabel = [UILabel createWithFrame:CGRectMake(15, 0, Screen_weight-15, 15) withFont:15 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _commentLabel.left = view.right+10;
    _commentLabel.top = _enNameLabel.bottom+7;
    [self addSubview:_commentLabel];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setWithDic:(NSDictionary *)dic{
//    [_bgImage setImageWithURL:[NSURL URLWithString:[dic     objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    _bgImage.frame = CGRectMake(0, 0, Screen_height, rateLangth(168));
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:[dic     objectForKeyNotNull:@"pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGSize imageSize = image.size;
            float i = imageSize.height/imageSize.width;
            float newHeight = Screen_weight*i;
            _bgImage.height = newHeight;
            _bgImage.centerY = rateLangth(168)/2;
            NSLog([_bgImage description],nil);
        }
    }];

//    [_bgImage setImageWithURLRequest:[] placeholderImage:(nullable UIImage *) success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
//
//    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//
//    }];


    _chNameLabel.text = [dic objectForKeyNotNull:@"name"];
    _enNameLabel.text = [dic objectForKeyNotNull:@"outline"];

    float score = [[dic objectForKeyNotNull:@"score"] floatValue];
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
    _commentLabel.text = [NSString stringWithFormat:@"%.1f分 / %d点评",score,[dic[@"discussCnt"] intValue]];

    if ([dic objectForKeyNotNull:@"price"]) {
        NSString *string = dic[@"price"];
        if ([string isKindOfClass:[NSNumber class]]) {
            string = [NSString stringWithFormat:@"%d元",[string intValue]];
        }
        _moneyLabel.text = string;
        _moneyLabel.width = 100;
        [_moneyLabel sizeToFit];
        _moneyLabel.height+=8;
        _moneyLabel.width+=20;
        _moneyLabel.hidden = NO;
    }else{

        if (_hasMoney) {
            _moneyLabel.text = @"暂无";
            _moneyLabel.width = 100;
            [_moneyLabel sizeToFit];
            _moneyLabel.height+=8;
            _moneyLabel.width+=20;
            _moneyLabel.hidden = NO;

        }else{
            _moneyLabel.hidden = YES;
        }
    }

}

@end
