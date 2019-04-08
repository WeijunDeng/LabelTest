//
//  WJAsyncLabelTableViewCell.h
//  LabelTest
//
//  Created by DengWeijun on 2019/4/3.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJAsyncLabelTableViewCell : UITableViewCell

@property (nonatomic, strong) NSAttributedString *string;
@property (nonatomic, assign) CGSize size;

@end

NS_ASSUME_NONNULL_END
