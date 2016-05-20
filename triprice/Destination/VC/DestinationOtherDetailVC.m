//
//  DestinationOtherDetailVC.m
//  triprice
//
//  Created by MZY on 16/2/23.
//
//

#import "DestinationOtherDetailVC.h"
#import "TPWeekRecommendTopView.h"
#import "DestinationCommentCell.h"
#import "DestinationAddCommentVC.h"
#import "TPLoginMaster.h"

@interface OtherDetailHeadCell : UITableViewCell

@property (strong, nonatomic) UIButton *writeBtn;
@property (strong, nonatomic) UIImageView *bgImage;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) NSMutableArray *images;

-(void)setWithDic:(NSDictionary *)dic;

-(void)createView;

@end

@implementation OtherDetailHeadCell

-(void)createView{

    _images = [[NSMutableArray alloc]initWithCapacity:0];

    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_weight, rateLangth(200))];
    [self addSubview:_bgImage];

    _nameLabel = [UILabel createWithFrame:CGRectMake(0, 0, Screen_weight, 16) withFont:16 withTextAligment:NSTextAlignmentCenter withTextColor:HexRGBAlpha(0x26323B, 1.0)];
    _nameLabel.top = _bgImage.bottom+15;
    [self addSubview:_nameLabel];

    for (int i = 0; i<5; i++) {
        UIImageView *xingxing = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
        xingxing.left = 35 + i*16;
        xingxing.top = _nameLabel.bottom+17;
        [_images addObject:xingxing];
        [self addSubview:xingxing];
    }

    _commentLabel = [UILabel createWithFrame:CGRectMake(0, 0, 150, 13) withFont:13 withTextAligment:NSTextAlignmentRight withTextColor:HexRGBAlpha(0x26323B, 1.0)];
    _commentLabel.top = _nameLabel.bottom+16;
    _commentLabel.right = Screen_weight - 62;
    [self addSubview:_commentLabel];

    _writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_writeBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    _writeBtn.frame = CGRectMake(0, 0, 15, 20);
    _writeBtn.centerY = _commentLabel.centerY;
    _writeBtn.left = _commentLabel.right+5;
    [self addSubview:_writeBtn];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 0, Screen_weight - 20, 1)];
    line.backgroundColor = cellLineColorTp;
    line.bottom = rateLangth(200)+80;
    [self addSubview:line];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setWithDic:(NSDictionary *)dic{
    [_bgImage setImageWithURL:[NSURL URLWithString:[dic objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    _nameLabel.text = [dic objectForKeyNotNull:@"name"];

    float score = [[dic objectForKeyNotNull:@"score"] floatValue];
    for (int i = 1; i<6 ; i++) {
        UIImageView *xingxing = _images[i-1];
        if (i == score) {
            xingxing.image = [UIImage imageNamed:@"d_star"];
        }else{
            if (i<score) {
                xingxing.image = [UIImage imageNamed:@"d_star"];
            }else{
                if (i == score + 0.5) {
                    xingxing.image = [UIImage imageNamed:@"d_star_n"];
                }else{
                    xingxing.image = [UIImage imageNamed:@"d_star_p"];
                }
            }
        }
    }
    _commentLabel.text = [NSString stringWithFormat:@"%d 添加评论",[dic[@"discussCnt"] intValue]];
}

@end

@interface OtherDetailInfoCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UIView *line;

+(CGFloat)getHeightCellWithString:(NSString *)string;
-(void)setWithDic:(NSDictionary *)dic;

@end

@implementation OtherDetailInfoCell

-(void)createView{
    _nameLabel = [UILabel createWithFrame:CGRectMake(10, 0, 100, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:HexRGBAlpha(0x26323B, 1.0)];
    _nameLabel.top = 10;
    [self addSubview:_nameLabel];

    _infoLabel = [UILabel createWithFrame:CGRectMake(10, 0, Screen_weight - 25, 14) withFont:14 withTextAligment:NSTextAlignmentLeft withTextColor:lightTextColor];
    _infoLabel.top = _nameLabel.bottom+10;
    _infoLabel.numberOfLines = 0;
    _infoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_infoLabel];

    _line = [[UIView alloc]initWithFrame:CGRectMake(10, 0, Screen_weight - 20, 1)];
    _line.backgroundColor = cellLineColorTp;
    _line.bottom = 44;
    [self addSubview:_line];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)setWithDic:(NSDictionary *)dic{
    _nameLabel.text = dic[@"name"];

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 3;

    NSString *string = dic[@"message"];
    if ([string isKindOfClass:[NSNumber class]]) {
        string = [NSString stringWithFormat:@"%d",[string intValue]];
    }

    NSAttributedString *att = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style}];
    _infoLabel.attributedText = att;

    _infoLabel.height = [OtherDetailInfoCell getHeightCellWithString:dic[@"message"]];
    _line.top = _infoLabel.bottom+10;
}

+(CGFloat)getHeightCellWithString:(NSString *)string{

    if ([string isKindOfClass:[NSNumber class]]) {
        string = [NSString stringWithFormat:@"%d",[string intValue]];
    }

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 3;
    CGSize size2 = [string boundingRectWithSize:CGSizeMake(Screen_height-25, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style} context:nil].size;
    return size2.height;
}

@end



@interface DestinationOtherDetailVC ()<UITableViewDataSource,UITableViewDelegate>{
    TPWeekRecommendTopView *topView;
    UIView *footerView;
    NSInteger page;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *commentArray;
@end

@implementation DestinationOtherDetailVC

-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];
    topView = [[TPWeekRecommendTopView alloc]init];
    [topView setBackBtnTitle:@"返回"];
    [topView.backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    [topView setTitle:self.title];

    _tableView = [[UITableView alloc]init];
    _tableView.size = CGSizeMake(Screen_weight, Screen_height-topView.height);
    _tableView.origin = CGPointMake(0, topView.bottom);
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    footerView = [[UIView alloc]init];
    footerView.size = CGSizeMake(Screen_weight, 50);
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel * footerLable = [[UILabel alloc]init];
    footerLable.size = footerView.size;
    footerLable.textAlignment = NSTextAlignmentCenter;
    footerLable.text = @"已加载完毕";
    footerLable.font = [UIFont systemFontOfSize:12.0f];
    [footerView addSubview:footerLable];

    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getComment];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _commentArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self createView];
    page = 0;
    [self getRequest];
    [self getComment];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addComment{

    DestinationOtherDetailVC *__weak weakSelf = self;

    if([TPLoginMaster isLogin]){
        DestinationAddCommentVC *addComment = [[DestinationAddCommentVC alloc]init];
        addComment.infoDic = weakSelf.infoDic;
        addComment.viewTpye = DestinationAddCommentView;
        [weakSelf.navigationController pushViewController:addComment animated:YES];
    }else{
        [TPLoginMaster executionWithCurrentVC:self andBlock:^(BOOL LoginState) {
            if (LoginState) {
                DestinationAddCommentVC *addComment = [[DestinationAddCommentVC alloc]init];
                addComment.infoDic = weakSelf.infoDic;
                addComment.viewTpye = DestinationAddCommentView;
                [weakSelf.navigationController pushViewController:addComment animated:YES];
            }
        }];
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1+[_dataArray count]+ [_commentArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return rateLangth(200)+80;
    }
    if (indexPath.row <= [_dataArray count]) {
        return 44+ [OtherDetailInfoCell getHeightCellWithString:_dataArray[indexPath.row - 1][@"message"]];
    }

    if (indexPath.row == [_dataArray count]+1) {
        return 20+45+ [DestinationCommentCell getHeightCellWithString:_commentArray[indexPath.row - 1- [_dataArray count]][@"comment"]];
    }else{
        return 45+ [DestinationCommentCell getHeightCellWithString:_commentArray[indexPath.row - 1- [_dataArray count]][@"comment"]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"OtherDetailHeadCell";

        OtherDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if(cell == nil) {
            cell = [[OtherDetailHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell createView];
        }
        [cell setWithDic:_infoDic];
        [cell.writeBtn addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

    if (indexPath.row <= [_dataArray count]) {
        static NSString *cellIdentifier = @"OtherDetailInfoCell";

        OtherDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if(cell == nil) {
            cell = [[OtherDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell createView];
        }
        [cell setWithDic:_dataArray[indexPath.row -1]];
        return cell;
    }

    static NSString *cellIdentifier = @"DestinationCommentCell";

    DestinationCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[DestinationCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell createView];
    }
    [cell setWithDic:_commentArray[indexPath.row - 1 - [_dataArray count]] withIsFirst:(indexPath.row== [_dataArray count]+1)];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(void)createDataArray:(NSDictionary *)dic{
    [_dataArray removeAllObjects];
    if ([dic objectForKeyNotNull:@"comment"]) {
        NSDictionary *message = @{@"name":@"概况",@"message":dic[@"comment"]};
        [_dataArray addObject:message];
    }
    if ([dic objectForKeyNotNull:@"bestTime"]) {
        NSDictionary *message = @{@"name":@"最佳游玩时间",@"message":dic[@"bestTime"]};
        [_dataArray addObject:message];
    }
    if ([dic objectForKeyNotNull:@"price"]) {
        NSDictionary *message = @{@"name":@"门票",@"message":dic[@"price"]};
        [_dataArray addObject:message];
    }
    if ([dic objectForKeyNotNull:@"playTime"]) {
        NSDictionary *message = @{@"name":@"游玩时间",@"message":dic[@"playTime"]};
        [_dataArray addObject:message];
    }
    if ([dic objectForKeyNotNull:@"address"]) {
        NSDictionary *message = @{@"name":@"地址",@"message":dic[@"address"]};
        [_dataArray addObject:message];
    }
    if ([dic objectForKeyNotNull:@"traffic"]) {
        NSDictionary *message = @{@"name":@"到达方式",@"message":dic[@"traffic"]};
        [_dataArray addObject:message];
    }
    if ([dic objectForKeyNotNull:@"openTime"]) {
        NSDictionary *message = @{@"name":@"开放时间",@"message":dic[@"openTime"]};
        [_dataArray addObject:message];
    }
}

-(void)getRequest{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:_infoDic[@"id"] forKey:@"id"];
    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:_urlString] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        if (dict) {
            if ([dict objectForKeyNotNull:@"datas"]) {
                [self createDataArray:dict[@"datas"]];
                [_tableView reloadData];
            }else{
                [_dataArray removeAllObjects];
            }
        }else{
            [_dataArray removeAllObjects];
        }
    }];

}

-(void)getComment{

    DestinationOtherDetailVC *__weak blkSelf = self;

    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:_infoDic[@"id"] forKey:@"id"];
    [dict setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"pager.pageNum"];
    [dict setValue:@"3" forKey:@"pager.pageSize"];

    [[JDDAPIs sharedJDDAPIs] postUrl:[SERVER_URL stringByAppendingString:@"destination/searchTouristComment.do"] withParameters:dict callback:^(NSDictionary *dict, NSString *error) {
        [self.tableView.mj_footer endRefreshing];
        if (dict) {
            NSArray * data = [dict objectForKeyNotNull:@"datas"];
            if (data.count == 0) {
                [blkSelf showHUDWithText:@"已加载完毕"];
                _tableView.tableFooterView = footerView;
            }else{
                page++;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_commentArray copyItems:YES];
                [arr addObjectsFromArray:data];
                _commentArray = arr;
                [_tableView reloadData];
            }
        }else{
            if (error) {
                [blkSelf showHUDWithText:error];
            } else {
                [blkSelf showHUDWithText:@"加载失败，请稍后重试"];
            }
        }
    }];

}


@end
