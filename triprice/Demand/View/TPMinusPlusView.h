//
//  TPMinusPlusView.h
//  triprice
//
//  Created by caobo56 on 16/2/20.
//
//

#import <UIKit/UIKit.h>

@interface TPMinusPlusView : UIView

@property (nonatomic,copy) NSString *title;

-(void)setTitleFocusd:(NSString *)title;
/**
 *  最小值 默认值为0
 */
-(void)setLeastValue:(int)value;
//@property (nonatomic,assign) int leastValue;
/**
 *  期望显示在label上值
 */
@property (nonatomic,assign) int exceptValue;
/**
 *  返回的数量
 */
@property (nonatomic,assign) int account;

@end
