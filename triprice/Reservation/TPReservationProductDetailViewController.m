//
//  TPReservationProductDetailViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/18.
//
//

#import "TPReservationProductDetailViewController.h"

#import "TPWeekRecommendTopView.h"
#import "TPWeekRecomendHeadView.h"
#import "TPReservationFooterView.h"
#import "TPLoginMaster.h"
#import "TPReservationProductPushViewController.h"


#import "TPCustomTool.h"


@interface ProductCell : UITableViewCell


-(void)loadData:(NSDictionary *)dict;

@end

@implementation ProductCell{
    UIImageView * bgView;
    
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
    bgView.size = CGSizeMake(Screen_weight-20, cellH-20);
    bgView.centerX = Screen_weight/2;
    bgView.bottom = self.height;
    [self addSubview:bgView];
}

-(void)loadData:(NSDictionary *)dict{
    [bgView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
}

@end

@interface TPReservationProductDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TPReservationProductDetailViewController{
    NSString *productId;
    NSDictionary * productDict;
    NSArray * dataArr;
    
    UITableView * recommendTableView;
    UIView * footerView;
    TPReservationFooterView * footsView;
    TPWeekRecommendTopView * topView;
    TPWeekRecomendHeadView * headViews;
    
    BOOL bottomBarHidden;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        bottomBarHidden = NO;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    if (!productDict) {
        [self getProductDetail];
    }
    [self getProductDetailList];
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


-(void)setProductId:(NSString *)RecommendId{
    productId = RecommendId;
}

-(void)hiddenBottomBar{
    bottomBarHidden = YES;
}


-(void)setProductData:(NSDictionary *)recommendData{
    productDict = recommendData;
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    topView = [[TPWeekRecommendTopView alloc]init];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView setTitle:[productDict objectForKeyNotNull:@"name"]];
    [self.view addSubview:topView];
    
    headViews = [[TPWeekRecomendHeadView alloc]init];
    [headViews setHeadData:productDict];
    
    footsView = [[TPReservationFooterView alloc]init];
    footsView.bottom = Screen_height;
    [footsView setPrice:[productDict objectForKeyNotNull:@"price"]];
    [footsView.reservationBtn addTarget:self action:@selector(reservationBtnPress) forControlEvents:UIControlEventTouchUpInside];
    footsView.hidden = bottomBarHidden;
    
    recommendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topView.bottom, Screen_weight, Screen_height-NavBarH-StateBarH) style:UITableViewStyleGrouped];
    recommendTableView.size = CGSizeMake(Screen_weight, Screen_height-NavBarH-StateBarH);
    recommendTableView.backgroundColor = [UIColor redColor];
    recommendTableView.origin = CGPointMake(0, topView.bottom);
    recommendTableView.tableHeaderView = headViews;
    recommendTableView.delegate = self;
    recommendTableView.dataSource = self;
    recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    recommendTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:recommendTableView];
    [self.view addSubview:footsView];

    
    footerView = [[UIView alloc]init];
    footerView.size = CGSizeMake(Screen_weight, TabBarH);
    footerView.backgroundColor = [UIColor whiteColor];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reservationBtnPress{
 [TPLoginMaster executionWithCurrentVC:self andBlock:^(BOOL LoginState) {
     if (LoginState) {
         TPReservationProductPushViewController * pushVC = [[TPReservationProductPushViewController alloc]init];
         [pushVC setPushId:productId];
         [pushVC setPushData:productDict];
         [self.navigationController pushViewController:pushVC animated:YES];
     }
 }];
}

