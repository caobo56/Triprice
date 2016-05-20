//
//  TPPushDemandViewController.m
//  triprice
//
//  Created by caobo56 on 16/2/25.
//
//

#import "TPPushDemandViewController.h"
#import "TPPushPointViewController.h"

#import "TPPushDemandTopView.h"
#import "TPMinusPlusView.h"
#import "IWTextView.h"
#import "LvInputView.h"

@interface TPPushDemandViewController()<UITextViewDelegate,UIAlertViewDelegate>

@end

@implementation TPPushDemandViewController{
    IWTextView * pointView;

    TPMinusPlusView * playDays;
    TPMinusPlusView * preson;
    TPMinusPlusView * children;
    
    IWTextView * reachData;
    IWTextView * budgetView;
    IWTextView * contactPreson;
    IWTextView * contactTel;
    
    
    UIScrollView * scrollView;
    JDDCustomBtn * journeyBtn;
    JDDCustomBtn * guideBtn;
    JDDCustomBtn * carBtn;
    JDDCustomBtn * ticketBtn;
    
    NSArray * touristArr;
    NSDictionary * pointDict;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)setTouristSelectArr:(NSArray *)arr{
    touristArr = [arr copy];
    pointView.placeholder = @"";
    pointView.text = [NSString stringWithFormat:@"%lu 景点已选",(unsigned long)touristArr.count];
}

-(void)setCityDict:(NSDictionary *)dic{
    
    pointDict = [dic copy];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
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
    scrollView = [[UIScrollView alloc]init];
    scrollView.size = CGSizeMake(Screen_weight, Screen_height-NavBarH-StateBarH);
    scrollView.origin = CGPointMake(0, NavBarH+StateBarH);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(Screen_weight, Screen_height*2);
    [self.view addSubview:scrollView];
    
    
    TPPushDemandTopView * topView = [[TPPushDemandTopView alloc]init];
    [topView setBackBtnTitle:@"首页"];
    [topView setRightTitle:@"发布"];
    [topView setTitle:@"发布需求"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];

    playDays = [[TPMinusPlusView alloc]init];
    [self setPointView];

    [playDays setTitleFocusd:@"游玩天数"];
    playDays.left = Screen_weight-15-playDays.width;
    playDays.top = pointView.superview.bottom+15;
    [playDays setAccount:4];
    [playDays setLeastValue:1];
    [scrollView addSubview:playDays];
    
    [self setReachDataView];
    
    preson = [[TPMinusPlusView alloc]init];
    [preson setTitleFocusd:@"成人"];
    preson.left = 15;
    preson.top = playDays.bottom + 15;
    [preson setAccount:1];
    [preson setLeastValue:1];
    [scrollView addSubview:preson];
    
    children = [[TPMinusPlusView alloc]init];
    [children setTitle:@"儿童"];
    children.left = Screen_weight-15-children.width;;
    children.top = playDays.bottom + 15;
    [children setAccount:0];
    [children setLeastValue:0];
    [scrollView addSubview:children];
    
    [self setBudgetView];
    [self setContactPerson];
    [self setContactTel];
    [self setServiceUI];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPress{//发布
    if (![self judgeParameter]) {
        return;
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:reachData.text forKey:@"require.leaveDate"];
    [dict setObject:@(playDays.account) forKey:@"require.travelDays"];
    [dict setObject:@(preson.account) forKey:@"require.adultCnt"];
    [dict setObject:@(children.account) forKey:@"require.kidsCnt"];
    [dict setObject:@([budgetView.text intValue])  forKey:@"require.price"];
    [dict setObject:contactPreson.text forKey:@"require.contact"];
    [dict setObject:contactTel.text forKey:@"require.phone"];
    NSMutableString * service = [[NSMutableString alloc]init];
    if (guideBtn.selected) {
        [service appendString:@"1"];
    }
    if (journeyBtn.selected) {
        [service appendString:@","];
        [service appendString:@"2"];
    }
    if (carBtn.selected) {
        [service appendString:@","];
        [service appendString:@"3"];
    }
    if (ticketBtn.selected) {
        [service appendString:@","];
        [service appendString:@"4"];
    }
    [dict setObject:service forKey:@"require.service"];
    
    NSMutableString * tourist = [[NSMutableString alloc]init];
    
    for (int i = 0; i < touristArr.count; i++) {
        [tourist appendString:[touristArr[i] objectForKeyNotNull:@"id"]];
        if (i<touristArr.count-1) {
            [tourist appendString:@","];
        }
    }
    [dict setObject:tourist forKey:@"require.tourist"];
    
    [dict setObject:[pointDict objectForKeyNotNull:@"code"] forKey:@"require.codes"];
    
    [self showLoadingHUDWithText:nil];
    __block TPPushDemandViewController *blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]publishRequireWithParameters:dict WithBlock:^(NSDictionary *dict, NSString *error) {
        
        [self hideAllHUD];
        if (dict) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的需求已经推送给了当地地接公司，请注意查看个人订单!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
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
    if (pointView.text.length == 0) {
        [self showHUDWithText:@"请选择目的地"];
        result = NO;
        return result;
    }
    
    if (reachData.text.length == 0) {
        [self showHUDWithText:@"请选择到达日期"];
        result = NO;
        return result;
    }
    if (playDays.account == 0) {
        [self showHUDWithText:@"请选择游玩天数"];
        result = NO;
        return result;
    }
    
    if (preson.account == 0) {
        [self showHUDWithText:@"请选择成人数量"];
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

-(void)setPointView{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = CGSizeMake(Screen_weight-30, playDays.height);
    dataView.left = 5;
    dataView.top = 0;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(playDays.width, playDays.height/2);
    dataTitle.origin = CGPointMake(0, 0);
    dataTitle.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:dataTitle];
    NSString * str = [NSString stringWithFormat:@"目的地*"];
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

    pointView = [[IWTextView alloc]initWithFrame:CGRectMake(0, dataTitle.height, dataView.width, dataTitle.height)];
    [pointView setPlaceholder:@"地接规划项目"];
    pointView.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    pointView.layer.cornerRadius = 2.0f;
    pointView.layer.borderWidth = 0.5;
    pointView.tag = 1;
    pointView.delegate = self;
    pointView.font = [UIFont systemFontOfSize:13.0f];
    pointView.editable = NO;
    [dataView addSubview:pointView];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pointViewAction:)];
    
    [pointView addGestureRecognizer:tapGesture];
    
    
    [self setdateView:(UITextField *)budgetView andWithTag:4];
    [self creatKeyBoardWith:(UITextField *)budgetView andBtnTag:4];

}

