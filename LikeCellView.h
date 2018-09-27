//
//
//
//
//  Created by yfc on 17/6/1.
//

#import <UIKit/UIKit.h>

#import "MTextField.h"

#import "LikeLabel.h"

#define SCREEN_HEIGHT_DEVICE_NEW ([UIScreen mainScreen].bounds.size.height)//实际屏幕高度
#define IsIphoneX ((((SCREEN_WIDTH == 375) && (SCREEN_HEIGHT_DEVICE_NEW == 812)  ) || \
((SCREEN_WIDTH == 414) && (SCREEN_HEIGHT_DEVICE_NEW == 896)  )) ? 1 : 0)
#define SCREEN_HEIGHT_NEW (IsIphoneX ?([UIScreen mainScreen].bounds.size.height - 0 - 34) : ([UIScreen mainScreen].bounds.size.height))//屏幕展示高度(减去home键高度)
#define SCREEN_WIDTH SCREEN_WIDTH_NEW
#define SCREEN_WIDTH_NEW ([UIScreen mainScreen].bounds.size.width)
#define L_HEIGHT_SCALE ((fabs(SCREEN_HEIGHT_NEW - 480) < 0.1) ? 1 :( IS_IPAD ? 1.68 :(SCREEN_HEIGHT_NEW/568.f)) )
#define W_HEIGHT_SCALE (IsIphoneX ? (667.0/568.f) : L_HEIGHT_SCALE)//
#define IS_IPAD (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) && (SCREEN_WIDTH_NEW > 760 ))
#define IS_IPAD_12_9 (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) && (SCREEN_WIDTH_NEW == 1024))
#define HEIGHT_SCALE (IS_IPAD_12_9 ? 2.8 : W_HEIGHT_SCALE)
#define L_SCALE_FONT (IS_IPAD ? (15.537/12.0*1.2):((SCREEN_WIDTH == 320) ? 1 : ((SCREEN_WIDTH == 375 )? (14.077/12.0) : (15.537/12.0))))//20170803新
#define SCALE_FONT (IS_IPAD_12_9 ?(15.537/12.0*2.2) : L_SCALE_FONT)
#define GRAY_LOGIN_HOLDER_COLOR [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1]
#define kWeakObject(object) __weak __typeof(object) weakObject = object;
#define GRAY_LOGIN_LINE_COLOR [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]
#define KEYBOARD_HEIGHT 260.0
#define KEYBOARD_PICKET_HEIGHT 20

@interface LikeCellView : UIView<UITextFieldDelegate>

@property(nonatomic,retain)LikeLabel                 *leftLabel;
@property(nonatomic,retain)MTextField                *rightTextFiled;
@property(nonatomic,retain)UIView                    *line;

//
//创建方法
//
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)localTitle placeholder:(NSString*)localPlaceholder keyBoardType:(NSString *)keyBoardType;
//
//获取系统键盘高度
//
- (double)getKeyBoardHeight;

@end
