//
//  IWTextView.m//

#import "IWTextView.h"
#import "UIView+Extension.h"

@interface IWTextView()
@property (nonatomic, weak) UILabel *placelabel;
@end

@implementation IWTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加label
        UILabel *placelabel = [[UILabel alloc] init];
        placelabel.x = 5;
        placelabel.y = 5;
        placelabel.numberOfLines = 0;
        placelabel.font = self.font;
        placelabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placelabel];
        self.placelabel = placelabel;
        
        // 2.监听自己文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 1.添加label
        UILabel *placelabel = [[UILabel alloc] init];
        placelabel.x = 5;
        placelabel.centerY = self.height/2;
        placelabel.numberOfLines = 0;
        placelabel.font = self.font;
        placelabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placelabel];
        self.placelabel = placelabel;
        
        // 2.监听自己文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;

}
//- (void)awakeFromNib
//{
//    // 1.添加label
//    UILabel *placelabel = [[UILabel alloc] init];
//    placelabel.x = 5;
//    placelabel.y = 5;
//    placelabel.numberOfLines = 0;
//    placelabel.font = self.font;
//    placelabel.textColor = [UIColor lightGrayColor];
//    [self addSubview:placelabel];
//    self.placelabel = placelabel;
//    
//    // 2.监听自己文字的改变
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
//}
/**
 *  文字改变了
 */
- (void)textChange
{
    if (self.text.length) { // 有文字
        self.placelabel.hidden = YES;
    } else {  // 没有文字
        self.placelabel.hidden = NO;
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    // 设置占位文字
    self.placelabel.text = placeholder;
    // 计算label的尺寸
    CGSize labelMaxSize = CGSizeMake(self.width, MAXFLOAT);
    CGSize labelSize = [placeholder sizeWithFont:self.placelabel.font constrainedToSize:labelMaxSize];
    self.placelabel.size = labelSize;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placelabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placelabel.font = font;
}

@end
