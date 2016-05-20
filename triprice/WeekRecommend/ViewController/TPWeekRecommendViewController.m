//
//  TPWeekRecommendViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/15.
//
//

#import "TPWeekRecommendViewController.h"
#import "TPWeekRecommendDetailViewController.h"
#import "TPWeekRecommendTopView.h"

#import <QuartzCore/QuartzCore.h>


@interface WeekRecommendCell : UITableViewCell


-(void)loadData:(NSDictionary *)dict;

@end

@implementation WeekRecommendCell{
    UIImageView * bgView;
    UILabel * nameLable;
    UILabel * descLable;
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.size = CGSizeMake(Screen_weight, cellH);
    bgView = [[UIImageView alloc]init];
    bgView.size = CGSizeMake(Screen_weight, cellH-rateLangth(10));
    bgView.layer.masksToBounds = YES;
    [[bgView layer]setCornerRadius:5.0];//圆角
    bgView.bottom = self.height;
    [self addSubview:bgView];
    
    descLable = [[UILabel alloc]init];
    descLable.size = CGSizeMake(Screen_weight-20, 30);
    descLable.bottom = self.height;
    descLable.centerX = Screen_weight/2;
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.textColor = [UIColor whiteColor];
    descLable.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:descLable];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.size = CGSizeMake(Screen_weight-20, 1);
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.bottom = descLable.top;
    lineView.centerX = Screen_weight/2;
    lineView.alpha = 0.4;
    [self addSubview:lineView];
    
    nameLable = [[UILabel alloc]init];
    nameLable.size = CGSizeMake(Screen_weight-20, 45);
    nameLable.bottom = lineView.top;
    nameLable.centerX = Screen_weight/2;
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:nameLable];
}

-(void)loadData:(NSDictionary *)dict{
    nameLable.text = [dict objectForKeyNotNull:@"name"];
    descLable.text = [dict objectForKeyNotNull:@"out_line"];
    [bgView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
}

@end



@interface TPWeekRecommendViewController()<UITableViewDelegate,UITableViewDataSource>


@end


@implementation TPWeekRecommendViewController{
    NSArray * dataArr;
    UITableView * weekRecommendTableView;
    NSInteger page;
    UIView * footerView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        page = 0;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self getRecommendSearchAll];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"首页"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    weekRecommendTableView = [[UITableView alloc]init];
    weekRecommendTableView.size = CGSizeMake(Screen_weight, Screen_height-topView.height);
    weekRecommendTableView.origin = CGPointMake(0, topView.bottom);
    weekRecommendTableView.backgroundColor = [UIColor whiteColor];
    weekRecommendTableView.delegate = self;
    weekRecommendTableView.dataSource = self;
    [self.view addSubview:weekRecommendTableView];
    
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
    weekRecommendTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getRecommendSearchAllWithRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    weekRecommendTableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    weekRecommendTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getRecommendSearchNextPageWithRefreshing];
    }];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *weekRecommendIdentifier = @"weekRecommend";
    WeekRecommendCell *cell = (WeekRecommendCell *)[tableViews dequeueReusableCellWithIdentifier:weekRecommendIdentifier];
    if (cell == nil) {
        cell = [[WeekRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weekRecommendIdentifier];
        [cell initUI];
    }
    [cell loadData:dataArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TPWeekRecommendDetailViewController * detailVC = [[TPWeekRecommendDetailViewController alloc]init];
    [detailVC setRecommendId:[dataArr[indexPath.row] objectForKeyNotNull:@"id"]];
    [detailVC setRecommendData:(NSDictionary *)dataArr[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark network_Data
//数据请求
-(void)getRecommendSearchAll{
    weekRecommendTableView.hidden = YES;
    [self showLoadingHUDWithText:nil];
    __block TPWeekRecommendViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] getRecommendSearchAllWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        weekRecommendTableView.hidden = NO;
        [self hideAllHUD];
        NSDictionary * pager = [dict objectForKeyNotNull:@"pager"];
        NSNumber * hasNexPage = [pager objectForKeyNotNull:@"pager"];
        if (hasNexPage == 0) {
            weekRecommendTableView.tableFooterView = footerView;
        }
        if (dict) {
            dataArr = [dict objectForKeyNotNull:@"datas"];
            [weekRecommendTableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

-(void)getRecommendSearchAllWithRefreshing{
    __block TPWeekRecommendViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] getRecommendSearchAllWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [weekRecommendTableView.mj_header endRefreshing];
            dataArr = [dict objectForKeyNotNull:@"datas"];
            [weekRecommendTableView reloadData];
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
    __block TPWeekRecommendViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] getRecommendSearchAllWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [weekRecommendTableView.mj_footer endRefreshing];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                weekRecommendTableView.tableFooterView = footerView;
            }else{
                page++;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:dataArr copyItems:YES];
                [arr addObjectsFromArray:data];
                dataArr = arr;
                [weekRecommendTableView reloadData];
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
