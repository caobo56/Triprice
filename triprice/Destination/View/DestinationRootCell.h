//
//  DestinationRootCell.h
//  triprice
//
//  Created by MZY on 16/2/20.
//
//

#import <UIKit/UIKit.h>

@interface DestinationRootCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSString *countryString;
@property (strong, nonatomic) NSString *descripString;

-(void)createView;

-(void)setWithDic:(NSDictionary *)dic;

@end
