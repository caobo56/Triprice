//
//  OrderListCell.h
//  triprice
//
//  Created by MZY on 16/3/15.
//
//

#import <UIKit/UIKit.h>

typedef void(^MyAction)(NSDictionary *dic);

@interface OrderListCell : UITableViewCell
@property (nonatomic, strong) MyAction action;


-(void)createView;
-(void)setInfoWithDic:(NSDictionary *)dic;

@end
