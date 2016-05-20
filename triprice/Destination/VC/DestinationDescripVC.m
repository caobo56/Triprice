//
//  DestinationDescripVC.m
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import "DestinationDescripVC.h"
#import "TPWeekRecommendTopView.h"
#import "DestinationButtonView.h"
#import "DestinationMoreVC.h"
#import "GDataXMLNode.h"
#import "DestinationDetailVC.h"
#import "TPReservationViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DestinationDescripVC ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *descrepLabel;
@property (strong, nonatomic) UIImageView *sunImage;
@property (strong, nonatomic) MPMoviePlayerViewController *playerCtrl;
@property (nonatomic, readonly) MPMoviePlayerController *player;
@property (nonatomic) NSInteger  timeZone;

@end

@implementation DestinationDescripVC

-(void)createView{

    TPWeekRecommendTopView * topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setTitle:self.title];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, Screen_height-topView.bottom)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.top = topView.bottom;
    [self.view addSubview:_scrollView];

    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImg.image = [UIImage imageNamed:@"tmpBg"];
    UIView  *viewW = [[UIView alloc]initWithFrame:bgImg.bounds];
    viewW.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    [bgImg addSubview:viewW];
    [_scrollView addSubview:bgImg];


    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 60)];
    infoView.backgroundColor = [UIColor whiteColor];
    infoView.top = rateLangth(180);
    [_scrollView addSubview:infoView];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(7, 12, 2, 13)];
    line.backgroundColor = darkTextColor;
    [infoView addSubview:line];

    _nameLabel = [UILabel  createWithFrame:CGRectMake(0, 0, 0, 13) withFont:13 withTextAligment:NSTextAlignmentCenter withTextColor:TextBlueColor];
    _nameLabel.text = self.title;
    [_nameLabel sizeToFit];
    _nameLabel.left = 12;
    _nameLabel.top = 12;
    [infoView addSubview:_nameLabel];

    _sunImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
    _sunImage.top = _nameLabel.top;
    _sunImage.left = _nameLabel.right+15;
    [infoView addSubview:_sunImage];

    _temperatureLabel = [UILabel createWithFrame:CGRectMake(0, 0, 200, 13) withFont:13 withTextAligment:NSTextAlignmentLeft withTextColor:TextBlueColor];
    _temperatureLabel.left = _sunImage.right+5;
    _temperatureLabel.top = _nameLabel.top;
    _temperatureLabel.text = @"23-29度";
    [infoView addSubview:_temperatureLabel];

    _timeLabel = [UILabel createWithFrame:CGRectMake(0, 0, Screen_weight, 13) withFont:13 withTextAligment:NSTextAlignmentLeft withTextColor:TextBlueColor];
    _timeLabel.text = @"当地时间：  2016年02月20日 15:39 星期天";
    [self setTimeLableString];
    [_timeLabel sizeToFit];
    _timeLabel.width +=20;
    _timeLabel.bottom = infoView.height - 12;
    _timeLabel.left = 7;

    [infoView addSubview:_timeLabel];

    _descrepLabel = [UILabel createWithFrame:CGRectMake(0, 0, 50, rateLangth(25)) withFont:13 withTextAligment:NSTextAlignmentCenter withTextColor:[UIColor whiteColor]];
    _descrepLabel.layer.cornerRadius = 3;
    _descrepLabel.layer.masksToBounds = YES;
    _descrepLabel.backgroundColor = [UIColor colorWithRed:0.988 green:0.498 blue:0.145 alpha:1.00];
    _descrepLabel.text = @"免签";
    _descrepLabel.right = Screen_weight - 5;
    _descrepLabel.centerY = infoView.height/2;
    [infoView addSubview:_descrepLabel];

    DestinationDescripVC *__weak weakSelf = self;
    DestinationButtonView *buttonView = [[DestinationButtonView alloc]init];
    buttonView.top = infoView.bottom;
    buttonView.action = ^(NSInteger buttonTag){
        [weakSelf gotoDetail:buttonTag];
    };

    [_scrollView addSubview:buttonView];
    _scrollView.contentSize = CGSizeMake(Screen_weight, buttonView.bottom+50);


