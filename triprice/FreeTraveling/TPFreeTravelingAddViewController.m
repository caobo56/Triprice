//
//  TPFreeTravelingAddViewController.m
//  triprice
//
//  Created by caobo56 on 16/3/21.
//
//

#import "TPFreeTravelingAddViewController.h"
#import "TPPushDemandTopView.h"
#import "TPMinusPlusView.h"
#import "IWTextView.h"
#import "LvInputView.h"

@interface TPFreeTravelingAddViewController ()<UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation TPFreeTravelingAddViewController{
    UIScrollView * scrollView;
    NSDictionary * data;
    NSArray * dataArr;
    IWTextView * pointView;
    
    IWTextView * contactPreson;
    IWTextView * contactTel;
    
    TPMinusPlusView * preson;
    TPMinusPlusView * children;
    
    UIPickerView* pickerView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        data = [[NSDictionary alloc]init];
        [self initUI];
    }
    return self;
}

-(void)setFreeTravelingDict:(NSDictionary *)dict{
    data = [dict copy];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getSelectDate];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 界面UI
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    scrollView = [[UIScrollView alloc]init];
    scrollView.size = CGSizeMake(Screen_weight, Screen_height-NavBarH-StateBarH);
    scrollView.origin = CGPointMake(0, NavBarH+StateBarH);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(Screen_weight, Screen_height*1.5);
    [self.view addSubview:scrollView];
    
    TPPushDemandTopView * topView = [[TPPushDemandTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView setRightTitle:@"提交"];
    [topView setTitle:@"预定"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [topView.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    preson = [[TPMinusPlusView alloc]init];
    [preson setTitleFocusd:@"成人"];
    preson.left = 15;
    [preson setAccount:1];
    [preson setLeastValue:1];
    [scrollView addSubview:preson];
    
    children = [[TPMinusPlusView alloc]init];
    [children setTitle:@"儿童"];
    children.left = Screen_weight-15-children.width;
    [children setAccount:0];
    [children setLeastValue:0];
    [scrollView addSubview:children];
    
    [self setPointView];

    [self setContactPerson];
    [self setContactTel];
    
    preson.top = contactPreson.superview.bottom + 15;
    children.top = contactPreson.superview.bottom + 15;

    CGRect pickerFrame = CGRectMake(0,Screen_height/2,Screen_weight,216);
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.bottom = Screen_height;
    pickerView.delegate=self;
    //    显示选中框
    pickerView.showsSelectionIndicator=YES;

}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setPointView{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = CGSizeMake(Screen_weight-30, preson.height);
    dataView.centerX = Screen_weight/2;
    dataView.top = 0;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(preson.width, preson.height/2);
    dataTitle.origin = CGPointMake(0, 0);
    dataTitle.font = [UIFont systemFontOfSize:13.0f];
    [dataView addSubview:dataTitle];
    NSString * str = [NSString stringWithFormat:@"选择日期*"];
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
    [pointView setPlaceholder:@"选择日期"];
    pointView.layer.borderColor = HexRGBAlpha(0xd0d8e2, 1.0).CGColor;
    pointView.layer.cornerRadius = 2.0f;
    pointView.layer.borderWidth = 0.5;
    pointView.tag = 1;
    pointView.delegate = self;
    pointView.font = [UIFont systemFontOfSize:13.0f];
    pointView.editable = NO;
    [dataView addSubview:pointView];
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pointViewAction:)];
//    
//    [pointView addGestureRecognizer:tapGesture];
//    
    
    [self setdateView:(UITextField *)pointView andWithTag:1];
    [self creatKeyBoardWith:(UITextField *)pointView andBtnTag:1];

}

-(void)pointViewAction:(id)sender{
   
}


-(void)setContactPerson{
    UIView * dataView = [[UIView alloc]init];
    dataView.size = preson.size;
    dataView.left = 15;
    dataView.top = pointView.superview.bottom+15;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(preson.width, preson.height/2);
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
    dataView.size = preson.size;
    dataView.left = Screen_weight-15-dataView.width;
    dataView.top = pointView.superview.bottom+15;
    [scrollView addSubview:dataView];
    
    UILabel * dataTitle = [[UILabel alloc]init];
    dataTitle.size = CGSizeMake(preson.width, preson.height/2);
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


#pragma mark Picker Delegate 方法
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataArr count];
}


