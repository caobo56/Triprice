//
//  TPReservationProductPushViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/24.
//
//

#import "TPReservationProductPushViewController.h"
#import "TPPushDemandTopView.h"
#import "TPReservationFooterView.h"
#import "TPMinusPlusView.h"
#import "IWTextView.h"
#import "LvInputView.h"


@interface TPReservationProductPushViewController()<UITextViewDelegate,UIAlertViewDelegate>

@end

@implementation TPReservationProductPushViewController{
    NSString *pushId;
    NSDictionary * pushDict;
    
    TPMinusPlusView * playDays;
    IWTextView * reachData;
    IWTextView * contactPreson;
    IWTextView * contactTel;
    
    UIScrollView * scrollView;

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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    TPPushDemandTopView * topView = [[TPPushDemandTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setRightTitle:@"提交"];
    [topView setTitle:@"预 订"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    TPReservationFooterView * footView = [[TPReservationFooterView alloc]init];
    footView.bottom = Screen_height;
    
    [footView setPrice:[pushDict objectForKeyNotNull:@"price"]];
    footView.reservationBtn.hidden = YES;
    [self.view addSubview:footView];
    
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.size = CGSizeMake(Screen_weight, Screen_height-NavBarH-StateBarH-TabBarH);
    scrollView.origin = CGPointMake(0, NavBarH+StateBarH);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(Screen_weight, Screen_height*2);
    [self.view addSubview:scrollView];
    
    playDays = [[TPMinusPlusView alloc]init];
    [playDays setTitleFocusd:@"预定数量"];
    playDays.left = 15;
    playDays.top = 0;
    [playDays setAccount:4];
    [playDays setLeastValue:1];
    [scrollView addSubview:playDays];
    
    [self setReachDataView];
    [self setContactPerson];
    [self setContactTel];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPress{
    if (![self judgeParameter]) {
        return;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    MTUser *user = [YYAccountTool account];
    
    [dic setObject:user.userId forKey:@"order.userId"];
    
    [dic setObject:reachData.text forKey:@"order.useDate"];
    [dic setObject:@(playDays.account) forKey:@"order.num"];
    [dic setObject:contactPreson.text forKey:@"order.userName"];
    [dic setObject:contactTel.text forKey:@"order.userPhone"];
    [dic setObject:pushId forKey:@"order.productId"];
    [dic setObject:@(1) forKey:@"order.category"];
    [dic setObject:@([[pushDict objectForKeyNotNull:@"price"] intValue]) forKey:@"order.priceUnit"];

    [self showLoadingHUDWithText:nil];
    __block TPReservationProductPushViewController *blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]bookingAddOrderWithParmeters:dic WithBlock:^(NSDictionary *dicts, NSString *error) {
        
        [self hideAllHUD];
        if (dicts) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"订单提交成功，请等待客服联系!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];

}


/**
 require.leaveDate:     到达日期
 require.travelDays:    游玩天数
 require.adultCnt:      成人个数
 require.kidsCnt:       儿童个数
 require.price:         总预算
 require.contact:        联系人
 require.phone:         联系电话
 require.service:        所需服务； 按2.1.6拼成字符串，以“，”隔开
 require.codes:        //2.2.2接口中的city_code
 */

- (BOOL)judgeParameter{
    BOOL result = YES;
    if (reachData.text.length == 0) {
        [self showHUDWithText:@"请选择到达日期"];
        result = NO;
        return result;
    }
    if (playDays.account == 0) {
        [self showHUDWithText:@"请选择预定数量"];
        result = NO;
        return result;
    }
    
    if (contactPreson.text.length == 0) {
        [self showHUDWithText:@"请输入联系人姓名"];
        result = NO;
        return result;
    }
    
    if ([contactTel.text length] ==0) {
        [self showHUDWithText:@"请输入联系电话"];
        result = NO;
        return result;
    }
    
    return result;
}

-(void)setPushId:(NSString *)RecommendId{
    pushId = RecommendId;
}

-(void)setPushData:(NSDictionary *)recommendData{
     pushDict = recommendData;
}


-(void)setReachDataView{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = playDays.size;
    dataView.left = Screen_weight-15-playDays.width;
    dataView.centerY = playDays.centerY;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(playDays.width, playDays.height/2);
    dataTitle.origin = CGPointMake(0, 0);
    dataTitle.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:dataTitle];
    
    NSString * str = [NSString stringWithFormat:@"到达日期*"];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13.0f]
                        range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:10.0f]
                        range:NSMakeRange(str.length-1, 1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:HexRGBAlpha(0x26323B, 1.0) range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length-1, 1)];
    dataTitle.attributedText = attriString;
    
    reachData = [[IWTextView alloc]initWithFrame:CGRectMake(0, dataTitle.height, dataView.width, dataTitle.height)];
    [reachData setPlaceholder:@"到达目的地日期"];
    reachData.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    reachData.layer.cornerRadius = 2.0f;
    reachData.layer.borderWidth = 0.5;
    reachData.tag = 0;
    reachData.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:reachData];
    
    [self setdateView:(UITextField *)reachData andWithTag:0];
    [self creatKeyBoardWith:(UITextField *)reachData andBtnTag:0];
}

