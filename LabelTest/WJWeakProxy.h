//
//  WJWeakProxy.h
//  Demo
//
//  Created by DengWeijun on 2019/3/28.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
