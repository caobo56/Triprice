//
//  MyNeedListVC.m
//  triprice
//
//  Created by MZY on 16/3/15.
//
//

#import "MyNeedListVC.h"
#import "TPWeekRecommendTopView.h"
#import "NeedListCell.h"
#import "MyNeedDetailVC.h"

@interface MyNeedListVC ()<UITableViewDataSource,UITableViewDelegate>{
    UIView *footerView;
    NSInteger page;
}
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation MyNeedListVC


-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:@"我的需求"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];

    _tableView = [[UITableView alloc]init];
    _tableView.size = CGSizeMake(Screen_weight, Screen_height-topView.height);
    _tableView.origin = CGPointMake(0, topView.bottom);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    footerView = [[UIView alloc]init];
    footerView.size = CGSizeMake(Screen_weight, 50);
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel * footerLable = [[UILabel alloc]init];
    footerLable.size = footerView.size;
    footerLable.textAlignment = NSTextAlignmentCenter;
    footerLable.text = @"已加载完毕";
    footerLable.font = [UIFont systemFontOfSize:12.0f];
    [footerView addSubview:footerLable];
    [self getOrderList];
    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self getOrderList];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 236;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"NeedListCell";

    NeedListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[NeedListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setInfoWithDic:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MyNeedDetailVC *needDetail = [[MyNeedDetailVC alloc]init];
    needDetail.infoDic = _dataArray[indexPath.row];
    [self.navigationController pushViewController:needDetail animated:YES];

}


-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getOrderList{
    MTUser *user = [YYAccountTool account];
    __block MyNeedListVC *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:user.userId forKey:@"id"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"require/searchMyRequire.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            [_tableView.mj_header endRefreshing];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                _tableView.tableFooterView = footerView;
            }else{
                [_dataArray removeAllObjects];
                [_dataArray addObjectsFromArray:data];
                [_tableView reloadData];
            }
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
