//
//  DestinationDetailVC.m
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import "DestinationDetailVC.h"
#import "TPWeekRecommendTopView.h"
#import "SegmentView.h"
#import "DijieView.h"
#import "DDOtherView.h"
#import "DestinationOtherDetailVC.h"
#import "DestinationCommentVC.h"
#import "HandBookWebV.h"

@interface DestinationDetailVC ()<SegmentDelegate>{
    TPWeekRecommendTopView *topView;
    SegmentView *segV;
    UIView *currentView;
}

@property (strong, nonatomic) DijieView *dijieView;
@property (strong, nonatomic) DDOtherView *jingdianView;
@property (strong, nonatomic) DDOtherView *meishiView;
@property (strong, nonatomic) DDOtherView *shoppingView;
@property (strong, nonatomic) DDOtherView *jiudianView;
@property (strong, nonatomic) HandBookWebV *zhinanView;

@end

@implementation DestinationDetailVC


-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];
    topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    NSArray *array = @[@"地接",@"景点",@"美食",@"酒店",@"指南",@"购物"];
    [topView setTitle:array[_page]];

    segV = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 37)];
    segV.top = topView.bottom;
    segV.newSegment = YES;
    [self.view addSubview:segV];
    UIColor *color1= NavBgColor;
    UIFont *font1 = [UIFont systemFontOfSize:14.0];
    [segV setStringArray:@[@"地接",@"景点",@"美食",@"酒店",@"指南",@"购物"] textColor:color1  textFont:font1 index:_page];
    segV.delegate = self;
}

-(void)moveToPage:(id)view{

}

-(void)createWithPage:(NSInteger )index{
    UIView *view = nil;
    DestinationDetailVC *__weak weakSelf = self;
    switch (index) {
        case 0:{
            if (!_dijieView) {
                _dijieView  = [[DijieView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, Screen_height - segV.bottom) withDic:_infoDic];
                _dijieView.top = segV.bottom;
                _dijieView.callAction = ^(NSDictionary *dic){

                };
                _dijieView.commentAction = ^(NSDictionary *dic){
                    DestinationCommentVC *comment = [[DestinationCommentVC alloc]init];
                    comment.infoDic = dic;
                    [weakSelf.navigationController pushViewController:comment animated:YES];
                };
                [self.view addSubview:_dijieView];
            }
            view = _dijieView;
        }
            break;
        case 1:{
            if (!_jingdianView) {
                _jingdianView = [[DDOtherView alloc]initWithFrame:CGRectMake(0, segV.bottom, Screen_weight, Screen_height - segV.bottom) withViewState:Meijing withDic:_infoDic];
                _jingdianView.otherAction = ^(NSDictionary *dic){
                    [weakSelf gotoOtherDetail:dic withIndex:index];
                };
                [self.view addSubview:_jingdianView];
            }
            view = _jingdianView;
        }
            break;
        case 2:{
            if (!_meishiView) {
                _meishiView = [[DDOtherView alloc]initWithFrame:CGRectMake(0, segV.bottom, Screen_weight, Screen_height - segV.bottom) withViewState:Meishi withDic:_infoDic];
                _meishiView.otherAction = ^(NSDictionary *dic){
                    [weakSelf gotoOtherDetail:dic withIndex:index];
                };
                [self.view addSubview:_meishiView];
            }
            view = _meishiView;
        }
            break;
        case 3:{
            if (!_jiudianView) {
                _jiudianView = [[DDOtherView alloc]initWithFrame:CGRectMake(0, segV.bottom, Screen_weight, Screen_height - segV.bottom) withViewState:Jiudian withDic:_infoDic];
                _jiudianView.otherAction = ^(NSDictionary *dic){
                    [weakSelf gotoOtherDetail:dic withIndex:index];
                };
                [self.view addSubview:_jiudianView];
            }
            view = _jiudianView;
        }
            break;
        case 4:{
            if (!_zhinanView) {
                _zhinanView = [[HandBookWebV alloc]initWithFrame:CGRectMake(0, segV.bottom, Screen_weight, Screen_height - segV.bottom) withDic:_infoDic];
                [self.view addSubview:_zhinanView];
            }
            view = _zhinanView;
        }
            break;
        case 5:{
            if (!_shoppingView) {
                _shoppingView = [[DDOtherView alloc]initWithFrame:CGRectMake(0, segV.bottom, Screen_weight, Screen_height - segV.bottom) withViewState:Gouwu withDic:_infoDic];
                _shoppingView.otherAction = ^(NSDictionary *dic){
                    [weakSelf gotoOtherDetail:dic withIndex:index];
                };
                [self.view addSubview:_shoppingView];
            }
            view = _shoppingView;
        }
            break;
            
        default:
            break;
    }
    if (currentView) {
        if (index>_currentPage) {
            view.left = Screen_weight;
            [UIView animateWithDuration:0.35 animations:^{
                view.left = 0;
                currentView.right = 0;
            }];
        }else{
            view.right = 0;
            [UIView animateWithDuration:0.35 animations:^{
                view.left = 0;
                currentView.left = Screen_weight;
            }];
        }
    }
    currentView = view;
    view.left = 0;
    _currentPage = index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = _page;
    [self createView];
    [self createWithPage:_page];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setPage:(NSInteger)page{
    _page = page;
}

-(void)changeValue:(NSInteger)index{

    NSArray *array = @[@"地接",@"景点",@"美食",@"酒店",@"指南",@"购物"];
    [topView setTitle:array[index]];
    if (_currentPage == index) {
        return;
    }else{
        [self createWithPage:index];
    }
}

-(void)gotoOtherDetail:(NSDictionary *)dic withIndex:(NSInteger)index{

    NSArray *array = @[@1,@"景点详情",@"美食详情",@"酒店详情",@2,@"购物详情"];
    NSArray *array2 = @[@1,@"destination/searchTouristDetail.do",@"destination/searchFoodDetail.do",@"destination/searchHotelDetail.do",@2,@"destination/searchGoodsDetail.do"];
    DestinationOtherDetailVC *other = [[DestinationOtherDetailVC alloc]init];
    other.infoDic = dic;
    other.urlString = array2[index];
    other.title = array[index];
    [self.navigationController pushViewController:other animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
