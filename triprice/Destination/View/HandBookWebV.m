//
//  HandBookWebV.m
//  triprice
//
//  Created by MZY on 16/2/26.
//
//

#import "HandBookWebV.h"

@implementation HandBookWebV


-(id)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic{
    self = [super initWithFrame:frame];
    if (self) {
        _infoDic = dic;
        [self createView];
    }
    return self;
}

-(void)createView{
    self.backgroundColor = [UIColor whiteColor];
//    self.delegate = self;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self getRequest];
}


-(void)refreshHtml:(NSString *)urlString{
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *requestURL = [[NSURL alloc]initWithString:urlString];

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [self loadRequest:request];
}


-(void)getRequest{

    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:_infoDic[@"code"] forKey:@"code"];
    NSString *string = @"destination/searchGuideHtml.do?code=";
    NSString *code = [NSString stringWithFormat:@"%d",[_infoDic[@"code"] intValue]];
    string = [string stringByAppendingString:code];

    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:string] withParameters:nil callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            NSString *url = nil;
            if ([dict[@"isSuccess"] intValue]) {
                url = [dict objectForKeyNotNull:@"datas"];
                if (url) {
                    [self refreshHtml:url];
                }
            }
        }else{

        }
    }];
}

@end
