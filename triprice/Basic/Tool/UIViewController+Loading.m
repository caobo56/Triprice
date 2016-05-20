//
//  UIViewController+Loading.m
//  jingduoduo
//
//  Created by 刁俊忠 on 15/7/6.
//  Copyright (c) 2015年 totem. All rights reserved.
//

#import "UIViewController+Loading.h"

@implementation UIViewController (Loading)


- (void)showLoadingHUDWithText:(NSString*)str
{
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = str;
    HUD.delegate = self;
    HUD.userInteractionEnabled = YES;
    HUD.position = JGProgressHUDPositionCenter;
    
    [HUD showInView:self.view];
}

- (void)showHUDWithSuccess:(NSString *)str
{
    NSArray* hudArray = [JGProgressHUD allProgressHUDsInView:self.view];
    
    if (hudArray && [hudArray count]>0) {
        JGProgressHUD* hud = [hudArray objectAtIndex:0];
        hud.indicatorView = nil;
        hud.textLabel.text = str;
        hud.position = JGProgressHUDPositionCenter;
        
        [hud dismissAfterDelay:1.0f];
    }
}

- (void)showTryLiveHUDWithText:(NSString*)str
{
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    HUD.indicatorView = nil;
    HUD.userInteractionEnabled = YES;
    HUD.textLabel.text = NSLocalizedString(str, nil);
    HUD.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    HUD.delegate = self;
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.marginInsets = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = [UIScreen mainScreen].bounds.size.height/2,
        .left = 0.0f,
        .right = 0.0f,
    };
    
    [HUD showInView:self.view];
    
    [HUD dismissAfterDelay:1.5f];
}

- (void)showHUDWithText:(NSString*)str
{
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    HUD.indicatorView = nil;
    HUD.userInteractionEnabled = YES;
    HUD.textLabel.text = NSLocalizedString(str, nil);
    HUD.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    HUD.delegate = self;
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.marginInsets = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = [UIScreen mainScreen].bounds.size.height/2,
        .left = 0.0f,
        .right = 0.0f,
    };
    
    [HUD showInView:self.view];
    
    [HUD dismissAfterDelay:0.8f];
}

- (void)hideAllHUD
{
    NSArray *huds = [JGProgressHUD allProgressHUDsInView:self.view];
    if (huds && [huds count]>0) {
        [huds enumerateObjectsUsingBlock:^(JGProgressHUD *hud, NSUInteger idx, BOOL *stop) {
            [hud dismiss];
        }];
    }
}

@end
