//
//
//
//
//  Created by yfc on 16/9/11.
//
//

#import "LikeLabel.h"

@implementation LikeLabel
- (instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title_ titleCollor:(UIColor *)tColor fontSize:(CGFloat)size cornerRadius:(CGFloat)radius;{
    self = [super initWithFrame:frame];
    if (self) {
        if (bgColor) {
            self.backgroundColor = bgColor;
        }else{
            self.backgroundColor = [UIColor clearColor];
        }
        if (title_.length > 0) {
            self.text = title_;
        }else{
            self.text = @"";
        }
        if (tColor) {
            self.textColor = tColor;
        }else{
            self.textColor = [UIColor  blackColor];
        }
        if (size > 0) {
            self.font = [UIFont systemFontOfSize:size];
        }else{
            self.font = [UIFont systemFontOfSize:12];
        }
        if (radius > 0) {
            self.layer.cornerRadius = radius;
        }
    }
    return self;
}
- (void)dealloc{

}

@end
