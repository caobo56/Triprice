//
//  IWTextView.h

//  拥有placeholder的TextView

#import <UIKit/UIKit.h>

@interface IWTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
