//
//  TPHomeBgView.h
//  triprice
//
//  Created by caobo56 on 16/2/14.
//
//

#import <UIKit/UIKit.h>

@interface TPHomeBgView : UIScrollView

@property(nonatomic,strong)UIImageView * imageView;

-(void)setImageURL:(NSString *)url;

@end
