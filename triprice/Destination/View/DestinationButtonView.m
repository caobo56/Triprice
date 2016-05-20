//
//  DestinationButtonView.m
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import "DestinationButtonView.h"

@implementation DestinationButtonView


-(JDDCustomBtn *)createBtnWithNImage:(UIImage *)nImage withHImage:(UIImage *)hImage withTitle:(NSString *)title{
    JDDCustomBtn *button = [[JDDCustomBtn alloc]init];
    button.size = CGSizeMake(self.size.width/3, self.size.height/2);
    button.left = 0;
    [button setHomeImage:nImage withTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [button setTitleEdgeInsets:UIEdgeInsetsMake(50,
                                              -nImage.size.width,
                                              0.0,
                                              0.0)];

    [self addSubview:button];
    return button;
}

-(void)createView{
    
    self.backgroundColor = [UIColor clearColor];

    NSArray *array = @[@"in0",@"in1",@"in2",@"in3",@"in4",@"in5"];

    _button1 = [self createBtnWithNImage:[UIImage imageNamed:array[0]] withHImage:nil withTitle:@"地接"];
    _button1.left = 0;
    _button1.top = 0;
    _button1.tag = 1000;
    [self addSubview:_button1];

    _button2 = [self createBtnWithNImage:[UIImage imageNamed:array[1]] withHImage:nil withTitle:@"景点"];
    _button2.left = Screen_weight/3;
    _button2.top = 0;
    _button2.tag = 1001;
    [self addSubview:_button2];

    _button3 = [self createBtnWithNImage:[UIImage imageNamed:array[2]] withHImage:nil withTitle:@"美食"];
    _button3.left = _button2.right;
    _button3.top = 0;
    [self addSubview:_button3];

    _button4 = [self createBtnWithNImage:[UIImage imageNamed:array[3]] withHImage:nil withTitle:@"酒店"];
    _button4.left = 0;
    _button4.top = _button1.bottom;
    [self addSubview:_button4];

    _button5 = [self createBtnWithNImage:[UIImage imageNamed:array[4]] withHImage:nil withTitle:@"指南"];
    _button5.left = Screen_weight/3;
    _button5.top = _button1.bottom;
    [self addSubview:_button5];

    _button6 = [self createBtnWithNImage:[UIImage imageNamed:array[5]] withHImage:nil withTitle:@"购物"];
    _button6.left = _button2.right;
    _button6.top = _button1.bottom;
    [self addSubview:_button6];

    _button3.tag = 1002;
    _button4.tag = 1003;
    _button5.tag = 1004;
    _button6.tag = 1005;

    [_button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button5 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button6 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(id)init{
    self = [super initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(210))];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)buttonClick:(UIButton *)btn{
    if (_action) {
        _action(btn.tag);
    }
}

@end