-(void)setContactPerson{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = playDays.size;
    dataView.left = 15;
    dataView.top = playDays.bottom+15;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(playDays.width, playDays.height/2);
    dataTitle.origin = CGPointMake(0, 0);
    dataTitle.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:dataTitle];
    
    NSString * str = [NSString stringWithFormat:@"联系人*"];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13.0f]
                        range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:10.0f]
                        range:NSMakeRange(str.length-1, 1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:HexRGBAlpha(0x26323B, 1.0) range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length-1, 1)];
    dataTitle.attributedText = attriString;
    
    contactPreson = [[IWTextView alloc]initWithFrame:CGRectMake(0, dataTitle.height, dataView.width, dataTitle.height)];
    [contactPreson setPlaceholder:@"联系人"];
    contactPreson.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    contactPreson.layer.cornerRadius = 2.0f;
    contactPreson.layer.borderWidth = 0.5;
    contactPreson.tag = 2;
    contactPreson.delegate = self;
    contactPreson.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:contactPreson];
    
    [self setdateView:(UITextField *)contactPreson andWithTag:2];
    [self creatKeyBoardWith:(UITextField *)contactPreson andBtnTag:2];
}

-(void)setContactTel{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = playDays.size;
    dataView.left = Screen_weight-15-playDays.width;
    dataView.top = playDays.bottom+15;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(playDays.width, playDays.height/2);
    dataTitle.origin = CGPointMake(0, 0);
    dataTitle.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:dataTitle];
    
    NSString * str = [NSString stringWithFormat:@"联系电话*"];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13.0f]
                        range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:10.0f]
                        range:NSMakeRange(str.length-1, 1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:HexRGBAlpha(0x26323B, 1.0) range:NSMakeRange(0, str.length-1)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length-1, 1)];
    dataTitle.attributedText = attriString;
    
    contactTel = [[IWTextView alloc]initWithFrame:CGRectMake(0, dataTitle.height, dataView.width, dataTitle.height)];
    [contactTel setPlaceholder:@"联系电话"];
    contactTel.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    contactTel.layer.cornerRadius = 2.0f;
    contactTel.layer.borderWidth = 0.5;
    contactTel.tag = 3;
    contactTel.delegate = self;
    contactTel.keyboardType = UIKeyboardTypeNumberPad;
    contactTel.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:contactTel];
    
    [self setdateView:(UITextField *)contactTel andWithTag:3];
    [self creatKeyBoardWith:(UITextField *)contactTel andBtnTag:3];
}


-(void)setdateView:(UITextField *)field andWithTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
        {
            UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,20, 320, 216)];
            datePicker.tag = tag;
            datePicker.alpha = 0.8;
            datePicker.backgroundColor = [UIColor lightGrayColor];
            [datePicker setDatePickerMode:UIDatePickerModeDate];
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans"]];
            field.inputView = datePicker;
            [datePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
        }
            break;
            
        default:
            break;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
//    NSInteger tag = textView.tag;
//    if (tag == 2) {
//        NSInteger a = textView.superview.bottom;
//        NSInteger c = scrollView.height;
//        float tt = a+216+85-c;
//        if (tt<0) {
//            tt =-tt;
//        }
//        scrollView.contentOffset = CGPointMake(0,tt);
//    }else{
//        NSInteger a = textView.superview.bottom;
//        NSInteger c = scrollView.height;
//        float tt = a+216+40-c;
//        if (tt<0) {
//            tt =-tt;
//        }
//        scrollView.contentOffset = CGPointMake(0,tt);
//    }
}

- (void)dateValueChanged:(UIDatePicker *)datePicker
{
    [reachData setPlaceholder:@""];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    reachData.text = [formatter stringFromDate:datePicker.date];
}

-(void)creatKeyBoardWith:(UITextField *)field andBtnTag:(NSInteger)tag
{
    LvInputView *view = [LvInputView creatInputView];
    view.cancelBtn.tag = tag;
    view.completeBtn.tag = tag;
    view.titlelabel.text = @"";
    [view.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view.completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    field.inputAccessoryView = view;
}
- (void)cancelBtnClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    scrollView.contentOffset = CGPointMake(0, 0);
}
- (void)completeBtnClick:(UIButton *)btn
{
    scrollView.contentOffset = CGPointMake(0, 0);
    switch (btn.tag) {
        case 0:{
            UIDatePicker *picker = (UIDatePicker *)reachData.inputView;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            reachData.text = [formatter stringFromDate:picker.date];
            [reachData setPlaceholder:@""];
            
        }
            break;
            
    }
    [self.view endEditing:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
