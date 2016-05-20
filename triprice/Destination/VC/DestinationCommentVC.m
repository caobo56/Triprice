//
//  DestinationCommentVC.m
//  triprice
//
//  Created by MZY on 16/2/24.
//
//

#import "DestinationCommentVC.h"
#import "TPWeekRecommendTopView.h"
#import "DestinationCommentCell.h"
#import "TPLoginMaster.h"
#import "DestinationAddCommentVC.h"

@interface DestinationCommentVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger page;
    UIView *footerView;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *commentArray;

@end

@implementation DestinationCommentVC

-(void)createView{

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView setTitle:@"评论"];
    [self.view addSubview:topView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 22, 80, topView.height-22);
    [btn setTitle:@"添加评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.right = Screen_weight - 20;
    [btn addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];

    _tableView = [[UITableView alloc]init];
    _tableView.size = CGSizeMake(Screen_weight, Screen_height-topView.height);
    _tableView.origin = CGPointMake(0, topView.bottom);
    _tableView.backgroundColor = [UIColor whiteColor];
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

    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self getComment];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getComment];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    page = 0;
    [self getComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_commentArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45+ [DestinationCommentCell getHeightCellWithString:_commentArray[indexPath.row][@"comment"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"DestinationCommentCell";

    DestinationCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[DestinationCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setWithDic:_commentArray[indexPath.row] withIsFirst:NO];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(void)addComment{

    DestinationCommentVC *__weak weakSelf = self;

    if([TPLoginMaster isLogin]){
        DestinationAddCommentVC *addComment = [[DestinationAddCommentVC alloc]init];
        addComment.infoDic = weakSelf.infoDic;
        addComment.viewTpye = DestinationAddCommentView;
        [weakSelf.navigationController pushViewController:addComment animated:YES];
    }else{
        [TPLoginMaster executionWithCurrentVC:self andBlock:^(BOOL LoginState) {
            if (LoginState) {
                DestinationAddCommentVC *addComment = [[DestinationAddCommentVC alloc]init];
                addComment.infoDic = weakSelf.infoDic;
                addComment.viewTpye = DestinationAddCommentView;
                [weakSelf.navigationController pushViewController:addComment animated:YES];
            }
        }];
    }
    
}

-(void)endRefresh{
    [_tableView.mj_footer endRefreshing];
    [_tableView.mj_header endRefreshing];
}

-(void)getComment{

    DestinationCommentVC *__weak blkSelf = self;

    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:_infoDic[@"id"] forKey:@"id"];
    [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
    [dict setValue:@"15" forKey:@"pager.pageSize"];

    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"destination/searchTouristComment.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            [self endRefresh];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                _tableView.tableFooterView = footerView;
            }else{
                page++;

                if (page == 1) {
                    [_commentArray removeAllObjects];
                }

                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_commentArray copyItems:YES];
                [arr addObjectsFromArray:data];
                _commentArray = arr;
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
