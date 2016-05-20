//
//  DestinationButtonView.h
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import <UIKit/UIKit.h>

typedef void(^MYAction)(NSInteger);


@interface DestinationButtonView : UIView
@property (strong, nonatomic) JDDCustomBtn *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIButton *button3;
//第二行
@property (strong, nonatomic) UIButton *button4;
@property (strong, nonatomic) UIButton *button5;
@property (strong, nonatomic) UIButton *button6;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) MYAction action;
@end
