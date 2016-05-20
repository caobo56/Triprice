//
//  DestinationDetailVC.h
//  triprice
//
//  Created by MZY on 16/2/22.
//
//

#import <UIKit/UIKit.h>




@interface DestinationDetailVC : TPBasicViewController
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSDictionary *infoDic;

@end
