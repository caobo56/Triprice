//
//  DijieCell.h
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import <UIKit/UIKit.h>

typedef void(^MyDicAction)(NSDictionary *dic);


@interface DijieCell : UITableViewCell
@property (strong, nonatomic) UIButton *callBtn;
@property (strong, nonatomic) UILabel *orderLabel3;
@property (strong, nonatomic) NSDictionary *infoDic;
@property (strong, nonatomic) MyDicAction callAction;
@property (strong, nonatomic) MyDicAction commentAction;


-(void)createView;

-(void)setWithDic:(NSDictionary *)dic;


@end
