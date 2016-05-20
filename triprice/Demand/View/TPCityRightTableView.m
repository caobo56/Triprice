//
//  TPCityRightTableView.m
//  triprice
//
//  Created by caobo56 on 16/2/26.
//
//

#import "TPCityRightTableView.h"

#define tableW (Screen_weight-(Screen_weight/750*164))
#define tableH 85


@interface CityRight : UITableViewCell

@property(nonatomic,strong)UIButton * selectBtn;

-(void)loadData:(NSDictionary *)dict;

//-(void)setSelectStyle;
//
//-(void)setUnSelectStyle;

@end

@implementation CityRight{
    UIImageView * imageView;
    UILabel * nameLable;
    UILabel * descLable;
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
    
    imageView = [[UIImageView alloc]init];
    imageView.size = CGSizeMake(83, self.height-20);
    imageView.left = 10;
    imageView.centerY = self.height/2;
    [self addSubview:imageView];
    
    descLable = [[UILabel alloc]init];
    descLable.size = CGSizeMake(self.width-imageView.right-10-30, 20);
    descLable.left = imageView.right+10;
    descLable.centerY = self.height/2;
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.textColor = [UIColor lightGrayColor];
    descLable.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:descLable];
    
    nameLable = [[UILabel alloc]init];
    nameLable.size = descLable.size;
    nameLable.left = descLable.left;
    nameLable.bottom = descLable.top;
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.textColor = HexRGBAlpha(0x26323B, 1.0);
    nameLable.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:nameLable];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * radio_s = [UIImage imageNamed:@"radio_s"];
    UIImage * radio = [UIImage imageNamed:@"radio"];
    _selectBtn.size = radio.size;
    _selectBtn.left = self.width-30;
    _selectBtn.bottom = descLable.top;
    [_selectBtn setImage:radio forState:UIControlStateNormal];
    [_selectBtn setImage:radio_s forState:UIControlStateSelected];
    [self addSubview:_selectBtn];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.size = CGSizeMake(tableW-10, 1);
    lineView.left = 10;
    lineView.bottom = self.height;
    lineView.backgroundColor = cellLineColorTp;
    [self addSubview:lineView];
}

-(void)loadData:(NSDictionary *)dict{
    nameLable.text = [dict objectForKeyNotNull:@"name"];
    [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKeyNotNull:@"pic"]] placeholderImage:nil];
    
    NSString * tourist = [dict objectForKeyNotNull:@"outline"];
    descLable.text = tourist;
}

//-(void)setSelectStyle{
//    _selectBtn.selected = YES;
//}
//
//-(void)setUnSelectStyle{
//    _selectBtn.selected = NO;
//}

@end

@interface TPCityRightTableView()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation TPCityRightTableView{
    NSArray * arr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        arr = [[NSArray alloc]init];
        [self initUI];
    }
    return self;
}

-(void)loadData:(NSArray *)dataArr{
    arr = dataArr;
    [self reloadData];
}

-(void)initUI{
    self.size = CGSizeMake(tableW, Screen_height-NavBarH-StateBarH-58);
    self.backgroundColor = [UIColor whiteColor];
    self.left = Screen_weight-self.width;
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
    static NSString *cityleftCellIdentifier = @"cityleft";
    CityRight *cell = (CityRight *)[tableView dequeueReusableCellWithIdentifier:cityleftCellIdentifier];
    if (cell == nil) {
        cell = [[CityRight alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityleftCellIdentifier];
        [cell initUI];
        [cell.selectBtn addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell loadData:arr[indexPath.row]];
    cell.selectBtn.tag = indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_selectDelegate didSelectRowAtIndex:indexPath.row];
}

-(void)selectBtnPress:(id)sender{
    UIButton * btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [_selectDelegate cityRightTableViewSelectIndex:btn.tag];
    }else{
        [_selectDelegate cityRightTableViewUnSelectIndex:btn.tag];
    }
}



@end
