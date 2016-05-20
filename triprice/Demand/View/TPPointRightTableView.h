//
//  TPPointRightTableView.h
//  triprice
//
//  Created by caobo56 on 16/2/25.
//
//

#import <UIKit/UIKit.h>

@protocol TPPointRightTableViewSelectDelegate <NSObject>

-(void)pointRightTableViewSelectIndex:(NSInteger)index;

@end

@interface TPPointRightTableView : UITableView

-(void)loadData:(NSArray *)dataArr;

@property(nonatomic,weak)id<TPPointRightTableViewSelectDelegate>selectDelegate;


@end
