//
//  NeedDetailCell.m
//  triprice
//
//  Created by MZY on 16/3/16.
//
//

#import "NeedDetailCell.h"
#import "UIImageView+WebCache.h"

@interface NeedDetailCell ()
@property (nonatomic , strong) UIImageView *imageV;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *descripLabel;

@end

@implementation NeedDetailCell

-(void)createView{

    UIView *imageB = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 110, 80)];
    imageB.backgroundColor = [UIColor clearColor];
    imageB.layer.masksToBounds = YES;
    [self addSubview:imageB];

    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 80)];
    _imageV.backgroundColor = [UIColor clearColor];
    [imageB addSubview:_imageV];

    _nameLabel = [UILabel createWithFrame:CGRectMake(0, 0, 150, 16) withFont:16 withTextAligment:NSTextAlignmentLeft withTextColor:darkTextColor];
    _nameLabel.left = imageB.right+12;
    _nameLabel.top = 25;
    [self addSubview:_nameLabel];

    _descripLabel = [UILabel createWithFrame:CGRectMake(0, 0, Screen_weight - 30 -imageB.right - 12, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _descripLabel.left = _nameLabel.left;
    _descripLabel.top = _nameLabel.bottom+10;
    [self addSubview:_descripLabel];

    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 12)];
    icon.centerY = 50;
    icon.right = Screen_weight - 15;
    icon.backgroundColor = [UIColor redColor];
    [self addSubview:icon];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 99, Screen_weight - 15, 1)];
    line.backgroundColor = cellLineColorTp;
    [self addSubview:line];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setInfoWithDic:(NSDictionary *)dic{
    _descripLabel.text = [dic objectForKeyNotNull:@"outline"];
    _nameLabel.text = [dic objectForKeyNotNull:@"title"];
    NSString *picImage = [dic objectForKeyNotNull:@"pic"];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:picImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize imageSize = image.size;
        float i = imageSize.height/imageSize.width;
        float newHeight = 110*i;
        _imageV.height = newHeight;
        _imageV.centerY = 40;
    }];
}


@end
