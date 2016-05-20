//
//  DestinationRootVC.m
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import "DestinationRootVC.h"
#import "DestinationRootCell.h"
#import "TPHomeBottomView.h"
#import "DestinationDescripVC.h"

@interface DestinationRootVC ()<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *infoArray;
@end

@implementation DestinationRootVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self createView];
        _infoArray = [[NSMutableArray alloc]initWithCapacity:0];
        [self getRequest];
    }
    return self;
}

-(void)createView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -22, Screen_weight, Screen_height+22)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];


    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getRequest];
    }];


}

//-(void)homeBtnPress{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self getRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TabVC bottomView].hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_infoArray count]+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == [_infoArray count]) {
        return 44;
    }else{
        return rateLangth(167);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([_infoArray count] == indexPath.row) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        UILabel *label = [UILabel createWithFrame:CGRectMake(0, 0, Screen_weight, 44) withFont:15 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor blueColor]];
        label.text = @"更多目的地即将上线";
        [cell addSubview:label];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *cellIdentifier = @"DestinationRootCell";
        DestinationRootCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[DestinationRootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell createView];
        }
        [cell setWithDic:_infoArray[indexPath.row]];
        return cell;
    }
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == [_infoArray count]) {
        return;
    }
    DestinationDescripVC *desc = [[DestinationDescripVC alloc]init];
    NSDictionary *dic = _infoArray[indexPath.row];
    if ([dic objectForKeyNotNull:@"name"]) {
        desc.title = dic[@"name"];
    }else{
        desc.title = @"";
    }
    desc.infoDic = dic;
    [TabVC bottomView].hidden = YES;
    [self.navigationController pushViewController:desc animated:YES];
}

-(void)getRequest{
    DestinationRootVC * __weak weakSelf = self;

    [[JDDAPIs sharedJDDAPIs] postUrl:@"http://triprice.cn/triprice/destination/searchHot.do" withParameters:nil callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {

            [_tableView.mj_header endRefreshing];
            if ([dict[@"isSuccess"] intValue]) {
                if ([dict[@"datas"] count]) {
                    [_infoArray removeAllObjects];
                    [_infoArray addObjectsFromArray:dict[@"datas"]];
                    [_tableView reloadData];
                }
            }
        }else{
            if (error) {
                [weakSelf showHUDWithText:error];
            } else {
                [weakSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}


@end
