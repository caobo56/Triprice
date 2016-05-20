//
//  TPHomeBottomView.h
//  triprice
//
//  Created by caobo56 on 16/2/14.
//
//

#import <UIKit/UIKit.h>

@interface TPHomeBottomView : UIView

@property(nonatomic,strong)JDDCustomBtn * homeBtn;
@property(nonatomic,strong)JDDCustomBtn * destinationBtn;
@property(nonatomic,strong)JDDCustomBtn * weekendBtn;
@property(nonatomic,strong)JDDCustomBtn * mineBtn;

-(void)setCurrentVC:(UIViewController *)vc;

@end
