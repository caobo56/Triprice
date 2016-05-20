//
//  DestinationAddCommentVC.h
//  triprice
//
//  Created by MZY on 16/2/24.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,AddCommentViewType){
    DestinationAddCommentView,
    OrderAddCommentView
};

@interface DestinationAddCommentVC : TPBasicViewController
@property (nonatomic , assign) AddCommentViewType viewTpye;
@property (strong, nonatomic) NSDictionary *infoDic;


@end
