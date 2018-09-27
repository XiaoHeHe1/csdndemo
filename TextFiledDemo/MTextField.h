//
//
//  MTextField.h
//
//  Created by mac mini on 15-4-13.
//
//
#import <UIKit/UIKit.h>
@class WTReParser;


@interface MTextField : UITextField
{
    NSString *_lastAcceptedValue;
    WTReParser *_parser;
}

@property (strong, nonatomic) NSString *pattern;
@property (strong, nonatomic) NSMutableString *lastText;
//
//由于边输入边匹配
//
- (void)formatInput:(UITextField *)textField;
//
//用于一次性变成想要展示的格式
//
- (void)onlyFormatInput:(UITextField *)textField;

@end
