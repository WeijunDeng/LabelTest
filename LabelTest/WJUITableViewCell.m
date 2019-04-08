//
//  WJUITableViewCell.m
//  LabelTest
//
//  Created by DengWeijun on 2019/4/6.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "WJUITableViewCell.h"

@interface WJUITableViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation WJUITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.numberOfLines = 0;
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
