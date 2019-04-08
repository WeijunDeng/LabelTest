//
//  WJAsyncLabelTableViewCell.m
//  LabelTest
//
//  Created by DengWeijun on 2019/4/3.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "WJAsyncLabelTableViewCell.h"
#import "WJAsyncLabel.h"

@interface WJAsyncLabelTableViewCell ()

@property (nonatomic, strong) WJAsyncLabel *asyncLabel;

@end

@implementation WJAsyncLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            WJAsyncLabel *label = [[WJAsyncLabel alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:label];
            self.asyncLabel = label;
        }
    }
    return self;
}

- (void)setSize:(CGSize)size
{
    _size = size;
    [self.asyncLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (void)setString:(NSAttributedString *)string
{
    _string = string;
    self.asyncLabel.string = string;
}


@end
