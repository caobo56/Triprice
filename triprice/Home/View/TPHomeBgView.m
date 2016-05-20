//
//  TPHomeBgView.m
//  triprice
//
//  Created by caobo56 on 16/2/14.
//
//

#import "TPHomeBgView.h"


@implementation TPHomeBgView{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor clearColor];
    self.size = CGSizeMake(Screen_weight, Screen_height);
    self.top = 0;
    _imageView = [[UIImageView alloc]init];
    _imageView.size = self.size;
    _imageView.origin = CGPointMake(0, -20);
    _imageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_imageView];
    
    UIImage * home_bg = [UIImage imageNamed:@"home_bg"];
    _imageView.image = home_bg;
}

-(void)setImageURL:(NSString *)url{
    UIImage * home_bg = [UIImage imageNamed:@"home_bg"];
    __block TPHomeBgView * weakSelf = self;
    [_imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]  placeholderImage:home_bg success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakSelf.imageView.height = image.size.height/image.size.width*Screen_weight;
        weakSelf.imageView.image = image;
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

@end
