//
//
//
//
//  Created by yfc on 17/6/1.
//

#import "LikeCellView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIView+Utils.h"
#import "GlobalKeyBoardMoveUp.h"

@interface LikeCellView()
@property(nonatomic,retain)NSString     *keyBoardType;
@property(nonatomic,assign)double       keyBoardHeight;
@end


@implementation LikeCellView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)localTitle placeholder:(NSString*)localPlaceholder keyBoardType:(NSString *)keyBoardType;
{
    frame = CGRectMake(0, 0, SCREEN_WIDTH_NEW, 60 * HEIGHT_SCALE);
    self = [super initWithFrame:frame];
    if (self) {
        _keyBoardType = keyBoardType;
        //
        //左标签
        //
        _leftLabel = [[LikeLabel alloc]initWithFrame:CGRectZero bgColor:[UIColor clearColor] title:localTitle titleCollor:nil fontSize:13 * SCALE_FONT cornerRadius:0];
        _leftLabel.userInteractionEnabled = NO;
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [_leftLabel sizeToFit];
        _leftLabel.centerY = frame.size.height / 2.0;
        _leftLabel.left = 32   ;
        [self addSubview:_leftLabel];
        //
        //右输入框
        //
        _rightTextFiled = [[MTextField alloc]init];
        _rightTextFiled.placeholder = localPlaceholder;
        //
        //数字键盘
        //
        if ([keyBoardType isEqualToString:@"N"] ) {
            _rightTextFiled.placeholder = localPlaceholder;
            _rightTextFiled.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        //
        //系统键盘
        //
        else if ([keyBoardType isEqualToString:@"UIKeyboardTypeDefault"]){
            _rightTextFiled.keyboardType = UIKeyboardTypeDefault;
        }else if ([keyBoardType isEqualToString:@"UIKeyboardTypeASCIICapable"]){
            _rightTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        }else if ([keyBoardType isEqualToString:@"UIKeyboardTypeNumbersAndPunctuation"]){
            _rightTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }else if ([keyBoardType isEqualToString:@"UIKeyboardTypeURL"]){
            _rightTextFiled.keyboardType = UIKeyboardTypeURL;
        }else{
            _rightTextFiled.keyboardType = UIKeyboardTypeWebSearch;
        }
        //
        //inputAccessoryView
        //
        UIButton *inputAccessoryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (200 * HEIGHT_SCALE / 4.0) * 0.8)];
        inputAccessoryView.backgroundColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:219/255.0 alpha:1];
        [inputAccessoryView setTitle:@"点击收键盘" forState:UIControlStateNormal];
        _rightTextFiled.inputAccessoryView = inputAccessoryView;
        inputAccessoryView.userInteractionEnabled = YES;
        [inputAccessoryView setTapActionWithBlock:^{
            [_rightTextFiled resignFirstResponder];
        }];
        //
        //设置placeholder
        //
        _rightTextFiled.font = [UIFont systemFontOfSize:13 * SCALE_FONT];
        NSLog(@"%@",_rightTextFiled.font);//.SFUIText-Regular
        _rightTextFiled.delegate = self;
        _rightTextFiled.height = _leftLabel.height;
        _rightTextFiled.left = _leftLabel.right + 18;
        _rightTextFiled.width = SCREEN_WIDTH_NEW - _leftLabel.left  - _rightTextFiled.left;
        _rightTextFiled.centerY = _leftLabel.centerY;
        [self addSubview:_rightTextFiled];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:localPlaceholder];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:GRAY_LOGIN_HOLDER_COLOR range:NSMakeRange(0, localPlaceholder.length)];
        _rightTextFiled.attributedPlaceholder = attributedStr;
        if (IS_IPAD) {
            _rightTextFiled.width /= 1.7;
            _rightTextFiled.centerX = SCREEN_WIDTH/2.0;
        }
        //
        //获取系统键盘高度
        //
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextFieldFrame:) name:UIKeyboardDidShowNotification object:nil];
        //
        //下横线
        //
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = GRAY_LOGIN_LINE_COLOR;
        _line.left = _leftLabel.left;
        _line.width = SCREEN_WIDTH_NEW - _leftLabel.left * 2;
        _line.height = 1;
        _line.bottom = frame.size.height - 3;
        _line.clipsToBounds = NO;
        [self addSubview:_line];
        self.clipsToBounds = NO;
        //
        //点击任何地方弹出键盘
        //
        kWeakObject(self)
        [self setTapActionWithBlock:^{
            if (weakObject.rightTextFiled.userInteractionEnabled == YES  && weakObject.rightTextFiled.enabled == YES && weakObject.rightTextFiled.hidden == NO) {
                [weakObject.rightTextFiled becomeFirstResponder];
            } else {
                
            }
        }];
        
    }
    return self;
}
//
//键盘弹起来后才会走这个方法
//
- (void)changeTextFieldFrame:(NSNotification *)noti{
    //
    //获取系统键盘高度
    //
    NSDictionary *userInfo = noti.userInfo;
    CGRect r = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyBoardHeight = r.size.height;
    if([self.rightTextFiled isFirstResponder]){
        [self textFieldDidBeginEditing:_rightTextFiled];
    }
}
//
//获取系统键盘高度
//
- (double)getKeyBoardHeight{
    return _keyBoardHeight;
}
#pragma mark - 输入框的代理事件
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [GlobalKeyBoardMoveUp scrollView:textField andSuperView:self.superview  ];
    }
}
//
//收键盘
//
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [UIView animateWithDuration:0.3 animations:^{
            [(UIScrollView *)self.superview setContentOffset:CGPointMake(0, 0)];
            [(UIScrollView *)self.superview setSize:CGSizeMake(SCREEN_WIDTH_NEW, SCREEN_HEIGHT_NEW)];
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"输入框真实数据已清空");
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //
    //系统键盘才会走这个方法
    //其实判断右边是select就行
    //将选取框作为键盘弹出 不能复制粘贴编辑
    //
    if ([self.leftLabel.text isEqualToString:@"类型："]) {
        return NO;
    }else if ([self.leftLabel.text isEqualToString:@"号码："]){
        if (textField.text.length >= 20){
            return NO;
        }
    }
    return YES;
}
- (void)dealloc{
    //
    //获取系统键盘高度
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc");
}
@end
