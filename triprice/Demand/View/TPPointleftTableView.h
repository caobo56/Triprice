//
//  TPPointleftTableView.h
//  triprice
//
//  Created by caobo56 on 16/2/25.
//
//

#import <UIKit/UIKit.h>

@protocol TPPointleftTableViewSelectDelegate <NSObject>

-(void)pointleftTableViewSelectIndex:(NSInteger)index;

@end

@interface TPPointleftTableView : UITableView

-(void)loadData:(NSArray *)dataArr;

@property(nonatomic,weak)id<TPPointleftTableViewSelectDelegate>selectDelegate;


@end
