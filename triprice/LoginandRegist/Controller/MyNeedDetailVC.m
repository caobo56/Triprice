//
//  MyNeedDetailVC.m
//  triprice
//
//  Created by MZY on 16/3/16.
//
//

#import "MyNeedDetailVC.h"
#import "TPWeekRecommendTopView.h"
#import "NeedDetailCell.h"
#import "TPSolutionDetailViewController.h"

@interface MyNeedDetailVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger page;
    UIView *footerView;
}

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation MyNeedDetailVC

-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:@"已推荐"];
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
    page = 0;
    [self getRequest];
    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self getRequest];
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getRequest];
    }];


    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"NeedDetailCell";

    NeedDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[NeedDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setInfoWithDic:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArray[indexPath.row];
    TPSolutionDetailViewController *tp = [[TPSolutionDetailViewController alloc]init];
    [tp setSolutionID:dic[@"id"]];
    [self.navigationController pushViewController:tp animated:YES];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getRequest{

    __block MyNeedDetailVC *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:_infoDic[@"requireId"] forKey:@"require.requireId"];
    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [dict setValue:[NSString stringWithFormat:@"%d",15] forKey:@"pager.pageSize"];


    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"solution/searchSolutionByRequireId.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                _tableView.tableFooterView = footerView;
            }else{
                if (page == 0) {
                    [_dataArray removeAllObjects];
                }
                [_dataArray addObjectsFromArray:data];
                page++;
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
