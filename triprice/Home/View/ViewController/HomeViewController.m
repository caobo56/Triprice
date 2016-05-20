//
//  ViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/14.
//
//

#import "HomeViewController.h"
#import "TPWeekRecommendViewController.h"

#import "UIView+DDAddition.h"
#import "UIViewController+Loading.h"
#import "JDDCustomBtn.h"

#import "TPHomeBgView.h"
#import "TPHomeTopView.h"
#import "TPHomeBottomView.h"

#import "API/JDDAPIs.h"
#import "DestinationRootVC.h"


#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()

@end

@implementation HomeViewController{
    TPHomeBgView * bgView;
    UILabel * titleLable;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getHomeBgImageURL];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addAnimationToView:titleLable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    bgView = [[TPHomeBgView alloc]init];
    
    [self.view addSubview:bgView];
    
//    TPHomeTopView * topView = [[TPHomeTopView alloc]init];
//    [topView setTitle:@"子吾旅行"];
//    [self.view addSubview:topView];
    
    titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(Screen_weight, 40);
    titleLable.centerX = Screen_weight/2;
    titleLable.top = Screen_height*0.356;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = HexRGBAlpha(0xFFFFFF, 1.0);
    titleLable.font = [UIFont systemFontOfSize:32.0];
    titleLable.text = @"精致自由行";
    [self.view addSubview:titleLable];
    
    JDDCustomBtn * weekRecommendBtn = [[JDDCustomBtn alloc]init];
    weekRecommendBtn.size = CGSizeMake((Screen_weight-24-10)/2, 55);
    weekRecommendBtn.left = 12;
    weekRecommendBtn.bottom = Screen_height-282/2;
    [[weekRecommendBtn layer]setCornerRadius:3.0];//圆角
    [weekRecommendBtn setTitle:@"每周推荐 >" forState:UIControlStateNormal];
    weekRecommendBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [weekRecommendBtn setTitleColor:HexRGBAlpha(0xFFFFFF, 1.0) forState:UIControlStateNormal];
    weekRecommendBtn.backgroundColor = HexRGBAlpha(0x1e83fb, 1.0);
    [weekRecommendBtn addTarget:self action:@selector(weekRecommendBtnPress) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:weekRecommendBtn];
    
    JDDCustomBtn * postDemandBtn = [[JDDCustomBtn alloc]init];
    postDemandBtn.size = CGSizeMake((Screen_weight-24-10)/2, 55);
    postDemandBtn.left = weekRecommendBtn.right+10;
    postDemandBtn.bottom = Screen_height-282/2;
    [[postDemandBtn layer]setCornerRadius:3.0];//圆角
    [postDemandBtn setTitle:@"发布需求 >" forState:UIControlStateNormal];
    postDemandBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [postDemandBtn setTitleColor:HexRGBAlpha(0xFFFFFF, 1.0) forState:UIControlStateNormal];
    postDemandBtn.backgroundColor = HexRGBAlpha(0x8241a8, 1.0);
    [postDemandBtn addTarget:self action:@selector(postDemandBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postDemandBtn];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.size = CGSizeMake(Screen_weight-24, 0.5);
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.top = postDemandBtn.bottom+23;
    lineView.centerX = Screen_weight/2;
    lineView.alpha = 0.3;
    [self.view addSubview:lineView];
 
    TPHomeBottomView * bottomView = [[TPHomeBottomView alloc]init];
    [bottomView.destinationBtn addTarget:self action:@selector(destinationClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:bottomView];
}

-(void)weekRecommendBtnPress{
    TPWeekRecommendViewController * WeekRecommendVC = [[TPWeekRecommendViewController alloc]init];
    [self.navigationController pushViewController:WeekRecommendVC animated:YES];
    
}

-(void)postDemandBtnPress{
    
}

-(void)destinationClick{

    DestinationRootVC *destinationRoot = [[DestinationRootVC alloc]init];
    [self.navigationController pushViewController:destinationRoot animated:YES];

}


#pragma mark network_Data
//数据请求
-(void)getHomeBgImageURL{
    __block HomeViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [[JDDAPIs sharedJDDAPIs] getHomeBgImageURLWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [bgView setImageURL:[dict objectForKey:@"datas"]];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

#pragma mark 从左滑出动画
-(void)addAnimationToView:(UIView*)view{
    /* 移动 */
    CABasicAnimation *leftMove = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起始帧和终了帧的设定
    CGPoint leftBegin = CGPointMake(view.layer.position.x-Screen_weight, view.layer.position.y);
    leftMove.fromValue = [NSValue valueWithCGPoint:leftBegin]; // 起始帧
    CGPoint leftEnd = view.layer.position;
    leftMove.toValue = [NSValue valueWithCGPoint:leftEnd]; // 终了帧
    
    // 动画选项设定
    leftMove.duration = 1.0f;
    leftMove.repeatCount = 1;
    
    // 添加动画
    leftMove.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    // 添加动画
    [view.layer addAnimation:leftMove forKey:@"groupAnnimation"];
}
@end

















