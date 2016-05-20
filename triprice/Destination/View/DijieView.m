//
//  dijieView.m
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import "dijieView.h"
#import "DijieCell.h"



@interface DijieView ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *footerView;
    NSInteger page;
}

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation DijieView

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

    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self getRefreshRequest];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getNextRequest];
    }];
}

-(id)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        page = 0;
        _infoDic = dic;
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
        [self getRefreshRequest];
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
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DijieCell";

    DijieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[DijieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setWithDic:_dataArray[indexPath.row]];
    cell.callAction = ^(NSDictionary *dic){
        if (_callAction) {
            _callAction(dic);
        }
    };
    cell.commentAction = ^(NSDictionary *dic){
        if (_commentAction) {
            _commentAction(dic);
        };
    };
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(void)getRefreshRequest{
    __block DijieView *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
    [dict setValue:_infoDic[@"code"] forKey:@"code"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"guider/searchAll.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
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

-(void)getNextRequest{
    __block DijieView *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [dict setValue:_infoDic[@"code"] forKey:@"code"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"guider/searchAll.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
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
