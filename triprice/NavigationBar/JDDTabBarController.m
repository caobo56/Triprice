//
//  JDDTabBarController.m
//  JingDuoduo
//
//  Created by caobo on 15/6/16.
//  Copyright (c) 2015年 11. All rights reserved.
//

#import "JDDTabBarController.h"

#import "HomeViewController.h"
#import "TPFreeTravelingViewController.h"
#import "DestinationRootVC.h"
#import "LJPersonalTableViewController.h"
#import "TPLoginMaster.h"

#import "JDDGuidanceView.h"
//#import "JDDTestMarkView.h"
#import "constant.h"

#import "UIColor+Help.h"
#import "UIImageView+AFNetworking.h"

//#import "JDDADPageView.h"

//#import "DataModel.h"

@interface JDDTabBarController ()

@property(strong,nonatomic) UIView *lunchView;


@end

@implementation JDDTabBarController{
//    JDDADPageView *pageView;
    JDDGuidanceView * guidView;
//    JDDModelTryLiveController *tryLiveVC;
}

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}



- (void)awakeFromNib
{
    NSMutableArray *tabAry = [NSMutableArray arrayWithArray:self.viewControllers];

    //首页
    HomeViewController *homeVC = (HomeViewController *)[[HomeViewController alloc]init];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [navHome setNavigationBarHidden:YES animated:NO];
    homeVC.navigationController.navigationBarHidden = YES;
    [tabAry replaceObjectAtIndex:0 withObject:navHome];
    
    //自由行
    TPFreeTravelingViewController *mallVC = [[TPFreeTravelingViewController alloc]init];
    UINavigationController *navMall = [[UINavigationController alloc] initWithRootViewController:mallVC];
    mallVC.navigationController.navigationBarHidden = YES;
    [tabAry replaceObjectAtIndex:1 withObject:navMall];
    
    //目的地
    DestinationRootVC *cart3VC = (DestinationRootVC *)[[DestinationRootVC alloc]init];
    UINavigationController *navCart3 = [[UINavigationController alloc]initWithRootViewController:cart3VC];
    navCart3.navigationController.navigationBarHidden = YES;
    [tabAry replaceObjectAtIndex:2 withObject:navCart3];
    
    //我的
    LJPersonalTableViewController *mineVC = [[LJPersonalTableViewController alloc] init];
    UINavigationController *navMine = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.navigationController.navigationBarHidden = YES;
    [tabAry replaceObjectAtIndex:3 withObject:navMine];
    [self setViewControllers:tabAry];
    
    //直接贴在storyboard上的图片不显示，所以需要用代码重写一遍，使用原始图片
//    [self setTabBarUI];
    _bottomView = [[TPHomeBottomView alloc]init];
    _bottomView.bottom = self.tabBar.bottom;
    [_bottomView.homeBtn addTarget:self action:@selector(homeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView.destinationBtn addTarget:self action:@selector(destinationClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView.mineBtn addTarget:self action:@selector(mineBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView.weekendBtn addTarget:self action:@selector(weekendBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addGuidanceView];
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBar.hidden = YES;
//#if kHOST_ProDuct// 1 生产  0 测试
//    //正式服务器
//#else
//    //测试服务器
//    JDDTestMarkView * mark = [JDDTestMarkView shareMark];
//    [mark show];
//#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)homeBtnClick{
    [self setSelectedIndex:0];
}

-(void)weekendBtnPress{
    [self setSelectedIndex:1];
}

-(void)destinationClick{
    [self setSelectedIndex:2];

}

-(void)mineBtnPress{
    [TPLoginMaster executionWithCurrentVC:self andBlock:^(BOOL LoginState) {
        if (LoginState) {
            [self setSelectedIndex:3];
        }
    }];
}

#pragma mark - Custom

- (void)setTabBarUI
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //更改tabbar的图片
    NSArray *normalImages = @[@"home",@"weekend",@"destination",@"mine"];
//    NSArray *selectedImages = @[@"nav_home_press",@"nav_mall_press",@"nav_shop_press",@"nav_mine_press"];
    
    for (NSInteger i=0; i<normalImages.count; i++) {
        UITabBarItem *item = [[self.tabBar items] objectAtIndex:i];
        
        UIImage *normalImage = [UIImage imageNamed:[normalImages objectAtIndex:i]];
        
//        UIImage *selectImage = [UIImage imageNamed:[selectedImages objectAtIndex:i]];
        
        [item setImage:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
//        [item setSelectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    
    //更改tabbar的文字、颜色
    NSArray *tabbarTitles = @[@"首页",@"特色自由行",@"目的地",@"我"];
    
    for (NSInteger i=0; i<tabbarTitles.count; i++) {
        UITabBarItem *item = [[self.tabBar items] objectAtIndex:i];
        NSString *title = [tabbarTitles objectAtIndex:i];
        [item setTitle:title];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
        //[item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0xb4/255.0f green:0x95/255.0f blue:0x67/255.0f alpha:1.0f]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexString:@"#FFFFFF"]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexString:@"#FFFFFF"]} forState:UIControlStateNormal];

    }
    //默认进入显示首页
    [self setSelectedIndex:0];
    
    UIView * mView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_weight, TabBarH)];//这是整个tabbar的颜色
    
    [mView setBackgroundColor:HexRGBAlpha(0x000000, 0.6)];
    [self.tabBar insertSubview:mView atIndex:0];
    mView.alpha=0.8;

}
#pragma mark-------判断启动页面加载图片内容
-(void)addGuidanceView{
    NSString * launchOptions = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstLaunch"];
    if ([launchOptions integerValue] == 0) {
        [self initUIGuidanceView];
    }else{
//        pageView = [JDDADPageView shareADPageView];
//        [self.view addSubview:pageView];
//        [self.view bringSubviewToFront:pageView];
    }
}

#pragma mark------当是第一次启动的时候引导页加载
-(void)initUIGuidanceView{
    guidView = [JDDGuidanceView shareGuidanceView];
    [self.view addSubview:guidView];
    [self.view bringSubviewToFront:guidView];
    [guidView.goBtn addTarget:self action:@selector(goBtnPress) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ----加载广告页面
-(void)goBtnPress{
//    pageView = [JDDADPageView shareADPageView];
//    [self.view addSubview:pageView];
//    [self.view bringSubviewToFront:pageView];
    [guidView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"firstLaunch"];
}

@end
