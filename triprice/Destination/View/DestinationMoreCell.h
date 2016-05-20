//
//  DestinationMoreCell.h
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import <UIKit/UIKit.h>

@interface DestinationMoreCell : UITableViewCell{
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
