//
//  TPReservationProductPushViewController.h
//  triprice
//
//  Created by caobo56 on 16/2/24.
//
//

#import <UIKit/UIKit.h>

@interface TPReservationProductPushViewController : TPBasicViewController

//产品ID
-(void)setPushId:(NSString *)ProductId;

//产品详情（）
-(void)setPushData:(NSDictionary *)ProductData;


@end
