//
//  DestinationCommentCell.m
//  triprice
//
//  Created by MZY on 16/2/24.
//
//

#import "DestinationCommentCell.h"

@implementation DestinationCommentCell

-(void)createFirstView{
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 20)];
    _firstView.hidden = YES;
    _firstView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel createWithFrame:CGRectMake(10, 7, 100, 13) withFont:13 withTextAligment:NSTextAlignmentLeft withTextColor:HexRGBAlpha(0x26323B, 1.0)];
    label.text = @"评论";
    [_firstView addSubview:label];

    [self addSubview:_firstView];
}

-(void)createView{

    _images = [[NSMutableArray alloc]initWithCapacity:0];

    [self createFirstView];
    _nameLabel = [UILabel createWithFrame:CGRectMake(10, 10, 50, 15) withFont:15 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    [self addSubview:_nameLabel];

    _timeLabel = [UILabel createWithFrame:CGRectMake(0, 0, 200, 12) withFont:12 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _timeLabel.bottom = _nameLabel.bottom;
    _timeLabel.left = _nameLabel.right +7;
    [self addSubview:_timeLabel];

    for (int i = 0; i<5; i++) {
        UIImageView *xingxing = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
        xingxing.left = Screen_weight - 15 -80 + i*16;
        xingxing.top = _nameLabel.top;
        [_images addObject:xingxing];
        [self addSubview:xingxing];
    }

    _infoLabel = [UILabel createWithFrame:CGRectMake(10, 0, Screen_weight - 25, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _infoLabel.top = _nameLabel.bottom+10;
    _infoLabel.numberOfLines = 0;
    _infoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_infoLabel];

    _line = [[UIView alloc]initWithFrame:CGRectMake(10, 0 , Screen_weight-20,1)];
    _line.backgroundColor = cellLineColorTp;
    _line.top = _infoLabel.bottom+9;
    [self addSubview:_line];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib {
    // Initialization code
}



+(CGFloat)getHeightCellWithString:(NSString *)string{

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 3;
    CGSize size2 = [string boundingRectWithSize:CGSizeMake(Screen_height-25, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style} context:nil].size;
    return size2.height;
}

-(void)setWithDic:(NSDictionary *)dic withIsFirst:(BOOL)isFirst{
    if (isFirst) {
        _firstView.hidden = NO;
        _nameLabel.top = _firstView.bottom+10;
        }
    else{
        _firstView.hidden = YES;
        _nameLabel.top = 10;
    }
    _nameLabel.width = 100;
    _nameLabel.text = [dic objectForKeyNotNull:@"nickName"];
    [_nameLabel sizeToFit];
    _timeLabel.text = [dic objectForKeyNotNull:@"createTime"];
    _timeLabel.left = _nameLabel.right +7;
    _timeLabel.bottom = _nameLabel.bottom;

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 3;
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:dic[@"comment"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style}];
    _infoLabel.attributedText = att;
    _infoLabel.height = [DestinationCommentCell getHeightCellWithString:dic[@"comment"]];
    _infoLabel.top = _nameLabel.bottom+10;
    _line.top = _infoLabel.bottom+9;

    float score = [[dic objectForKeyNotNull:@"score"] floatValue];
    for (int i = 1; i<6 ; i++) {
        UIImageView *xingxing = _images[i-1];
        xingxing.top = _nameLabel.top;

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
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
