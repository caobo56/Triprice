//
//  TPFreeTravelingCell.h
//  triprice
//
//  Created by caobo56 on 16/3/6.
//
//

#import <UIKit/UIKit.h>

@interface TPFreeTravelingCell : UITableViewCell{
    UIImageView * bgView;
    UILabel * nameLable;
    UIView *lineView;
    UILabel * descLable;
    UILabel * timeLabel;
    UILabel *moneyLabel;
}


-(void)createView;

-(void)setWithDic:(NSDictionary *)dict;

@end
