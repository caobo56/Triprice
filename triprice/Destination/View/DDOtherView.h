//
//  DDOtherView.h
//  triprice
//
//  Created by MZY on 16/2/23.
//
//

#import <UIKit/UIKit.h>

typedef void(^MyDicAction)(NSDictionary *dic);

typedef NS_ENUM(NSUInteger,OtherViewState) {
    Meijing = 0,
    Meishi,
    Jiudian,
    Gouwu,
};


@interface DDOtherView : UIView
@property (strong, nonatomic) NSDictionary *infoDic;
@property ( nonatomic) OtherViewState viewState;
@property (strong, nonatomic) MyDicAction otherAction;

-(id)initWithFrame:(CGRect)frame withViewState:(OtherViewState)viewState withDic:(NSDictionary *)dic;
@end
