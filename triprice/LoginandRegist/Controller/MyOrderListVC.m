//
//  MyOrderListVC.m
//  triprice
//
//  Created by MZY on 16/3/15.
//
//

#import "MyOrderListVC.h"
#import "TPWeekRecommendTopView.h"
#import "OrderListCell.h"
#import "DestinationAddCommentVC.h"

#import "TPFreeTavelingDetailViewController.h"
#import "TPReservationProductDetailViewController.h"



@interface MyOrderListVC ()<UITableViewDataSource,UITableViewDelegate>{
    UIView *footerView;
    NSInteger page;
}
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation MyOrderListVC


-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:@"订单列表"];
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
    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    _tableView.mj_header.automaticallyChangeAlpha = YES;
//    // 上拉刷新
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [self getOrderList];
//    }];
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
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyOrderListVC * __weak weakSelf = self;

    static NSString *cellIdentifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setInfoWithDic:_dataArray[indexPath.row]];
    cell.action = ^(NSDictionary *dic){
        [weakSelf gotoCommentVCWithDic:dic];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = _dataArray[indexPath.row];
    if ([[dic objectForKeyNotNull:@"category"] intValue] == 2) {

        TPFreeTavelingDetailViewController *tp = [[TPFreeTavelingDetailViewController alloc]init];
        [tp setFreeTavelingID:dic[@"product_id"]];
        [tp hiddenBottomBar];
        [self.navigationController pushViewController:tp animated:YES];
    }else{
        TPReservationProductDetailViewController *tp = [[TPReservationProductDetailViewController alloc]init];
        [tp setProductId:dic[@"product_id"]];
        [tp hiddenBottomBar];
        [self.navigationController pushViewController:tp animated:YES];
    }
}

-(void)gotoCommentVCWithDic:(NSDictionary *)dic{
    DestinationAddCommentVC *addComment = [[DestinationAddCommentVC alloc]init];
    addComment.infoDic = [[NSDictionary alloc]initWithDictionary:dic];
    addComment.viewTpye = DestinationAddCommentView;
    [self.navigationController pushViewController:addComment animated:YES];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getOrderList{
    MTUser *user = [YYAccountTool account];
    __block MyOrderListVC *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [dict setValue:user.userId forKey:@"id"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"booking/searchMyOrder.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
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