//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * str = [NSString stringWithFormat:@"%@ ¥%@ 余%@人", [dataArr[row] objectForKeyNotNull:@"use_date"],[dataArr[row] objectForKeyNotNull:@"price"],[dataArr[row] objectForKeyNotNull:@"num"]];
    return str;
}


// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    pointView.placeholder = @"";
    NSString * str = [NSString stringWithFormat:@"%@ ¥%@ 余%@人", [dataArr[row] objectForKeyNotNull:@"use_date"],[dataArr[row] objectForKeyNotNull:@"price"],[dataArr[row] objectForKeyNotNull:@"num"]];
    pointView.text = str;
}

#pragma mark 键盘相关的

-(void)setdateView:(UITextField *)field andWithTag:(NSInteger)tag
{
    switch (tag) {
        case 1:
        {
            field.inputView = pickerView;
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
        case 1:{
           NSInteger row = [pickerView selectedRowInComponent:0];
           pointView.placeholder = @"";
            NSString * str = [NSString stringWithFormat:@"%@ ¥%@ 余%@人", [dataArr[row] objectForKeyNotNull:@"use_date"],[dataArr[row] objectForKeyNotNull:@"price"],[dataArr[row] objectForKeyNotNull:@"num"]];
           pointView.text = str;
        }
            break;
    }
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSInteger tag = textView.tag;
    if (tag == 2) {
        scrollView.contentOffset = CGPointMake(0,textView.superview.top);
    }else if (tag == 3) {
        scrollView.contentOffset = CGPointMake(0,textView.superview.top);
    }
}


#pragma mark 网络请求
-(void)getSelectDate{
    [self showLoadingHUDWithText:nil];
    __block TPFreeTravelingAddViewController *blkSelf = self;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[data objectForKeyNotNull:@"id"] forKey:@"id"];
    [[JDDAPIs sharedJDDAPIs]getFreeTravlingDatesWithParameters:dict WithBlock:^(NSDictionary *dic, NSString *error) {
        [self hideAllHUD];
        if (dic) {
            dataArr = [dic objectForKeyNotNull:@"datas"];
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];
}

#pragma mark 发布需求
//    order.productId:     产品id，从2.2.19获得
//    order.category:      产品分类，从2.1.7获取，此处应该为2
//    order.priceUnit:     价格； 从2.2.19中传入
//    order.useDate：      游玩日期
//    order.userName：     联系人
//    order.userPhone：     联系电话
//    require.adultCnt:      成人个数
//    require.kidsCnt:       儿童个数
-(void)rightBtnPress{//发布
    if (![self judgeParameter]) {
        return;
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[data objectForKeyNotNull:@"id"] forKey:@"order.productId"];
    [dict setValue:@(2) forKey:@"order.category"];
    NSInteger selectIndex = [pickerView selectedRowInComponent:0];
    [dict setValue:[dataArr[selectIndex] objectForKeyNotNull:@"price"] forKey:@"order.priceUnit"];
    [dict setValue:[dataArr[selectIndex] objectForKeyNotNull:@"use_date"] forKey:@"order.useDate"];
    [dict setValue:contactPreson.text forKey:@"order.userName"];
    [dict setValue:contactTel.text forKey:@"order.userName"];
    [dict setValue:@([preson account]) forKey:@"require.adultCnt"];
    [dict setValue:@([children account]) forKey:@"require.kidsCnt"];
    MTUser *user = [YYAccountTool account];
    [dict setObject:user.userId forKey:@"order.userId"];
    
    [self showLoadingHUDWithText:nil];
    __block TPFreeTravelingAddViewController *blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]bookingAddOrderWithParmeters:dict WithBlock:^(NSDictionary *dicts, NSString *error) {
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

- (BOOL)judgeParameter{
    BOOL result = YES;
    if (pointView.text.length == 0) {
        [self showHUDWithText:@"请选择日期"];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
