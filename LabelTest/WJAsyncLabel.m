//
//  WJAsyncLabel.m
//  LabelTest
//
//  Created by DengWeijun on 2019/4/3.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "WJAsyncLabel.h"

@interface WJAsyncLabel ()

@property (nonatomic, assign) BOOL needDraw;

@end

@implementation WJAsyncLabel

- (void)setFrame:(CGRect)frame {
    if (!CGRectEqualToRect(self.frame, frame)) {
        _needDraw = YES;
        self.layer.contents = nil;
        [self setNeedsLayout];
    }
    
    [super setFrame:frame];
}


- (void)setString:(NSAttributedString *)string {
    _string = string;
    
    _needDraw = YES;
    self.layer.contents = nil;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_needDraw) {
        _needDraw = NO;
        CGRect frame = self.frame;
        CGFloat scale = UIScreen.mainScreen.scale;
        NSAttributedString *string = self.string;
        __weak typeof(self) weakSelf = self;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
            [string drawInRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            if (!weakSelf.needDraw) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    weakSelf.layer.contents = (__bridge id _Nullable)(image.CGImage);
                });
            }
            
        });
    }
}


@end
