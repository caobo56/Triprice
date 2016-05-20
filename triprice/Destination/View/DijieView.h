//
//  dijieView.h
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import <UIKit/UIKit.h>

typedef void(^MyDicAction)(NSDictionary *dic);

@interface DijieView : UIView

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *infoDic;
@property (strong, nonatomic) MyDicAction callAction;
@property (strong, nonatomic) MyDicAction commentAction;

-(id)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic;


@end
