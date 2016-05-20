//
//  TPReservationProductDetailViewController.h
//  triprice
//
//  Created by caobo56 on 16/2/18.
//
//

#import <UIKit/UIKit.h>

@interface TPReservationProductDetailViewController : TPBasicViewController

//产品ID
-(void)setProductId:(NSString *)ProductId;

-(void)hiddenBottomBar;

-(void)setProductData:(NSDictionary *)ProductData;


@end
