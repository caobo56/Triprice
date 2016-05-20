//
//  TPFreeTravelingDetailCell.h
//  triprice
//
//  Created by caobo56 on 16/3/15.
//
//

#import <UIKit/UIKit.h>

@interface TPFreeTravelingDetailCell : UITableViewCell

-(void)initUI;

-(void)loadDataWithDict:(NSDictionary *)dict;

+(float)getDetailCellHeightWith:(NSDictionary *)dict;

@end
