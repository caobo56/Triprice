//
//  DestinationAddCommentVC.m
//  triprice
//
//  Created by MZY on 16/2/24.
//
//

#import "DestinationAddCommentVC.h"
#import "TPWeekRecommendTopView.h"
#import "YYAccountTool.h"
#import "TPLoginMaster.h"
#import "DestinationAddCommentVC.h"

@interface DestinationAddCommentVC ()<UITextViewDelegate>{
    CGFloat commentScore;
}

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) NSMutableArray *images;


@end

@implementation DestinationAddCommentVC


-(void)createView{

    self.view.backgroundColor = [UIColor whiteColor];

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView setTitle:@"评论"];
    [self.view addSubview:topView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 22, 40, topView.height-22);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.right = Screen_weight - 20;
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];

    for (int i = 0; i<5; i++) {
        UIImageView *xingxing = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        xingxing.image = [UIImage imageNamed:@"d_star_p"];
        xingxing.left = Screen_weight/2-68 + i*28;
        xingxing.top = topView.bottom+18;
        [_images addObject:xingxing];
        [self.view addSubview:xingxing];

        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, 25, 25);
        btn1.backgroundColor = [UIColor clearColor];
        btn1.tag = i*2+2;
        [btn1 addTarget:self action:@selector(setScore:) forControlEvents:UIControlEventTouchUpInside];
        [xingxing addSubview:btn1];

        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, 12.5, 25);
        btn2.backgroundColor = [UIColor clearColor];
        btn2.tag = i*2+1;
        [btn2 addTarget:self action:@selector(setScore:) forControlEvents:UIControlEventTouchUpInside];
        [xingxing addSubview:btn2];

        xingxing.userInteractionEnabled = YES;
    }

    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, Screen_weight - 30, 200)];
    _textView.top = topView.bottom+55;
    _textView.textColor = lightTextColor;
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14];
    [[_textView layer] setCornerRadius:5];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = cellLineColorTp.CGColor;
    _textView.text = @"在此输入评论";
    [self.view addSubview:_textView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _images = [[NSMutableArray alloc]initWithCapacity:0];
    [self createView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setScore:(UIButton *)btn{
    commentScore = btn.tag/2.0;
    CGFloat score = commentScore;

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
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"在此输入评论"]) {
        textView.text = @"";
        textView.textColor = darkTextColor;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (!textView.text.length) {
        textView.text = @"在此输入评论";
        textView.textColor = lightTextColor;
    }
}

-(void)addClick{

    if ([_textView.text isEqualToString:@"在此输入评论"]) {
        return;
    }
    DestinationAddCommentVC *__weak blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString *url = @"";
    MTUser *user = [YYAccountTool account];

    if (_viewTpye == OrderAddCommentView) {
        [dict setValue:_infoDic[@"product_id"] forKey:@"comment.id"];
        [dict setValue:[NSNumber numberWithFloat:commentScore] forKey:@"comment.score"];
        [dict setValue:_textView.text forKey:@"comment.comment"];
        [dict setValue:user.userId forKey:@"comment.userId"];
        url = @"booking/takeOrderComment.do";

    }else{
        [dict setValue:_infoDic[@"id"] forKey:@"comment.id"];
        [dict setValue:[NSNumber numberWithFloat:commentScore] forKey:@"comment.score"];
        [dict setValue:_textView.text forKey:@"comment.comment"];
        [dict setValue:user.userId forKey:@"comment.userId"];
        url = @"destination/discussTrouistComment.do";
    }
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:url] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if ([error isEqualToString:@"请重新登录"]) {
            [self reLogin];
            return ;
        }

        if (dict) {
            if ([dict objectForKeyNotNull:@"isSuccess"]) {
                if ([dict[@"isSuccess"] intValue]) {
                    [blkSelf.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }];

}

-(void)reLogin{
    [TPLoginMaster executionWithCurrentVC:self andBlock:^(BOOL LoginState) {
        if (LoginState) {

        }
    }];

}

@end
