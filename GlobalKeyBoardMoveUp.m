//
//
//
//
//  Created by yfc on 16/9/12.
//
//

#import "GlobalKeyBoardMoveUp.h"
#import "LikeCellView.h"
#import "UIView+Utils.h"

@interface GlobalKeyBoardMoveUp ()
@property(nonatomic,retain)UITextField *textFiled;
@end

@implementation GlobalKeyBoardMoveUp
//
//参数：textFiled输入框 theScrollow需要升降的Scrollow
//
+ (void)scrollView:(UIView *)textFiled andSuperView:(UIScrollView*)theScrollow {

    GlobalKeyBoardMoveUp *upAndDown = [[GlobalKeyBoardMoveUp alloc]init];
    upAndDown.textFiled = (UITextField*)textFiled;
    //
    //输入框的坐标转换到滚动view上
    //
    CGRect textFiledConvertFrame = [textFiled.superview convertRect:textFiled.frame toView:theScrollow];
    //
    //滚动视图活动的height
    //
    double heightWithoutKeyBoard = SCREEN_HEIGHT_NEW - [upAndDown differentKeyBoardHeight] - theScrollow.top;
    //
    //现在键盘已经展示出来了  动画时间要慢于键盘出来时间
    //
    [UIView animateWithDuration:0.3 animations:^{
        
        theScrollow.height =  heightWithoutKeyBoard;

        //
        //输入框展示不全判断条件。这是和输入框的bottom比的 实际中下方会有空白分割线等 所有减去30 为了能点到下边的输入框减70
        //
        if(textFiledConvertFrame.origin.y + textFiled.height > (heightWithoutKeyBoard - 70)){
            theScrollow.contentOffset = CGPointMake(0, textFiledConvertFrame.origin.y + textFiled.height - (heightWithoutKeyBoard - 70));
        }
    }];
}




- (double)differentKeyBoardHeight{
    //
    //新增不同的键盘计算不同的高度
    //
    double differentKeyBoardHeight = 0;
    UIView *inputView_ = _textFiled.inputView;
    NSLog(@"键盘高度%f",inputView_.height);
    //
    //密码键盘
    //
    if([_textFiled.inputView isKindOfClass:[NSClassFromString(@"iPhoneKeyboard") class]]){
        UIView *inputView =  _textFiled.inputView;
        differentKeyBoardHeight = inputView.height;
        if(IsIphoneX){
            differentKeyBoardHeight = inputView.height - 49;
        }
    }
    //
    //登录键盘
    //
    else if([_textFiled.inputView isKindOfClass:[NSClassFromString(@"iPhoneKeyboardSpaceNewStyle") class]]){
        UIView *inputView =  _textFiled.inputView;
        differentKeyBoardHeight = inputView.height;
        if(IsIphoneX){
            differentKeyBoardHeight = inputView.height - 34;
        }
    }
    //
    //iPad加密键盘
    //
    else if ([_textFiled.inputView isKindOfClass:[NSClassFromString(@"iPadKeyboard") class]]){
        UIView *inputView =  _textFiled.inputView;
        differentKeyBoardHeight = inputView.height;
    }
    //
    //系统键盘
    //
    else{
        //
        //系统键盘需要通过监听多次才能获取到真实高度
        //
        if ([_textFiled.superview respondsToSelector:@selector(getKeyBoardHeight)]) {
            differentKeyBoardHeight = [((LikeCellView*)_textFiled.superview) getKeyBoardHeight];
            if (differentKeyBoardHeight < 1) {
                differentKeyBoardHeight = 240 * HEIGHT_SCALE;
                if (IS_IPAD) {
                     differentKeyBoardHeight = 100;
                }
            }
        }else{
            differentKeyBoardHeight = 240 * HEIGHT_SCALE;
        }
        if (IsIphoneX) {
            differentKeyBoardHeight -= 34;
        }
    }
    
    //
    //inputAccessoryView也算入键盘高度  _textFiled.inputView 系统键盘是 nil
    //
    if (_textFiled.inputAccessoryView && _textFiled.inputView != nil) {
        differentKeyBoardHeight += _textFiled.inputAccessoryView.height;
    }
    return differentKeyBoardHeight;
}

@end
