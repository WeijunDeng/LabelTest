//
//  WJFPSMonitor.h
//  LabelTest
//
//  Created by DengWeijun on 2019/4/6.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WJFPSMonitorDelegate <NSObject>

- (void)monitorCurrentFPS:(int32_t)fps;
- (void)monitorStopRecordWithMin:(int32_t)fps avg:(int32_t)avg;

@end

@interface WJFPSMonitor : NSObject

@property (nonatomic, weak) id <WJFPSMonitorDelegate> delegate;

- (void)startMonitor;
- (void)stopMonitor;
- (void)startRecord;
- (void)stopRecord;

@end

NS_ASSUME_NONNULL_END
