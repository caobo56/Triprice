//
//  DestinationCommentCell.h
//  triprice
//
//  Created by MZY on 16/2/24.
//
//

#import <UIKit/UIKit.h>

@interface DestinationCommentCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UIView *firstView;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UIView *line;


-(void)createView;

-(void)setWithDic:(NSDictionary *)dic withIsFirst:(BOOL)isFirst;

+(CGFloat)getHeightCellWithString:(NSString *)string;

@end
