//
//  TPFreeTravelingDetailCell.m
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import "TPFreeTravelingDetailCell.h"
#import "TPCustomTool.h"

@implementation TPFreeTravelingDetailCell{
    UIImageView * imageView;
    UILabel * titleLable;
    UILabel * commentLable;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.size = CGSizeMake(Screen_weight, (Screen_weight-40)/23*12+20);
    
    titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(Screen_weight-40, 50);
    titleLable.centerX = Screen_weight/2;
    titleLable.top = 0;
    titleLable.textColor = HexRGBAlpha(0xFF7F05, 1.0);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:14.0f];
    titleLable.numberOfLines = 0;
    [self addSubview:titleLable];
    
    imageView = [[UIImageView alloc]init];
    imageView.size = CGSizeMake(Screen_weight-40, (Screen_weight-40)/23*12);
    imageView.centerX = Screen_weight/2;
    imageView.top = titleLable.bottom+10;
    [self addSubview:imageView];
    
    commentLable = [[UILabel alloc]init];
    commentLable.size = CGSizeMake(Screen_weight-40, 50);
    commentLable.centerX = Screen_weight/2;
    commentLable.bottom = imageView.bottom;
    commentLable.textColor = HexRGBAlpha(0x5E5E5E, 1.0);
    commentLable.textAlignment = NSTextAlignmentCenter;
    commentLable.font = [UIFont systemFontOfSize:13.0f];
    commentLable.numberOfLines = 0;
    [self addSubview:commentLable];
}

-(void)loadDataWithDict:(NSDictionary *)dict{
    float height = [TPFreeTravelingDetailCell getDetailCellHeightWith:dict];
    self.size = CGSizeMake(Screen_weight, height);
    
    [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];

    
    NSString * title = [dict objectForKeyNotNull:@"title"];
    if (title&&(![title isEqualToString:@""])) {
        titleLable.hidden = NO;
        titleLable.size = CGSizeMake(Screen_weight-40, [TPCustomTool heightForString:title fontSize:14.0 andWidth:(Screen_weight-40)]);
        titleLable.text = title;
        imageView.top = titleLable.bottom+10;
    }else{
        titleLable.hidden = YES;
        imageView.top = 10;
    }
    
    NSString * comment = [dict objectForKeyNotNull:@"comment"];
    if (comment&&(![comment isEqualToString:@""])) {
        commentLable.hidden = NO;
        commentLable.size = CGSizeMake(Screen_weight-40, [TPCustomTool heightForString:comment fontSize:13.0 andWidth:(Screen_weight-40)]);
        commentLable.text = comment;
        commentLable.top = imageView.bottom+10;
    }else{
        commentLable.hidden = YES;
    }
}


+(float)getDetailCellHeightWith:(NSDictionary *)dict{
    float height = (Screen_weight-40)/23*12+20;
    NSString * title = [dict objectForKeyNotNull:@"title"];
    if (title&&(![title isEqualToString:@""])) {
        height = height+[TPCustomTool heightForString:title fontSize:14.0 andWidth:(Screen_weight-40)];
    }
    NSString * comment = [dict objectForKeyNotNull:@"comment"];
    if (comment&&(![comment isEqualToString:@""])) {
        height = height+[TPCustomTool heightForString:comment fontSize:13.0 andWidth:(Screen_weight-40)]+10;
    }
    return height;
}

@end
