//
//  TPCityRightTableView.h
//  triprice
//
//  Created by caobo56 on 16/2/26.
//
//

#import <UIKit/UIKit.h>

@protocol TPCityRightTableViewSelectDelegate <NSObject>

-(void)cityRightTableViewSelectIndex:(NSInteger)index;

-(void)cityRightTableViewUnSelectIndex:(NSInteger)index;

-(void)didSelectRowAtIndex:(NSInteger)index;

@end

@interface TPCityRightTableView : UITableView

-(void)loadData:(NSArray *)dataArr;

@property(nonatomic,weak)id<TPCityRightTableViewSelectDelegate>selectDelegate;


@end
