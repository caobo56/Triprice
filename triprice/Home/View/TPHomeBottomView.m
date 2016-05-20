//
//  TPHomeBottomView.m
//  triprice
//
//  Created by caobo56 on 16/2/14.
//
//

#import "TPHomeBottomView.h"
#import "HomeViewController.h"
#import "DestinationRootVC.h"
#import "TPLoginMaster.h"
#import "LJPersonalTableViewController.h"
#import "TPFreeTravelingViewController.h"

@implementation TPHomeBottomView{
    UIViewController * currentVC;
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
    self.size = CGSizeMake(Screen_weight,TabBarH*1.5);
//    self.bottom = Screen_height;
    self.left = 0;
    self.backgroundColor = HexRGBAlpha(0x000000, 0.3);
    
    _homeBtn = [[JDDCustomBtn alloc]init];
    _homeBtn.size = CGSizeMake(self.size.width/4, self.size.height);
    _homeBtn.left = 0;
    UIImage * home = [UIImage imageNamed:@"home"];
    [_homeBtn setHomeImage:home withTitle:@"首页" forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_homeBtn];
    
    _weekendBtn = [[JDDCustomBtn alloc]init];
    _weekendBtn.size = CGSizeMake(self.size.width/4, self.size.height);
    _weekendBtn.left = Screen_weight/4;
    UIImage * weekend = [UIImage imageNamed:@"weekend"];
    [_weekendBtn setHomeImage:weekend withTitle:@"特色自由行" forState:UIControlStateNormal];
    [_weekendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_weekendBtn];
    
    _destinationBtn = [[JDDCustomBtn alloc]init];
    _destinationBtn.size = CGSizeMake(self.size.width/4, self.size.height);
    _destinationBtn.left = 2*Screen_weight/4;
    UIImage * destination = [UIImage imageNamed:@"destination"];
    [_destinationBtn setHomeImage:destination withTitle:@"目的地" forState:UIControlStateNormal];
    [_destinationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_destinationBtn];

    _mineBtn = [[JDDCustomBtn alloc]init];
    _mineBtn.size = CGSizeMake(self.size.width/4, self.size.height);
    _mineBtn.left = 3*Screen_weight/4;
    UIImage * mine = [UIImage imageNamed:@"mine"];
    [_mineBtn setHomeImage:mine withTitle:@"我" forState:UIControlStateNormal];
    [_mineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_mineBtn];
//    [self.homeBtn addTarget:self action:@selector(homeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.destinationBtn addTarget:self action:@selector(destinationClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.mineBtn addTarget:self action:@selector(mineBtnPress) forControlEvents:UIControlEventTouchUpInside];
//    [self.weekendBtn addTarget:self action:@selector(weekendBtnPress) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setCurrentVC:(UIViewController *)vc{
    currentVC = vc;
}
//
//-(void)homeBtnClick{
//    if (![currentVC isKindOfClass:[HomeViewController class]]) {
//        [currentVC.navigationController popViewControllerAnimated:YES];
//    }
//}
//
//
//-(void)weekendBtnPress{
//    if ([currentVC isKindOfClass:[TPFreeTravelingViewController class]]) {
//        
//    }else if([currentVC isKindOfClass:[HomeViewController class]]){
//        TPFreeTravelingViewController * freeTraveling = [[TPFreeTravelingViewController alloc]init];
//        [currentVC.navigationController pushViewController:freeTraveling animated:YES];
//    }else{
//        [currentVC.navigationController popViewControllerAnimated:YES];
//        NSArray * viewControllers = currentVC.navigationController.viewControllers;
//        UIViewController * topVC = viewControllers[viewControllers.count-1];
//        TPFreeTravelingViewController *freeTraveling = [[TPFreeTravelingViewController alloc]init];
//        [topVC.navigationController pushViewController:freeTraveling animated:YES];
//    }
//    
////    TPFreeTravelingViewController * freeTraveling = [[TPFreeTravelingViewController alloc]init];
////    [currentVC.navigationController pushViewController:freeTraveling animated:YES];
//}
//
//-(void)destinationClick{
//    if ([currentVC isKindOfClass:[DestinationRootVC class]]) {
//        
//    }else if([currentVC isKindOfClass:[HomeViewController class]]){
//        DestinationRootVC *destinationRoot = [[DestinationRootVC alloc]init];
//        [currentVC.navigationController pushViewController:destinationRoot animated:YES];
//    }else{
//        [currentVC.navigationController popViewControllerAnimated:YES];
//        NSArray * viewControllers = currentVC.navigationController.viewControllers;
//        UIViewController * topVC = viewControllers[viewControllers.count-1];
//        DestinationRootVC *destinationRoot = [[DestinationRootVC alloc]init];
//        [topVC.navigationController pushViewController:destinationRoot animated:YES];
//    }
//    
////    DestinationRootVC *destinationRoot = [[DestinationRootVC alloc]init];
////    [currentVC.navigationController pushViewController:destinationRoot animated:YES];
//
//}
//
//-(void)mineBtnPress{
//    [TPLoginMaster executionWithCurrentVC:currentVC andBlock:^(BOOL LoginState) {
//        if (LoginState) {
//            LJPersonalTableViewController *personal = [[LJPersonalTableViewController alloc] init];
//            [currentVC.navigationController pushViewController:personal animated:YES];
//        }
//    }];
//}

@end
