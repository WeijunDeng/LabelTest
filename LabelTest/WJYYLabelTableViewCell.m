//
//  WJYYLabelTableViewCell.m
//  LabelTest
//
//  Created by DengWeijun on 2019/4/6.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "WJYYLabelTableViewCell.h"
#import "YYLabel.h"


@interface WJYYLabelTableViewCell ()

@property (nonatomic, strong) YYLabel *label;

@end

@implementation WJYYLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            YYLabel *label = [[YYLabel alloc] initWithFrame:CGRectZero];
            label.numberOfLines = 0;
            label.displaysAsynchronously = YES;
            [self.contentView addSubview:label];
            self.label = label;
        }
    }
    return self;
}

- (void)setSize:(CGSize)size
{
    _size = size;
    [self.label setFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (void)setString:(NSAttributedString *)string
{
    _string = string;
    [self.label setAttributedText:string];
}


@end