//底部 footView
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, 50)];
    footView.backgroundColor = NavBgColorAl;
    footView.bottom = self.view.height;
    [self.view addSubview:footView];

    UIImageView *footImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 35)];
    footImage.image = [UIImage imageNamed:@"tablogo"];
    footImage.backgroundColor = [UIColor whiteColor];
    [[footImage layer] setCornerRadius:3.0];//圆角
    footImage.centerY = 25;
    footImage.left = 10;
    [footView addSubview:footImage];

    UILabel *footLabel = [UILabel createWithFrame:CGRectMake(0, 0, 200, 15) withFont:15 withTextAligment:NSTextAlignmentLeft withTextColor:[UIColor whiteColor]];
    footLabel.text = @"子吾旅行";
    footLabel.centerY =25;
    footLabel.left = footImage.right+7;
    [footView addSubview:footLabel];

    UILabel *moreLabel = [UILabel createWithFrame:CGRectMake(0, 0, 75, 30) withFont:15 withTextAligment:NSTextAlignmentCenter withTextColor:TextBlueColor];
    moreLabel.right = Screen_weight - 10;
    moreLabel.centerY = 25;
    moreLabel.text = @"精品项目";
    moreLabel.backgroundColor = [UIColor whiteColor];
    moreLabel.layer.cornerRadius = 3;
    moreLabel.layer.masksToBounds = YES;
    [moreLabel whenTapped:^{
        DestinationMoreVC *more = [[DestinationMoreVC alloc]init];
        more.infoDic = _infoDic;
        more.title = [NSString stringWithFormat:@"%@ 项目",self.title];
        [self.navigationController pushViewController:more animated:YES];
    }];
    [footView addSubview:moreLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _timeZone = 0;
    [self createView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getRequest];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)setTimeLableString{

    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期天",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSDate *newdate = [NSDate dateWithTimeIntervalSinceNow:_timeZone*3600];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:newdate];

    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSInteger weekDay = [dateComponent weekday];
    _timeLabel.text = [NSString stringWithFormat:@"当地时间：  %ld年%ld月%ld日 %ld:%ld %@",(long)year,(long)month,(long)day,(long)hour,(long)minute,arrWeek[weekDay]];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoDetail:(NSInteger )buttonTag{
    DestinationDetailVC *detailVC = [[DestinationDetailVC alloc]init];
    detailVC.infoDic = _infoDic;
    detailVC.page = buttonTag-1000;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)getRequest{

    NSString *urlString = [NSString stringWithFormat:@"%@destination/searchVideo.do",SERVER_URL];
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjects:@[_infoDic[@"code"]] forKeys:@[@"code"]];
    DestinationDescripVC *__weak weakSelf = self;

    [[JDDAPIs sharedJDDAPIs] postUrl:urlString withParameters:parameters callback:^(NSDictionary *dict, NSString *error) {

        if (!dict) {
            NSString *video = _infoDic[@"pic"];
            video = [@"http://120.27.30.159/triprice/upload/images/destination/photo/" stringByAppendingString:video];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(180))];
            [imageV setImageWithURL:[NSURL URLWithString:video] placeholderImage:nil];
            return ;
        }
        NSLog([dict description],nil);

        if ([dict objectForKeyNotNull:@"isSuccess"]) {
            if ([dict[@"isSuccess"] intValue]) {
                if ([dict objectForKeyNotNull:@"datas"]) {
                    NSDictionary *datas = dict[@"datas"];

                    _timeZone = [datas[@"time_zone"] intValue];
                    [self setTimeLableString];
                    if ([datas objectForKeyNotNull:@"video"]) {
                        NSString *video = datas[@"video"];
                        video = [@"http://" stringByAppendingString:video];

                        MPMoviePlayerViewController *playerCtrl = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:video]];
                        [self addChildViewController:playerCtrl];   //不可缺，不然playerCtrl.view设置无效
                        [playerCtrl.view setFrame:CGRectMake(0, 0, Screen_weight, rateLangth(180))];
                        playerCtrl.moviePlayer.shouldAutoplay = YES;
                        playerCtrl.moviePlayer.controlStyle =MPMovieControlStyleEmbedded;
                        self.playerCtrl = playerCtrl;
                        [_scrollView addSubview:playerCtrl.view];
                    }else{
                        if ([datas objectForKeyNotNull:@"pic"]) {
                            NSString *video = datas[@"pic"];
                            video = [@"http://120.27.30.159/triprice/upload/images/destination/photo/" stringByAppendingString:video];
                            NSLog(@"%@",video);
                            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(180))];
                            [imageV setImageWithURL:[NSURL URLWithString:video] placeholderImage:nil];
                            [_scrollView addSubview:imageV];
                        }
                    }

                    if ([datas objectForKeyNotNull:@"woeid"]) {
                        int cityCode = [datas[@"woeid"] intValue];
                        [weakSelf getCityRequest:cityCode];
                    }

                }

            }else{

            }
        }else{

        }
    }];
}

-(void)getCityRequest:(long long)cityCode{

    NSString *url = [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%.lld&u=c",cityCode];

    NSData *cityData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSString *xmlString = [[NSString alloc]initWithData:cityData encoding:NSUTF8StringEncoding];
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    GDataXMLElement *xmlEle = [xmlDoc rootElement];
    NSArray *array = [xmlEle children];

    GDataXMLElement *ele = [array objectAtIndex:0];
    GDataXMLElement *ele2 = [ele elementsForName:@"item"][0];
    GDataXMLElement *ele3 = [ele2 elementsForName:@"description"][0];
    NSArray *aArray = [[ele3 stringValue] componentsSeparatedByString:@"/>"];
    NSLog(@"aArray == %@",aArray[0]);
    NSArray *imageURLArr = [aArray[0] componentsSeparatedByString:@"\""];
    NSArray *temArr = [aArray[6] componentsSeparatedByString:@":"];
    NSInteger height = [[[temArr[1] componentsSeparatedByString:@" Low"] objectAtIndex:0] integerValue];
    NSInteger low = [[[temArr[2] componentsSeparatedByString:@"<br"] objectAtIndex:0] integerValue];
    _temperatureLabel.text = [NSString stringWithFormat:@"%ld-%ld度",low,height];
    [_sunImage setImageWithURL:[NSURL URLWithString:imageURLArr[1]] placeholderImage:nil];
//      TODO
}



@end
