//
//  SegmentView.m
//  SegmentTest
//
//  Created by MZY on 14-5-20.
//  Copyright (c) 2014年 Mzy. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView (){
    float width;
    float height;
}

@property (strong, nonatomic) NSMutableArray *viewArray;
@property (strong, nonatomic) UIImageView *backImage;
@property (strong, nonatomic) NSArray *stringArray;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *bgColor;
@property (strong, nonatomic) UIFont *textFont;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger prev;
@property (nonatomic) CGFloat linawidth;
@property(weak, nonatomic) UIView *line;

@end

@implementation SegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _index = 0;
        _prev = 0;
        _viewArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)createLabel{

    int ww = 1;
    int count = (int)[_stringArray count];
    CGSize size = self.frame.size;
   
    width = (size.width-(count+1)*ww)/count;
    height = size.height;

    if (!_backImage) {
        _backImage = [[UIImageView alloc]init];
    }
    if (!_newSegment) {
        _backImage.frame = CGRectMake(0, 0, width, height);
        _backImage.backgroundColor =_textColor ;
        [self addSubview:_backImage];
    }else{
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 0.5)];
        line.backgroundColor = _textColor;
        line.bottom = size.height;
        _line = line;
//        [self addSubview:line];
        _backImage.frame = CGRectMake(0, 0, _linawidth?_linawidth:width, 2);
        _backImage.backgroundColor = _textColor;
        _backImage.bottom = size.height;
        [self addSubview:_backImage];
    }

    for (int i = 0; i<count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(ww+i*(width+ww), 0, width, height);
        label.text = _stringArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = _textFont;
        label.backgroundColor = [UIColor clearColor];
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeTouch:)];
        [label addGestureRecognizer:tap];
        [_viewArray addObject:label];
        if (!_newSegment) {
            if ( i!= 0) {
                UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(i*(width+ww), 0, ww, height)];
                line.backgroundColor = _textColor;
                [self addSubview:line];
            }
            label.textColor = _textColor;
        }else{
            label.textColor = [UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.00];
        }
        label.layer.masksToBounds = YES;
    }

    self.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
}

-(void)createLabel:(UIColor *) bgcolor{

    int ww = 1;
    int count = (int)[_stringArray count];
    CGSize size = self.frame.size;
    
    width = (size.width-(count+1)*ww)/count;
    height = size.height;
    
    if (!_backImage) {
        _backImage = [[UIImageView alloc]init];
    }
    if (!_newSegment) {
        _backImage.frame = CGRectMake(0, 0, width, height);
        _backImage.backgroundColor =_textColor ;
        [self addSubview:_backImage];
    }else{
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.125 green:0.514 blue:0.953 alpha:1.00];
        line.bottom = size.height;
        _line = line;
        [self addSubview:line];
        _backImage.frame = CGRectMake(0, 0, _linawidth?_linawidth:width, 2);
        _backImage.backgroundColor = _textColor;
        _backImage.bottom = size.height;
        [self addSubview:_backImage];
    }
    
    for (int i = 0; i<count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(ww+i*(width+ww), 0, width, height);
        label.text = _stringArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = _textFont;
        label.backgroundColor = [UIColor clearColor];
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeTouch:)];
        [label addGestureRecognizer:tap];
        [_viewArray addObject:label];
        if (!_newSegment) {
            if ( i!= 0) {
                UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(i*(width+ww), 0, ww, height)];
                line.backgroundColor = _textColor;
                [self addSubview:line];
            }
            label.textColor = _textColor;
        }else{
            label.textColor = [UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.00];
        }
        label.layer.masksToBounds = YES;
    }
    
    self.backgroundColor = _bgColor?_bgColor:[UIColor whiteColor];
}


-(void)showLine:(BOOL) isShow{
 
        _line.hidden = !isShow;
}

-(void)setBottomLineWidth:(CGFloat) width{
    _linawidth = width;
}

-(void)setStringArray:(NSArray *)array textColor:(UIColor *)textColor textFont:(UIFont *)textFont backGroundColor:(UIColor *) bgColor index:(NSInteger)index{
    
    self.layer.borderColor = bgColor.CGColor;
    _stringArray  = [[NSArray alloc]initWithArray:array];
    _textColor = textColor;
    _textFont = textFont;
    _index = index;
    _bgColor = bgColor;
    [self createLabel:bgColor];
    [self moveView:NO];
    
}

-(void)setStringArray:(NSArray *)array textColor:(UIColor *)textColor textFont:(UIFont *)textFont index:(NSInteger)index{

    self.layer.borderColor = textColor.CGColor;
    if (_stringArray) {
        _stringArray = nil;
    }
    _stringArray  = [[NSArray alloc]initWithArray:array];
    _textColor = textColor;
    _textFont = textFont;
    _index = index;
    [self createLabel];
    [self moveView:NO];

}

-(void)moveView:(BOOL)animation{
    UILabel *label = [_viewArray objectAtIndex:_index];
    UILabel *label2 = [_viewArray objectAtIndex:_prev];
    if (!_newSegment) {
        label.textColor = _bgColor?_bgColor:[UIColor whiteColor];
    }else{
        label.textColor = _textColor;
    }
    if (_index!= _prev) {
        if (!_newSegment) {
            label2.textColor = _textColor;
        }else{
            label2.textColor = [UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.00];
        }
    }
    if (self.delegate) {
        [self.delegate changeValue:_index];
    }

    [UIView animateWithDuration:animation? 0.2:0 animations:^{
        if (!_newSegment) {
            _backImage.frame = CGRectMake(1+_index*(width+1), 0, width, height);
        }else{
//            _backImage.left = 1+_index*(width+1);
            _backImage.centerX = label.centerX;
        }
    } completion:^(BOOL finished) {

    }];
}

-(void)changeTouch:(UITapGestureRecognizer *)tap{
    NSInteger index = [_viewArray indexOfObject:tap.view];
    if (index == _index) {
        return;
    }else{
        _prev = _index;
        _index = index;
        [self moveView:YES];
    }
}

-(void)changeView:(NSInteger) index{
   
    NSLog(@"%ld",index);
    if (index+_index > [_viewArray count] || index+_index < 0) {
        return;
    }else{
        _prev = _index;
        _index = index+_index;
        [self moveView:YES];
    }

}

@end
