//
//  DDOtherView.m
//  triprice
//
//  Created by MZY on 16/2/23.
//
//

#import "DDOtherView.h"
#import "DDOtherCell.h"
#import "DestinationOtherDetailVC.h"

@interface DDOtherView ()<UITableViewDataSource,UITableViewDelegate>{
    UIView *footerView;
    NSInteger  page;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation DDOtherView

-(void)createView{
    _tableView = [[UITableView alloc]initWithFrame:self.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];

    footerView = [[UIView alloc]init];
    footerView.size = CGSizeMake(Screen_weight, 50);
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel * footerLable = [[UILabel alloc]init];
    footerLable.size = footerView.size;
    footerLable.textAlignment = NSTextAlignmentCenter;
    footerLable.text = @"已加载完毕";
    footerLable.font = [UIFont systemFontOfSize:12.0f];
    [footerView addSubview:footerLable];

    if (_viewState) {
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 0;
            [self getRequest];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        // 上拉刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getRequest];
        }];
    }
}

-(id)initWithFrame:(CGRect)frame withViewState:(OtherViewState)viewState withDic:(NSDictionary *)dic{
    self = [super initWithFrame:frame];
    if (self) {
        _viewState = viewState;
        _infoDic = [[NSDictionary alloc]initWithDictionary:dic];
        [self createView];
        [self getRequest];
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rateLangth(168)+85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DDOtherCell";

    DDOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[DDOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    cell.hasMoney = !(_viewState == Meijing);

    [cell setWithDic:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_otherAction) {
        _otherAction(_dataArray[indexPath.row]);
    }
}


-(void)getRequest{

    __block DDOtherView *blkSelf = self;

    NSArray *array = @[@"destination/searchTouristItemByCity.do",@"destination/searchFoodByCity.do",@"destination/searchHotelByCity.do",@"destination/searchGoodsByCity.do"];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    if (_viewState) {
        [dict setValue:_infoDic[@"code"] forKey:@"id"];
        [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
        [dict setValue:@"15" forKey:@"pager.pageSize"];
    }else{
        [dict setValue:_infoDic[@"code"] forKey:@"code"];
    }

    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:array[_viewState]] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {

        if (!_viewState) {
            _dataArray = [dict objectForKeyNotNull:@"datas"];
            [_tableView reloadData];
            return ;
        }
        [self endRefresh];
        if (dict) {
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

-(void)endRefresh{
    [_tableView.mj_footer endRefreshing];
    [_tableView.mj_header endRefreshing];
}

- (void)showHUDWithText:(NSString*)str
{
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    HUD.indicatorView = nil;
    HUD.userInteractionEnabled = YES;
    HUD.textLabel.text = NSLocalizedString(str, nil);
    HUD.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.marginInsets = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = [UIScreen mainScreen].bounds.size.height/2,
        .left = 0.0f,
        .right = 0.0f,
    };
    [HUD showInView:self];
    [HUD dismissAfterDelay:0.8f];
}


@end
