//
//  UIViewController+Loading.h
//  jingduoduo
//
//  Created by 刁俊忠 on 15/7/6.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@interface UIViewController (Loading)<JGProgressHUDDelegate>

- (void)showLoadingHUDWithText:(NSString*)str;
- (void)showHUDWithSuccess:(NSString *)str;
- (void)showHUDWithText:(NSString*)str;
- (void)showTryLiveHUDWithText:(NSString*)str;
- (void)hideAllHUD;

@end
