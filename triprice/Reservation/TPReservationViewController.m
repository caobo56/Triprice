//
//  TPReservationViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/18.
//
//

#import "TPReservationViewController.h"
#import "TPWeekRecommendTopView.h"
#import "TPReservationProductDetailViewController.h"

#import "TPRatingStart.h"

#import <QuartzCore/QuartzCore.h>




#define ReservationCellH rateLangth(106)



@interface ReservationCell : UITableViewCell

-(void)loadData:(NSDictionary *)dict;


@end

@implementation ReservationCell{
    UIImageView * imageView;
    TPRatingStart * ratingStart;
    UILabel * nameLable;
    UILabel * priceLable;
    UILabel * timeLable;
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
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    self.size = CGSizeMake(Screen_weight, ReservationCellH);
    imageView = [[UIImageView alloc]init];
    imageView.left = rateLangth(16.0f);
    imageView.size = CGSizeMake(rateLangth(112), rateLangth(86));
    imageView.centerY = self.height/2;
    [self addSubview:imageView];
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.size = CGSizeMake(Screen_weight-rateLangth(16.0f), 1);
    lineView.left = rateLangth(16.0f);
    lineView.bottom = self.height;
    lineView.backgroundColor = HexRGBAlpha(0xDDE2E7, 1.0);
    [self addSubview:lineView];
    
    ratingStart = [[TPRatingStart alloc]init];
    ratingStart.centerY = self.height/2;
    ratingStart.left = imageView.right+20;
    [self addSubview:ratingStart];
    
    nameLable = [[UILabel alloc]init];
    nameLable.size = CGSizeMake(Screen_weight/2, 20);
    nameLable.left = imageView.right+10;
    nameLable.bottom = ratingStart.top-8;
    nameLable.textColor = HexRGBAlpha(0x26323B, 1.0);
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:nameLable];
    
    priceLable = [[UILabel alloc]init];
    priceLable.size = CGSizeMake(rateLangth(50), 16);
    priceLable.left = imageView.right+10;
    priceLable.top = ratingStart.bottom+8;
    priceLable.textAlignment = NSTextAlignmentLeft;
    priceLable.textColor = HexRGBAlpha(0xFF7F05, 1.0);
    priceLable.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:priceLable];
    
    UIImage * time = [UIImage imageNamed:@"time"];
    UIImageView * timeView = [[UIImageView alloc]init];
    timeView.image = time;
    timeView.size = time.size;
    timeView.centerY = priceLable.centerY;
    timeView.left = nameLable.left+80;
    [self addSubview:timeView];
    
    timeLable = [[UILabel alloc]init];
    timeLable.size = CGSizeMake(rateLangth(50), 16);
    timeLable.left = timeView.right+2;
    timeLable.centerY = priceLable.centerY;
    timeLable.textAlignment = NSTextAlignmentLeft;
    timeLable.textColor = HexRGBAlpha(0x26323B, 1.0);
    timeLable.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:timeLable];
}

-(void)loadData:(NSDictionary *)dict{
    [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    [ratingStart setRatingStartLeval:[[dict objectForKeyNotNull:@"score"] floatValue]];
    nameLable.text = [dict objectForKeyNotNull:@"name"];
    priceLable.text = [NSString stringWithFormat:@"¥ %@",[dict objectForKeyNotNull:@"price"]];
    timeLable.text = [dict objectForKeyNotNull:@"play_time"];
}


@end

@interface TPReservationViewController()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TPReservationViewController{
    NSString * cityCode;
    
    NSArray * dataArr;
    UITableView * reservationTableView;
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
    [self getReservationSearchAll];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)setCityCode:(NSString *)cityCodes{
    cityCode = cityCodes;
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:@"目的地产品"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    reservationTableView = [[UITableView alloc]init];
    reservationTableView.size = CGSizeMake(Screen_weight, Screen_height-topView.height);
    reservationTableView.origin = CGPointMake(0, topView.bottom);
    reservationTableView.backgroundColor = [UIColor whiteColor];
    reservationTableView.delegate = self;
    reservationTableView.dataSource = self;
    [self.view addSubview:reservationTableView];
    
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
    reservationTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getReservationSearchAllWithRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    reservationTableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    reservationTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getReservationSearchNextPageWithRefreshing];
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
    return ReservationCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reservationIdentifier = @"weekRecommend";
    ReservationCell *cell = (ReservationCell *)[tableViews dequeueReusableCellWithIdentifier:reservationIdentifier];
    if (cell == nil) {
        cell = [[ReservationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reservationIdentifier];
        [cell initUI];
    }
    [cell loadData:dataArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TPReservationProductDetailViewController * productDetailVC = [[TPReservationProductDetailViewController alloc]init];
    [productDetailVC setProductId:[dataArr[indexPath.row] objectForKeyNotNull:@"id"]];
//    [productDetailVC setProductData:dataArr[indexPath.row]];
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma mark network_Data
//数据请求
-(void)getReservationSearchAll{
    [self showLoadingHUDWithText:nil];
    __block TPReservationViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:cityCode forKey:@"code"];
    [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] getDestinationSearchWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        [self hideAllHUD];
        NSDictionary * pager = [dict objectForKeyNotNull:@"pager"];
        NSNumber * hasNexPage = [pager objectForKeyNotNull:@"pager"];
        if (hasNexPage == 0) {
            reservationTableView.tableFooterView = footerView;
        }
        if (dict) {
            dataArr = [dict objectForKeyNotNull:@"datas"];
            [reservationTableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

-(void)getReservationSearchAllWithRefreshing{
    __block TPReservationViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:cityCode forKey:@"code"];
    [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] getDestinationSearchWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [reservationTableView.mj_header endRefreshing];
            dataArr = [dict objectForKeyNotNull:@"datas"];
            [reservationTableView reloadData];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

-(void)getReservationSearchNextPageWithRefreshing{
    __block TPReservationViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:cityCode forKey:@"code"];
    [dict setValue:[NSString stringWithFormat:@"%ld",page+1] forKey:@"pager.pageNum"];
    [[JDDAPIs sharedJDDAPIs] getDestinationSearchWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error){
        if (dict) {
            [reservationTableView.mj_footer endRefreshing];
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                reservationTableView.tableFooterView = footerView;
            }else{
                page++;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:dataArr copyItems:YES];
                [arr addObjectsFromArray:data];
                dataArr = arr;
                [reservationTableView reloadData];
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
