//
//  TPPushCityViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/25.
//
//

#import "TPPushCityViewController.h"
#import "TPPushDemandViewController.h"

#import "TPPushDemandTopView.h"
#import "TPPointleftTableView.h"
#import "TPCityRightTableView.h"
#import "DestinationOtherDetailVC.h"

@interface TPPushCityViewController()<TPCityRightTableViewSelectDelegate>

@end


@implementation TPPushCityViewController{
    NSInteger cityCode;
    NSArray * touristArr;
    UILabel * numLable;
    
    TPPointleftTableView * leftTableView;
    TPCityRightTableView * rightTableView;
    NSMutableArray * touristSelectArr;
    
    NSDictionary * dataDict;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        touristSelectArr = [[NSMutableArray alloc]init];

    }
    return self;
}

-(void)setCityDict:(NSDictionary *)data{
    dataDict = data;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self searchTouristItemByCity];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    TPPushDemandTopView * topView = [[TPPushDemandTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setRightTitle:@"下一步"];
    [topView setTitle:@"目的地"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    leftTableView = [[TPPointleftTableView alloc]init];
    NSArray * leftData = [[NSArray alloc]initWithObjects:dataDict, nil];
    [leftTableView loadData:leftData];
    [self.view addSubview:leftTableView];
    
    
    rightTableView = [[TPCityRightTableView alloc]init];
    rightTableView.selectDelegate = self;
    [self.view addSubview:rightTableView];
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.size = CGSizeMake(Screen_weight, 68);
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.bottom = self.view.bottom;
    bottomView.centerX = Screen_weight/2;
    
    UIView * topLine = [[UIView alloc]init];
    topLine.size = CGSizeMake(Screen_weight, 1);
    topLine.left = 0;
    topLine.top = 0;
    topLine.backgroundColor = cellLineColorTp;
    [bottomView addSubview:topLine];
    
    UIImage * in1 = [UIImage imageNamed:@"in1"];
    UIImageView * image1 = [[UIImageView alloc]init];
    image1.image = in1;
    image1.size = CGSizeMake(bottomView.height-17, bottomView.height-17);
    image1.centerY = bottomView.height/2;
    image1.left = 16;
    [bottomView addSubview:image1];
    
    UILabel * titLable = [[UILabel alloc]init];
    titLable.size = CGSizeMake(200, bottomView.height/2-10);
    titLable.left = image1.right+10;
    titLable.bottom = bottomView.size.height/2;
    titLable.textColor = cellLineColorTp;
    titLable.font = [UIFont systemFontOfSize:15.0f];
    titLable.textAlignment = NSTextAlignmentLeft;
    titLable.text = @"已选";
    [bottomView addSubview:titLable];
   
    numLable = [[UILabel alloc]init];
    numLable.size = CGSizeMake(200, bottomView.height/2-10);
    numLable.left = image1.right+10;
    numLable.top = bottomView.size.height/2;
    numLable.textColor = cellLineColorTp;
    numLable.font = [UIFont systemFontOfSize:15.0f];
    numLable.textAlignment = NSTextAlignmentLeft;
    numLable.text = @"0个";
    [bottomView addSubview:numLable];
    
    [self.view addSubview:bottomView];
}

-(void)cityRightTableViewSelectIndex:(NSInteger)index{
//    if (![touristArr containsObject:touristArr[index]]) {
        [touristSelectArr addObject:touristArr[index]];
//    }
    numLable.text = [NSString stringWithFormat:@"%lu个",(unsigned long)touristSelectArr.count];
}

-(void)cityRightTableViewUnSelectIndex:(NSInteger)index{
//    if ([touristArr containsObject:touristArr[index]]) {
        [touristSelectArr removeObject:touristArr[index]];
//    }
    numLable.text = [NSString stringWithFormat:@"%lu个",(unsigned long)touristSelectArr.count];
}

-(void)didSelectRowAtIndex:(NSInteger)index{
    DestinationOtherDetailVC *other = [[DestinationOtherDetailVC alloc]init];
    other.infoDic = touristArr[index];
    other.urlString = @"destination/searchTouristDetail.do";
    other.title = @"项目详情";
    [self.navigationController pushViewController:other animated:YES];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPress{//下一步
    if (![self judgeParameter]) {
        return;
    }
    NSArray * vcArr = self.navigationController.viewControllers;
    TPPushDemandViewController * demandVC = (TPPushDemandViewController *)vcArr[vcArr.count-3];
    [demandVC setTouristSelectArr:touristSelectArr];
    [self.navigationController popToViewController:demandVC animated:YES];
}

-(BOOL)judgeParameter{
    if (touristSelectArr.count == 0) {
        [self showHUDWithText:@"请至少选择一个景点"];
        return NO;
    }
    return YES;
}

-(void)searchTouristItemByCity{
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(0) forKey:@"pager.pageNum"];
    [dic setValue:@([[dataDict objectForKeyNotNull:@"code"] intValue]) forKey:@"code"];
    
    __block TPPushCityViewController * blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]searchTouristItemByCityWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [blkSelf hideAllHUD];
        if (dict) {
            touristArr = [dict objectForKeyNotNull:@"datas"];
            [rightTableView loadData:touristArr];
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