#pragma mark tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = dataArr[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *recommendIdentifier = @"recommend";
    ProductCell *cell = (ProductCell *)[tableViews dequeueReusableCellWithIdentifier:recommendIdentifier];
    if (cell == nil) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendIdentifier];
        [cell initUI];
    }
    
    NSArray * arr = dataArr[indexPath.section];
    [cell loadData:arr[indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]init];
    headView.size = CGSizeMake(Screen_weight, 50);
    UIView * middleLine = [[UIView alloc]init];
    middleLine.size = CGSizeMake(Screen_weight-20, 1);
    middleLine.centerX = Screen_weight/2;
    middleLine.centerY = headView.height/2;
    middleLine.backgroundColor = HexRGBAlpha(0xFF7F05, 1.0);
    [headView addSubview:middleLine];
    
    NSArray * arr = dataArr[section];
    NSString * title = [arr[0] objectForKeyNotNull:@"title"];
    float titleLableW = [TPCustomTool widthForString:title font:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(titleLableW+2, headView.height);
    titleLable.centerY = headView.height/2;
    titleLable.text = title;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    titleLable.textColor = HexRGBAlpha(0xFF7F05, 1.0);
    titleLable.centerX = Screen_weight/2;
    
    UIView * bgView = [[UIView alloc]init];
    bgView.size = CGSizeMake(titleLableW+3+56, headView.height);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.centerY = headView.height/2;
    bgView.centerX = Screen_weight/2;
    [headView addSubview:bgView];
    [headView addSubview:titleLable];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSArray * arr = dataArr[section];
    NSString * comment = [arr[arr.count-1] objectForKeyNotNull:@"comment"];
    if (comment == 0) {
        return 0;
    }
    return [TPCustomTool heightForString:comment fontSize:14.0 andWidth:(Screen_weight-20)]+10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    float commentH = 0;
    NSArray * arr = dataArr[section];
    NSString * comment = [arr[arr.count-1] objectForKeyNotNull:@"comment"];
    if (comment == 0) {
        commentH = 0;
    }
    commentH = [TPCustomTool heightForString:comment fontSize:14.0 andWidth:(Screen_weight-20)]+10;
    UIView * footView = [[UIView alloc]init];
    footView.size = CGSizeMake(Screen_weight, commentH);
    UILabel * commentLable = [[UILabel alloc]init];
    commentLable.size = CGSizeMake(Screen_weight-20, commentH-10);
    commentLable.centerX = Screen_weight/2;
    commentLable.bottom = footView.height;
    commentLable.textColor = HexRGBAlpha(0x5E5E5E, 1.0);
    commentLable.textAlignment = NSTextAlignmentLeft;
    commentLable.text = comment;
    commentLable.font = [UIFont systemFontOfSize:14.0f];
    commentLable.numberOfLines = 0;
    [footView addSubview:commentLable];
    return footView;
}

-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark network_Data
//数据请求

-(void)getProductDetail{
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:productId forKey:@"id"];
    __block TPReservationProductDetailViewController *blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]getDestinationDetailWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [blkSelf hideAllHUD];
        if (dict) {
            productDict = [dict objectForKeyNotNull:@"datas"];
            [topView setTitle:[productDict objectForKeyNotNull:@"name"]];
            [headViews setHeadData:productDict];
            recommendTableView.tableHeaderView = headViews;
            
            [footsView setPrice:[productDict objectForKeyNotNull:@"price"]];
            [recommendTableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}


-(void)getProductDetailList{
    [self showLoadingHUDWithText:nil];
    __block TPReservationProductDetailViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:productId forKey:@"id"];
    [[JDDAPIs sharedJDDAPIs] getDestinationDetailListWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        [self hideAllHUD];
        if (dict) {
            
            NSArray * dataarr = [dict objectForKeyNotNull:@"datas"];
            NSMutableArray * sections = [[NSMutableArray alloc]init];
            NSMutableArray * rows = [[NSMutableArray alloc]init];
            for (int i = 0; i < dataarr.count; i++) {
                NSDictionary * dict = dataarr[i];
                if ([dict objectForKeyNotNull:@"title"]) {
                    if (rows.count == 0) {
                        [rows addObject:dict];
                    }else{
                        [sections addObject:[rows copy]];
                        [rows removeAllObjects];
                        [rows addObject:dict];
                    }
                }else{
                    [rows addObject:dict];
                }
            }
            if ((sections.count == 0)&&(rows.count != 0)) {
                [sections addObject:rows];
            }
            dataArr = sections;
            [recommendTableView reloadData];
            recommendTableView.tableFooterView = footerView;
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



















