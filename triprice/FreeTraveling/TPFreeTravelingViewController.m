//
//  TPFreeTravelingViewController.m
//  triprice
//
//  Created by caobo56 on 16/3/6.
//
//

#import "TPFreeTravelingViewController.h"
#import "TPHomeBottomView.h"
#import "TPFreeTavelingDetailViewController.h"
#import "TPFreeTravelingCell.h"


@interface TPFreeTravelingViewController()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation TPFreeTravelingViewController{
    NSArray * dataArr;
    UITableView * freeTravelingTableView;
    NSInteger page;
    UIView * footerView;
    TPHomeBottomView * bottomView;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        page = 0;
        [self initUI];
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TabVC bottomView].hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
//    bottomView = [[TPHomeBottomView alloc]init];
//    [bottomView setCurrentVC:self];
    
    freeTravelingTableView = [[UITableView alloc]init];
    freeTravelingTableView.size = CGSizeMake(Screen_weight, Screen_height+20);
    freeTravelingTableView.origin = CGPointMake(0,-20);
    freeTravelingTableView.backgroundColor = [UIColor redColor];
    freeTravelingTableView.backgroundColor = [UIColor whiteColor];
    freeTravelingTableView.delegate = self;
    freeTravelingTableView.dataSource = self;
    [self.view addSubview:freeTravelingTableView];
    [self.view addSubview:bottomView];

    footerView = [[UIView alloc]init];
    footerView.size = CGSizeMake(Screen_weight, 50);
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel * footerLable = [[UILabel alloc]init];
    footerLable.size = CGSizeMake(Screen_weight, 50);
    footerLable.top = footerView.top;
    footerLable.textAlignment = NSTextAlignmentCenter;
    footerLable.text = @"已加载完毕";
    footerLable.font = [UIFont systemFontOfSize:12.0f];
    [footerView addSubview:footerLable];
    
    // 下拉刷新
    freeTravelingTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getSpecialSearchAllWithRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    freeTravelingTableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    freeTravelingTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getSpecialSearchAllNextPageWithRefreshing];
    }];


}

#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH-rateLangth(10);
}

-(UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *destinationMoreCellIdentifier = @"DestinationMoreCell";
    TPFreeTravelingCell *cell = (TPFreeTravelingCell *)[tableViews dequeueReusableCellWithIdentifier:destinationMoreCellIdentifier];
    if (cell == nil) {
        cell = [[TPFreeTravelingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:destinationMoreCellIdentifier];
        [cell createView];
    }
    [cell setWithDic:dataArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TPFreeTavelingDetailViewController * detailVC = [[TPFreeTavelingDetailViewController alloc]init];
    [detailVC setFreeTavelingID:[dataArr[indexPath.row] objectForKeyNotNull:@"id"]];
    [TabVC bottomView].hidden = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark 网络请求
-(void)loadData{
    freeTravelingTableView.hidden = YES;
    [self showLoadingHUDWithText:nil];
    __block TPFreeTravelingViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs]specialSearchAllWithParameters:dict WithBlock:^(NSDictionary *dic, NSString *error) {
        freeTravelingTableView.hidden = NO;
        [self hideAllHUD];
        NSDictionary * pager = [dic objectForKeyNotNull:@"pager"];
        NSNumber * hasNexPage = [pager objectForKeyNotNull:@"pager"];
        if (hasNexPage == 0) {
            freeTravelingTableView.tableFooterView = footerView;
        }
        if (dic) {
            dataArr = [dic objectForKeyNotNull:@"datas"];
            [freeTravelingTableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }

    }];
    
}


-(void)getSpecialSearchAllWithRefreshing{
    __block TPFreeTravelingViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] specialSearchAllWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [freeTravelingTableView.mj_header endRefreshing];
            dataArr = [dict objectForKeyNotNull:@"datas"];
            [freeTravelingTableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

-(void)getSpecialSearchAllNextPageWithRefreshing{
    __block TPFreeTravelingViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] specialSearchAllWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [freeTravelingTableView.mj_footer endRefreshing];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                freeTravelingTableView.tableFooterView = footerView;
            }else{
                page++;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:dataArr copyItems:YES];
                [arr addObjectsFromArray:data];
                dataArr = arr;
                [freeTravelingTableView reloadData];
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



















