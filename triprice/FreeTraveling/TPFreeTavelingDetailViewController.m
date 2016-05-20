//
//  TPFreeTavelingDetailViewController.m
//  triprice
//
//  Created by caobo56 on 16/3/6.
//
//

#import "TPFreeTavelingDetailViewController.h"
#import "TPWeekRecommendTopView.h"
#import "TPTravelingHeadView.h"
#import "TPTRavelingFootView.h"
#import "TPTravelingSectionHeadView.h"
#import "TPFreeTravelingDetailCell.h"
#import "TPFreeTravelingAddViewController.h"

#import "TPLoginMaster.h"


@interface TPFreeTavelingDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TPFreeTavelingDetailViewController{
    NSString * freeTavelingID;
    NSDictionary * detailDict;
    NSArray * daysArr;
    
    UITableView * freeTavelingDetailTableView;
    TPTravelingHeadView * headView;
    TPTRavelingFootView * footView;
    UILabel * priceLable;
    UIView * bottomView;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)setFreeTavelingID:(NSString *)dict{
    freeTavelingID = dict;
}

-(void)hiddenBottomBar{
    bottomView.hidden = YES;
}


-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self searchSpecialById];
    [self searchScheduleBySpecialId];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:@"自由行详情"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];

    
    freeTavelingDetailTableView  = [[UITableView alloc]init];
    freeTavelingDetailTableView.size  =CGSizeMake(Screen_weight, Screen_height-NavBarH-StateBarH);
    freeTavelingDetailTableView.top = topView.bottom;
    freeTavelingDetailTableView.centerX = Screen_weight/2;
    [self.view addSubview:freeTavelingDetailTableView];
    freeTavelingDetailTableView.delegate = self;
    freeTavelingDetailTableView.dataSource = self;
    freeTavelingDetailTableView.separatorStyle = NO;
    headView = [[TPTravelingHeadView alloc]init];
    footView = [[TPTRavelingFootView alloc]init];

    bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = HexRGBAlpha(0xECDECB, 0.6);
    bottomView.size = CGSizeMake(Screen_weight, TabBarH);
    bottomView.bottom = self.view.height;
    [self.view addSubview:bottomView];
    
    UIButton *_reservationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reservationBtn.size = CGSizeMake(72, 33);
    _reservationBtn.left = Screen_weight-_reservationBtn.width-10;
    _reservationBtn.centerY = bottomView.height/2;
    [[_reservationBtn layer]setCornerRadius:3.0];//圆角
    _reservationBtn.backgroundColor = HexRGBAlpha(0xEDF7FF, 1.0);
    [_reservationBtn setTitle:@" 预 订 " forState:UIControlStateNormal];
    [_reservationBtn setTitleColor:HexRGBAlpha(0x1e83fb, 1.0) forState:UIControlStateNormal];
    _reservationBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_reservationBtn addTarget:self action:@selector(reservationBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_reservationBtn];
    
    priceLable = [[UILabel alloc]init];
    priceLable.size = CGSizeMake(80, 30);
    priceLable.left = 10;
    priceLable.centerY = bottomView.height/2;
    priceLable.textAlignment = NSTextAlignmentLeft;
    priceLable.textColor = HexRGBAlpha(0xFF7F05, 1.0);
    priceLable.font = [UIFont systemFontOfSize:16.0f];
    [bottomView addSubview:priceLable];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reservationBtnPress{
    [TPLoginMaster executionWithCurrentVC:self andBlock:^(BOOL LoginState) {
        if (LoginState) {
            TPFreeTravelingAddViewController * freeTravelingAdd =[[TPFreeTravelingAddViewController alloc]init];
            [freeTravelingAdd setFreeTravelingDict:detailDict];
            [self.navigationController pushViewController:freeTravelingAdd animated:YES];
        }
    }];
}

#pragma mark tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return daysArr.count;
}

-(NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = (NSArray *)[daysArr[section] objectForKeyNotNull:@"list"];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arr = (NSArray *)[daysArr[indexPath.section] objectForKeyNotNull:@"list"];
    return [TPFreeTravelingDetailCell getDetailCellHeightWith:arr[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *freeTavelingDetailCellIdentifier = @"freeTavelingDetailCell";
    TPFreeTravelingDetailCell *cell = (TPFreeTravelingDetailCell *)[tableViews dequeueReusableCellWithIdentifier:freeTavelingDetailCellIdentifier];
    if (cell == nil) {
        cell = [[TPFreeTravelingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:freeTavelingDetailCellIdentifier];
        [cell initUI];
    }
    NSArray * arr = (NSArray *)[daysArr[indexPath.section] objectForKeyNotNull:@"list"];
    [cell loadDataWithDict:arr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ((Screen_weight-40)/2/23*12+30);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     static NSString *freeTavelingSectionCellIdentifier = @"freeTavelingSectionCell";
    TPTravelingSectionHeadView *cell = (TPTravelingSectionHeadView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:freeTavelingSectionCellIdentifier];
    if (cell == nil) {
        cell = [[TPTravelingSectionHeadView alloc]initWithReuseIdentifier:freeTavelingSectionCellIdentifier];
        [cell initUI];
    }
    [cell loadDataWithDict:daysArr[section]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = ((Screen_weight-40)/2/23*12+30);
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark 网络请求
-(void)searchSpecialById{
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:freeTavelingID forKey:@"id"];

    __block TPFreeTavelingDetailViewController *blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]searchSpecialByIdWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [blkSelf hideAllHUD];
        if (dict) {
            detailDict = [dict objectForKeyNotNull:@"datas"];
            [headView loadDataWithDict:detailDict];
            [footView loadDataWithDict:detailDict];
            freeTavelingDetailTableView.tableFooterView = footView;
            freeTavelingDetailTableView.tableHeaderView = headView;
            [freeTavelingDetailTableView reloadData];
            priceLable.text = [NSString stringWithFormat:@"¥ %@/人",[detailDict objectForKeyNotNull:@"price"]];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}


-(void)searchScheduleBySpecialId{
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:freeTavelingID forKey:@"id"];
    __block TPFreeTavelingDetailViewController *blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]searchScheduleBySpecialIdWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [blkSelf hideAllHUD];
        if (dict) {
            daysArr = [dict objectForKeyNotNull:@"datas"];
            [freeTavelingDetailTableView reloadData];
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
