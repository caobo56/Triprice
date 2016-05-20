//
//  TPReservationFooterView.h
//  triprice
//
//  Created by caobo56 on 16/2/18.
//
//

#import <UIKit/UIKit.h>

@interface TPReservationFooterView : UIView

-(void)setPrice:(NSString *)price;

//预订产品
@property(nonatomic,strong)UIButton * reservationBtn;

@end
