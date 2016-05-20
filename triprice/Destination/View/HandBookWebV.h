//
//  HandBookWebV.h
//  triprice
//
//  Created by MZY on 16/2/26.
//
//

#import <UIKit/UIKit.h>

@interface HandBookWebV : UIWebView

@property (strong, nonatomic) NSDictionary *infoDic;

-(id)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic;

@end
