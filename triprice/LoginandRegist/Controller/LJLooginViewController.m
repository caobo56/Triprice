//
//  LJLooginViewController.m
//  MeridianTravel
//
//  Created by mary on 15/6/14.
//  Copyright (c) 2015年 mary. All rights reserved.
//

#import "LJLooginViewController.h"
#import "LJRegisterViewController.h"
#import "LJFindPasswordViewController.h"
#import "NSString+NSPredicate.h"


#import "NSString+MD5.h"
//#import "MJExtension.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentApiInterface.h>


@interface LJLooginViewController ()
//<TencentSessionDelegate>
{
//    TencentOAuth * _tencentOAuth;
}
- (IBAction)loginBtnClick;
- (IBAction)qqLoginBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *qqloginBtn;
@end

@implementation LJLooginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1104714428" andDelegate:self];
    
//    self.qqloginBtn.hidden = ![TencentOAuth iphoneQQInstalled];
   
    self.navigationController.navigationBar.translucent = NO;

    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.size = CGSizeMake(Screen_weight, NavBarH);
    titleLable.bottom = NavBarH;
    titleLable.centerX = Screen_weight/2;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = HexRGBAlpha(0xFFFFFF, 1.0);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    titleLable.text = @"登 录";
    [self.navigationController.navigationBar addSubview:titleLable];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.size = CGSizeMake(40 , 40);
    [btn addTarget:self action:@selector(leftBaritemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBaritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBaritem;
    self.navigationController.navigationBar.barTintColor = NavBgColor;
}

- (void)leftBaritemClick{
    self.LoginMannger(NO);
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 注册按钮点击*/
- (IBAction)registerBtnClicked:(id)sender
{
    LJRegisterViewController *vc = [[LJRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)findPassWordBtnClicked:(id)sender
{
    LJFindPasswordViewController *vc = [[LJFindPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginBtnClick {
    [self.view endEditing:YES];
    if (![NSString isMobileNumber:self.phoneNumTextField.text]) {
        [self showHUDWithText:@"手机号错误"];
        return;
    }
    
    if (self.pwTextField.text.length == 0) {
        [self showHUDWithText:@"请输入密码"];
        return;
    }
    
    NSString *md5PW = [self.pwTextField.text MD5Hash];
    [self showLoadingHUDWithText:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.phoneNumTextField.text forKey:@"userInfo.mobileNum"];
    [dic setValue:md5PW forKey:@"userInfo.password"];
    __block LJLooginViewController * blkSelf = self;
    [[JDDAPIs sharedJDDAPIs]loginWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        [self hideAllHUD];
        if (dict) {
            MTUser *user = [MTUser mj_objectWithKeyValues:[dict objectForKey:@"userInfo"]];
            user.password = self.pwTextField.text;
            [YYAccountTool saveAccount:user];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"login"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self sendDeviceToken];
            [[NSUserDefaults standardUserDefaults]setObject:@(0) forKey:@"loginType"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            self.LoginMannger(YES);
            [self dismissViewControllerAnimated:YES completion:nil];
            [blkSelf showHUDWithText:@"登录成功"];
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
 *  qq登录
 */
- (IBAction)qqLoginBtnClick:(UIButton *)sender {
//
//    NSArray* permissions = [NSArray arrayWithObjects:
//                            kOPEN_PERMISSION_GET_USER_INFO,
//                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                            nil];
//    [_tencentOAuth authorize:permissions inSafari:NO];
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{

}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled;
{
//     [MBProgressHUD showError:@"登录失败,请重新登录"];
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
//    [MBProgressHUD showError:@"无网络连接，请设置网络"];
}

- (void)sendDeviceToken
{
    NSString *deviceTokenstr = [[NSUserDefaults standardUserDefaults]objectForKey:kDeviceToken];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    MTUser *user = [YYAccountTool account];
    [dic setValue:user.userId forKey:@"userInfo.userId"];
    [dic setValue:deviceTokenstr forKey:@"userInfo.deviceToken"];
    [[JDDAPIs sharedJDDAPIs]updateUserInfoWithParameters:dic WithBlock:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            NSLog(@"发送devicetoken成功");
        }else{
            NSLog(@"发送devicetoken失败");
        }
    }];
}
@end










