//
//  TPWeekRecommendDetailViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/15.
//
//

#import "TPWeekRecommendDetailViewController.h"
#import "TPReservationViewController.h"
#import "TPPushRecommendDemandViewController.h"

#import "TPWeekRecommendTopView.h"
#import "TPWeekRecomendHeadView.h"
#import "TPWeekRecommendFooterView.h"


#import "TPCustomTool.h"


@interface RecommendCell : UITableViewCell


-(void)loadData:(NSDictionary *)dict;

@end

@implementation RecommendCell{
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


@interface TPWeekRecommendDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TPWeekRecommendDetailViewController{
    NSString *recommendId;
    NSDictionary * recommendDict;
    NSArray * dataArr;
    
    UITableView * recommendTableView;
    UIView * footerView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self getRecommendDetail];
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

-(void)setRecommendId:(NSString *)RecommendId{
    recommendId = RecommendId;
}

-(void)setRecommendData:(NSDictionary *)recommendData{
    recommendDict = recommendData;
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView setTitle:[recommendDict objectForKeyNotNull:@"name"]];
    [self.view addSubview:topView];
    
    TPWeekRecommendFooterView * footView = [[TPWeekRecommendFooterView alloc]init];
    footView.bottom = Screen_height;
    [footView.requirementBtn addTarget:self action:@selector(requirementBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [footView.reservationBtn addTarget:self action:@selector(reservationBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    TPWeekRecomendHeadView * headView = [[TPWeekRecomendHeadView alloc]init];
    [headView setHeadData:recommendDict];

    recommendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topView.bottom, Screen_weight, Screen_height-NavBarH-StateBarH) style:UITableViewStyleGrouped];
    recommendTableView.size = CGSizeMake(Screen_weight, Screen_height-NavBarH-StateBarH);
    recommendTableView.origin = CGPointMake(0, topView.bottom);
    recommendTableView.tableHeaderView = headView;
    recommendTableView.delegate = self;
    recommendTableView.dataSource = self;
    recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    recommendTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:recommendTableView];
    [self.view addSubview:footView];

    
    footerView = [[UIView alloc]init];
    footerView.size = CGSizeMake(Screen_weight, TabBarH);
    footerView.backgroundColor = [UIColor whiteColor];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requirementBtnPress{
    TPPushRecommendDemandViewController * pushRecommendVC = [[TPPushRecommendDemandViewController alloc]init];
    [pushRecommendVC setDemandDict:recommendDict];
    [self.navigationController pushViewController:pushRecommendVC animated:YES];
}

-(void)reservationBtnPress{
    TPReservationViewController * reservationVC = [[TPReservationViewController alloc]init];
    [reservationVC setCityCode:[recommendDict objectForKeyNotNull:@"city_code"]];
    [self.navigationController pushViewController:reservationVC animated:YES];
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
    RecommendCell *cell = (RecommendCell *)[tableViews dequeueReusableCellWithIdentifier:recommendIdentifier];
    if (cell == nil) {
        cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendIdentifier];
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
    
    UILabel * numLable = [[UILabel alloc]init];
    numLable.size = CGSizeMake(20, 20);
    numLable.centerY = headView.height/2;
    numLable.backgroundColor = HexRGBAlpha(0xFF7F05, 1.0);
    numLable.text = [NSString stringWithFormat:@"%ld",section+1];
    numLable.textAlignment = NSTextAlignmentCenter;
    [numLable.layer setCornerRadius:10.0];
    [numLable.layer setMasksToBounds:YES];
    numLable.textColor = [UIColor whiteColor];
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
    numLable.left = (Screen_weight-titleLableW-numLable.width-3)/2;
    titleLable.left = numLable.right+3;
    
    UIView * bgView = [[UIView alloc]init];
    bgView.size = CGSizeMake(titleLableW+numLable.width+3+56, headView.height);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.centerY = headView.height/2;
    bgView.centerX = Screen_weight/2;
    [headView addSubview:bgView];
    [headView addSubview:numLable];
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
-(void)getRecommendDetail{
    [self showLoadingHUDWithText:nil];
    __block TPWeekRecommendDetailViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:recommendId forKey:@"id"];
    [[JDDAPIs sharedJDDAPIs] getRecommendDetailWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
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
