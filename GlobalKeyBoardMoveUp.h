//
//
//
//
//  Created by yfc on 16/9/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//
//配合键盘进行页面上升
//
@interface GlobalKeyBoardMoveUp : NSObject

//
//参数：textFiled输入框 theScrollow需要升降的Scrollow
//
+ (void)scrollView:(UIView *)textFiled andSuperView:(UIScrollView*)theScrollow;

@end
