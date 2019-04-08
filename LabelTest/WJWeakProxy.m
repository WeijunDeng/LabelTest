//
//  WJWeakProxy.m
//  Demo
//
//  Created by DengWeijun on 2019/3/28.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "WJWeakProxy.h"

@implementation WJWeakProxy

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

@end