-(void)pointViewAction:(id)sender{
    TPPushPointViewController * pointVC = [[TPPushPointViewController alloc]init];
//    __block NSDictionary * dit = pointDict;
    [self.navigationController pushViewController:pointVC animated:YES];
}

-(void)setReachDataView{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = playDays.size;
    dataView.left = 15;
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

-(void)setBudgetView{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = CGSizeMake(Screen_weight-30, playDays.height);
    dataView.left = 15;
    dataView.top = children.bottom+15;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(playDays.width, playDays.height/2);
    dataTitle.origin = CGPointMake(0, 0);
    dataTitle.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:dataTitle];
    dataTitle.textColor = HexRGBAlpha(0x26323B, 1.0);
    dataTitle.text = @"总预算（可选）";
    
    budgetView = [[IWTextView alloc]initWithFrame:CGRectMake(0, dataTitle.height, dataView.width-55, dataTitle.height)];
    [budgetView setPlaceholder:@"总预算"];
    budgetView.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    budgetView.layer.cornerRadius = 2.0f;
    budgetView.layer.borderWidth = 0.5;
    budgetView.tag = 1;
    budgetView.delegate = self;
    budgetView.keyboardType = UIKeyboardTypeNumberPad;
    budgetView.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:budgetView];
    
    [self setdateView:(UITextField *)budgetView andWithTag:1];
    [self creatKeyBoardWith:(UITextField *)budgetView andBtnTag:1];
    
    UILabel * rmbLable = [[UILabel alloc]init];
    rmbLable.size = CGSizeMake(55, playDays.height/2);
    rmbLable.left = budgetView.right;
    rmbLable.centerY = budgetView.centerY;
    rmbLable.textAlignment = NSTextAlignmentCenter;
    rmbLable.font = [UIFont systemFontOfSize:13.0f];
    rmbLable.textColor = HexRGBAlpha(0x26323B, 1.0);
    [dataView addSubview:rmbLable];
    rmbLable.text = @"RMB";
}

