//
//
//  MTextField.m
//
//  Created by mac mini on 15-4-13.
//
//
#import "MTextField.h"
#import "WTReParser.h"


@implementation MTextField


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)dealloc
{
    _lastAcceptedValue = nil;
    _parser = nil;
    
    NSLog(@"dealloc");
    
    [super dealloc];

}

- (void)setPattern:(NSString *)pattern
{
    if (pattern == nil || [pattern isEqualToString:@""])
        _parser = nil;
    else
        _parser = [[WTReParser alloc] initWithPattern:pattern];
}

- (NSString*)pattern
{
    return _parser.pattern;
}

- (void)formatInput:(UITextField *)textField

{
    
    UITextRange *range = textField.selectedTextRange;
    
    if (_parser == nil) return;
    
    __block WTReParser *localParser = _parser;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        //加上这行可以在中间删除增加，只是光标位置不对
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *formatted = [localParser reformatString:textField.text];
        
        if (formatted == nil){
            formatted = _lastAcceptedValue;
        }
        else{
            _lastAcceptedValue = formatted;
        }
        NSString *newText = formatted;
        
        
        if (![textField.text isEqualToString:newText]) {
            
            textField.text = formatted;
            
            if(_lastText){
                
                //
                //textField.text.length >= _lastText.length是在输入
                //
            if (textField.text.length >= _lastText.length) {
                //range4是原有字符串在新字符串的位置 ，如果长度是旧的长度，位置是0 则顺序输入 并且 光标不在最后
                NSRange range4 = [textField.text rangeOfString: _lastText];
                if ((range4.length == _lastText.length) && (range4.location == 0 )) {
                    NSLog(@"我在从前往后顺序输入");
                }else{
                    //还有一种在空格前面输入 输入后光标应该向后移动两位
                    UITextPosition* beginning = textField.beginningOfDocument;
                    UITextPosition* start = range.start;
                    UITextPosition* end = range.end;
                    const NSInteger location = [textField offsetFromPosition:beginning toPosition:start];
                    const NSInteger length = [textField offsetFromPosition:start toPosition:end];

                    
                    
                    NSLog(@"我在中间插入");
                    textField.selectedTextRange = range;
                    
                    
                    if (formatted.length > 0 && [[formatted substringWithRange:NSMakeRange(location-1, 1)] isEqualToString:@" "]) {
//                        NSLog(@"已经点击了删除，并且前面是空格，自动跳过空格");
                        
                        UITextPosition *start2 = [self positionFromPosition:beginning offset:location + 1];
                        UITextPosition *end2 = [self positionFromPosition:start offset:length + 1 ];
                        textField.selectedTextRange = [self textRangeFromPosition:start2 toPosition:end2];
                        
                    }
                }

            }
                //
                //textField.text.length< _lastText.length是在删除
                //
            else{
                //删除 如果从后往前一个个删除 遇到空格则自动会删除2个
                NSRange range3 = [_lastText rangeOfString:textField.text ];
                if ((range3.length == textField.text.length) && (range3.location == 0 )) {
                    NSLog(@"我在从后往前顺序删");
                }else{
                    NSLog(@"我在中间数字里面 或 在空格前面删");
                    
                    UITextPosition* beginning = textField.beginningOfDocument;
                    UITextPosition* start = range.start;
                    UITextPosition* end = range.end;
                    const NSInteger location = [textField offsetFromPosition:beginning toPosition:start];
                    const NSInteger length = [textField offsetFromPosition:start toPosition:end];
                    
                    
                    
                    textField.selectedTextRange = range;
                    
                    
                    if ( [[formatted substringWithRange:NSMakeRange(location-1, 1)] isEqualToString:@" "]) {
                        NSLog(@"已经点击了删除，并且前面是空格，自动跳过空格");
                        
                        UITextPosition *start2 = [self positionFromPosition:beginning offset:location - 1];
                        UITextPosition *end2 = [self positionFromPosition:start offset:length -1 ];
                        textField.selectedTextRange = [self textRangeFromPosition:start2 toPosition:end2];
                        
                    }
                    
                }
                
            }
        }
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
        if(_lastText)
            [_lastText release];
        _lastText = [[NSMutableString alloc]initWithString:textField.text];
        

        
    });
}
- (void)onlyFormatInput:(UITextField *)textField{
    
    //如果选的号码  再删除会崩溃
    if(_lastText)
        [_lastText release];
    _lastText = [[NSMutableString alloc]initWithFormat:@"%@",textField.text];
    
    
    if (_parser == nil) return;
    
    __block WTReParser *localParser = _parser;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *formatted = [localParser reformatString:textField.text];
        if (formatted == nil)
            formatted = _lastAcceptedValue;
        else
            _lastAcceptedValue = formatted;
        NSString *newText = formatted;
        if (![textField.text isEqualToString:newText]) {
            textField.text = formatted;
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }

    });
}

@end
