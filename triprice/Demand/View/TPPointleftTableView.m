//
//  TPPointleftTableView.m
//  triprice
//
//  Created by caobo56 on 16/2/25.
//
//

#import "TPPointleftTableView.h"

#define tableW (Screen_weight/750*164)
#define tableH 45

#define selectColor 0xB4BECB
#define nomorlColor 0xE5EBF0
#define bgColor     0xF1F1F1

@interface Pointleft : UITableViewCell

-(void)loadData:(NSDictionary *)dict;

-(void)setSelectStyle;

-(void)setUnSelectStyle;

@end

@implementation Pointleft{
    UILabel * nameLable;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.size = CGSizeMake(tableW, tableH);
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    nameLable = [[UILabel alloc]init];
    nameLable.size = self.size;
    nameLable.textAlignment = NSTextAlignmentRight;
    nameLable.textColor = HexRGBAlpha(0x26323B, 1.0);
    nameLable.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:nameLable];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.size = CGSizeMake(tableW, 1);
    lineView.left = 0;
    lineView.bottom = self.height;
    lineView.backgroundColor = cellLineColorTp;
    [self addSubview:lineView];
}

-(void)loadData:(NSDictionary *)dict{
    
    nameLable.text = [dict objectForKeyNotNull:@"name"];
}

-(void)setSelectStyle{
    self.backgroundColor = HexRGBAlpha(selectColor, 1.0);
}

-(void)setUnSelectStyle{
    self.backgroundColor = HexRGBAlpha(nomorlColor, 1.0);
}

@end

@interface TPPointleftTableView()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation TPPointleftTableView{
    NSArray * arr;
    NSInteger selectIndex;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        selectIndex = 0;
        arr = [[NSArray alloc]init];
        [self initUI];
    }
    return self;
}

-(void)loadData:(NSArray *)dataArr{
    arr = dataArr;
    [_selectDelegate pointleftTableViewSelectIndex:0];
    [self reloadData];
}

-(void)initUI{
    self.size = CGSizeMake(tableW, Screen_height-NavBarH-StateBarH);
    self.backgroundColor = HexRGBAlpha(bgColor, 1.0);
    self.left = 0;
    self.top = NavBarH+StateBarH;
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSelectionStyleNone;
    self.showsVerticalScrollIndicator = FALSE;
    self.showsHorizontalScrollIndicator = FALSE;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *pointleftCellIdentifier = @"lensList";
    Pointleft *cell = (Pointleft *)[tableView dequeueReusableCellWithIdentifier:pointleftCellIdentifier];
    if (cell == nil) {
        cell = [[Pointleft alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointleftCellIdentifier];
        [cell initUI];
    }
    [cell loadData:arr[indexPath.row]];
    if (selectIndex == indexPath.row) {
        [cell setSelectStyle];
    }else{
        [cell setUnSelectStyle];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath.row;
    [_selectDelegate pointleftTableViewSelectIndex:selectIndex];
    [tableView reloadData];
}



@end