-(void)setContactPerson{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = playDays.size;
    dataView.left = 15;
    dataView.top = budgetView.superview.bottom+15;
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
    dataView.left = playDays.left;
    dataView.top = budgetView.superview.bottom+15;
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

-(void)setServiceUI{
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(Screen_weight-200, 30);
    titleLable.top = contactTel.superview.bottom+15;
    titleLable.text = @"所需服务";
    titleLable.left = 10.0f;
    titleLable.font = [UIFont systemFontOfSize:16.0f];
    [titleLable setTextColor:HexRGBAlpha(0xFF7F05, 1.0)];
    [scrollView addSubview:titleLable];
    
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.size = CGSizeMake(Screen_weight-8*5, 75);
    bottomView.top = titleLable.bottom+10;
    bottomView.left = 8;
    [scrollView addSubview:bottomView];
    
    guideBtn = [JDDCustomBtn buttonWithType:UIButtonTypeCustom];
    UIImage *guideService =[UIImage imageNamed:@"flyTicket"];
    guideBtn.size = CGSizeMake(bottomView.width/4, bottomView.height);
    guideBtn.origin = CGPointMake(0, 0);
    [guideBtn setImage:guideService withTitle:@"机票" forState:UIControlStateNormal];
    [guideBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    guideBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    guideBtn.layer.borderWidth = 0.5;
    guideBtn.backgroundColor = HexRGBAlpha(0xB9E1FE, 1.0);
    guideBtn.selected = YES;
    guideBtn.tag = 1;
    [guideBtn addTarget:self action:@selector(serviceBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:guideBtn];
    
    journeyBtn = [JDDCustomBtn buttonWithType:UIButtonTypeCustom];
    UIImage *journeyService =[UIImage imageNamed:@"hotel"];
    journeyBtn.size = CGSizeMake(bottomView.width/4, bottomView.height);
    journeyBtn.origin = CGPointMake(guideBtn.right+8, 0);
    [journeyBtn setImage:journeyService withTitle:@"酒店" forState:UIControlStateNormal];
    [journeyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    journeyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    journeyBtn.layer.borderWidth = 0.5;
    journeyBtn.selected = YES;
    journeyBtn.backgroundColor = HexRGBAlpha(0xB9E1FE, 1.0);
    journeyBtn.tag = 2;
    [journeyBtn addTarget:self action:@selector(serviceBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:journeyBtn];
    
    carBtn = [JDDCustomBtn buttonWithType:UIButtonTypeCustom];
    UIImage *carService =[UIImage imageNamed:@"carService"];
    carBtn.size = CGSizeMake(bottomView.width/4, bottomView.height);
    carBtn.origin = CGPointMake(journeyBtn.right+8, 0);
    [carBtn setImage:carService  withTitle:@"用车" forState:UIControlStateNormal];
    [carBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    carBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    carBtn.layer.borderWidth = 0.5;
    carBtn.tag = 3;
    [carBtn addTarget:self action:@selector(serviceBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:carBtn];
    
    ticketBtn = [JDDCustomBtn buttonWithType:UIButtonTypeCustom];
    UIImage *ticketService =[UIImage imageNamed:@"ticketService"];
    ticketBtn.size = CGSizeMake(bottomView.width/4, bottomView.height);
    ticketBtn.origin = CGPointMake(carBtn.right+8, 0);
    [ticketBtn setImage:ticketService  withTitle:@"门票" forState:UIControlStateNormal];
    [ticketBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    ticketBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ticketBtn.layer.borderWidth = 0.5;
    ticketBtn.tag = 4;
    [ticketBtn addTarget:self action:@selector(serviceBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:ticketBtn];
    
}

-(void)serviceBtnPress:(id)sender{
    JDDCustomBtn * aa = (JDDCustomBtn *)sender;
    aa.selected = !aa.selected;
    if (aa.selected) {
        aa.backgroundColor = HexRGBAlpha(0xB9E1FE, 1.0);
    }else{
        aa.backgroundColor = [UIColor whiteColor];
    }
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
        case 4:{
            field.inputView = nil;
        }
            break;
        default:
            break;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSInteger tag = textView.tag;
    if (tag == 2) {
        NSInteger a = textView.superview.bottom;
        NSInteger c = scrollView.height;
        float tt = a+216+85-c;
        if (tt<0) {
            tt =-tt;
        }
        scrollView.contentOffset = CGPointMake(0,tt);
    }else if (tag == 3) {
        NSInteger a = textView.superview.bottom;
        NSInteger c = scrollView.height;
        float tt = a+216+40-c;
        if (tt<0) {
            tt =-tt;
        }
        scrollView.contentOffset = CGPointMake(0,tt);
    }
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
