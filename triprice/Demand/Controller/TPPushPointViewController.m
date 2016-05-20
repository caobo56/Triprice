//
//  TPPushPointViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/25.
//
//

#import "TPPushPointViewController.h"
#import "TPPushCityViewController.h"
#import "TPPushDemandViewController.h"

#import "TPPushDemandTopView.h"
#import "TPPointleftTableView.h"
#import "TPPointRightTableView.h"



@interface TPPushPointViewController()<TPPointleftTableViewSelectDelegate,TPPointRightTableViewSelectDelegate>

@end

@implementation TPPushPointViewController{
    NSArray * countryArr;
    NSArray * cityArr;

    TPPointleftTableView * leftTableView;
    TPPointRightTableView * rightTableView;
    NSInteger  countryIndex;
    NSInteger  cityIndex;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        countryIndex = 0;
        cityIndex = nullCode;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self searchDestinationCountry];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    TPPushDemandTopView * topView = [[TPPushDemandTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setRightTitle:@"下一步"];
    [topView setTitle:@"目的地"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    leftTableView = [[TPPointleftTableView alloc]init];
    leftTableView.selectDelegate = self;
    [self.view addSubview:leftTableView];
    
    rightTableView = [[TPPointRightTableView alloc]init];
    rightTableView.selectDelegate = self;
    [self.view addSubview:rightTableView];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPress{//下一步
    if (![self judgeParameter]) {
        return;
    }
    TPPushCityViewController * pushCity = [[TPPushCityViewController alloc]init];
    [pushCity setCityDict:cityArr[cityIndex]];
    [self.navigationController pushViewController:pushCity animated:YES];
    
}

-(BOOL)judgeParameter{
    if (cityIndex == nullCode) {
        [self showHUDWithText:@"请选择城市"];
        return NO;
    }
    return YES;
}


-(void)pointleftTableViewSelectIndex:(NSInteger)index{
    countryIndex = index;
    [self searchDestinationCity];
}

-(void)pointRightTableViewSelectIndex:(NSInteger)index{
    cityIndex = index;
    
    NSArray * vcArr = self.navigationController.viewControllers;
    TPPushDemandViewController * demandVC = (TPPushDemandViewController *)vcArr[vcArr.count-2];
    [demandVC setCityDict:cityArr[index]];
}

-(void)searchDestinationCountry{
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(0) forKey:@"pager.pageNum"];
    __block TPPushPointViewController * blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]searchDestinationCountryWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [blkSelf hideAllHUD];
        if (dict) {
            countryArr = [dict objectForKeyNotNull:@"datas"];
            [leftTableView loadData:countryArr];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

-(void)searchDestinationCity{
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(0) forKey:@"pager.pageNum"];
    [dic setValue:[countryArr[countryIndex] objectForKeyNotNull:@"code"] forKey:@"code"];

    __block TPPushPointViewController * blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]searchDestinationCityWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [blkSelf hideAllHUD];
        
        if (dict) {
            cityArr = [dict objectForKeyNotNull:@"datas"];
            cityIndex = nullCode;
            [rightTableView loadData:cityArr];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}


@end
