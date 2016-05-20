//
//  DDOtherCell.h
//  triprice
//
//  Created by MZY on 16/2/23.
//
//

#import <UIKit/UIKit.h>

@interface DDOtherCell : UITableViewCell


@property (nonatomic) BOOL hasMoney;

-(void)createView;

-(void)setWithDic:(NSDictionary *)dic;

@end
