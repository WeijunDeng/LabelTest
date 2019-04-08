//
//  WJFPSMonitor.m
//  LabelTest
//
//  Created by DengWeijun on 2019/4/6.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "WJFPSMonitor.h"
#import "WJWeakProxy.h"
#import <UIKit/UIKit.h>

@interface WJFPSMonitor ()
{
    CADisplayLink *_timer;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    
    int32_t _minFPS;
    int32_t _sumFPS;
    int32_t _sum;
    BOOL _isRecording;
}
@end

@implementation WJFPSMonitor

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [self stopMonitor];
}

- (void)startMonitor
{
    if (!_timer) {
        _timer = [CADisplayLink displayLinkWithTarget:[[WJWeakProxy alloc] initWithTarget:self] selector:@selector(onTimerFirer:)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopMonitor
{
    [_timer invalidate];
    _timer = nil;
}

- (void)startRecord
{
    _minFPS = 60;
    _sumFPS = 0;
    _sum = 0;
    _isRecording = YES;
}

- (void)stopRecord
{
    _isRecording = NO;
    int32_t avg = (round)(_sumFPS * 1.0 / _sum);
    [_delegate monitorStopRecordWithMin:_minFPS avg:avg];
}

- (void)onTimerFirer:(CADisplayLink *)link
{
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    int32_t fps = (round)(_count / delta);
    _count = 0;
    if (_isRecording) {
        _minFPS = MIN(_minFPS, fps);
        _sumFPS += fps;
        _sum++;
    }
    
    [_delegate monitorCurrentFPS:fps];
}


@end
