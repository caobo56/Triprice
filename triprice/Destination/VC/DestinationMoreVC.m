//
//  DestinationMoreVC.m
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import "DestinationMoreVC.h"
#import "TPWeekRecommendTopView.h"
#import "DestinationMoreCell.h"
#import "TPReservationProductDetailViewController.h"
@interface DestinationMoreVC ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *footerView;
    NSInteger page;
}

@property (strong, nonatomic)     UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation DestinationMoreVC

-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:self.title];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];

    _tableView = [[UITableView alloc]init];
    _tableView.size = CGSizeMake(Screen_weight, Screen_height-topView.height);
    _tableView.origin = CGPointMake(0, topView.bottom);
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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

    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self getRecommendSearchAllWithRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getRecommendSearchNextPageWithRefreshing];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    page = 0;
    [self getRecommendSearchAllWithRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}



#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DestinationMoreCell";

    DestinationMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[DestinationMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setWithDic:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPReservationProductDetailViewController * productDetailVC = [[TPReservationProductDetailViewController alloc]init];
    [productDetailVC setProductId:[_dataArray[indexPath.row] objectForKeyNotNull:@"id"]];
    [productDetailVC setProductData:_dataArray[indexPath.row]];
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getRecommendSearchAllWithRefreshing{
    __block DestinationMoreVC *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
    [dict setValue:_infoDic[@"code"] forKey:@"code"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"destination/searchProject.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            [_tableView.mj_header endRefreshing];
            _dataArray = [dict objectForKeyNotNull:@"datas"];
            [_tableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

-(void)getRecommendSearchNextPageWithRefreshing{
    __block DestinationMoreVC *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [dict setValue:_infoDic[@"code"] forKey:@"code"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"destination/searchProject.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            [_tableView.mj_footer endRefreshing];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                _tableView.tableFooterView = footerView;
            }else{
                page++;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_dataArray copyItems:YES];
                [arr addObjectsFromArray:data];
                _dataArray = arr;
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
