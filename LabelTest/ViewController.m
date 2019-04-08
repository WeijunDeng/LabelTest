//
//  ViewController.m
//  LabelTest
//
//  Created by DengWeijun on 2019/4/2.
//  Copyright © 2019 dengweijun. All rights reserved.
//

#import "ViewController.h"
#import "WJAsyncLabelTableViewCell.h"
#import "WJUITableViewCell.h"
#import "WJYYLabelTableViewCell.h"
#import "WJFPSMonitor.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, WJFPSMonitorDelegate>

@property (nonatomic, strong) NSArray <UITableView *> *tableTableViews;
@property (nonatomic, strong) NSArray <UILabel *> *labels;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) WJFPSMonitor *monitor;

@property (nonatomic, assign) int32_t index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    CGFloat kLabelHeight = 20;
    CGFloat kTopMargin = 20;
    if (@available(iOS 11.0, *)) {
        kTopMargin = [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top;
    }
    
    int32_t count = 1000;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = roundf(self.view.frame.size.width / 3 * scale) / scale;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int32_t i = 0; i < count; i++) {
        NSString *text = [NSString stringWithFormat:@"%@ 一二三四五六七八九十一二三四五六七八九十😀😁😂🤣😃😄😅😆😉😊😋😎😍😘🥰😗😙😚☺️🙂🤗🤩🤔🤨😐😑😶🙄😏😣😥😮🤐😯一二三四五六七八九十一二三四五六七八九十", @(i)];
        
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16],
                                     NSForegroundColorAttributeName : [UIColor greenColor]
                                     };
        
        NSAttributedString *string = [[NSAttributedString alloc]
                                      initWithString:text
                                      attributes:attributes];
        
        CGSize size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        NSDictionary *dict = @{@"string": string, @"size": [NSValue valueWithCGSize:size]};
        [array addObject:dict];
    }
    
    self.array = [array copy];
    
    NSMutableArray *viewArray = [NSMutableArray array];
    for (int32_t i = 0; i < 3; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(width * i, kTopMargin, width, self.view.frame.size.height-kTopMargin) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        if (i == 0) {
            [tableView registerClass:[WJUITableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"forCellReuseIdentifier %@", @(i)]];
        } else if (i == 1) {
            [tableView registerClass:[WJAsyncLabelTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"forCellReuseIdentifier %@", @(i)]];
        } else {
            [tableView registerClass:[WJYYLabelTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"forCellReuseIdentifier %@", @(i)]];
        }
        tableView.allowsSelection = NO;
        [self.view addSubview:tableView];
        [tableView reloadData];
        [viewArray addObject:tableView];
    }
    self.tableTableViews = [viewArray copy];
    
    {
        for (int32_t i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, self.view.frame.size.height/2, width, kLabelHeight)];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor greenColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor blackColor];
            [self.view addSubview:label];
            if (i == 0) {
                [label setText:@"UILabel"];
            } else if (i == 1) {
                [label setText:@"WJAsyncLabel"];
            } else if (i == 2) {
                [label setText:@"YYLabel"];
            }
        }
    }

    {
        NSMutableArray *viewArray = [NSMutableArray array];

        for (int32_t i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, self.view.frame.size.height/2+kLabelHeight, width, kLabelHeight)];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor greenColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor blackColor];
            [self.view addSubview:label];
            [viewArray addObject:label];
        }
        self.labels = [viewArray copy];
    }
    
    self.view.userInteractionEnabled = NO;
    
    _monitor = [[WJFPSMonitor alloc] init];
    _monitor.delegate = self;
    [_monitor startMonitor];
    
    __weak typeof(self) weakSelf = self;
    for (int32_t i = 0; i < 3; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((2 + i * 4) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.index = i;
            [weakSelf.monitor startRecord];
            UITableView *tableView = [weakSelf.tableTableViews objectAtIndex:weakSelf.index];
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((4 + i * 4) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.monitor stopRecord];
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[[self.array objectAtIndex:indexPath.row] objectForKey:@"size"] CGSizeValue];
    return size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = [self.tableTableViews indexOfObject:tableView];
    NSString *identifier = [NSString stringWithFormat:@"forCellReuseIdentifier %@", @(i)];
    CGSize size = [[[self.array objectAtIndex:indexPath.row] objectForKey:@"size"] CGSizeValue];
    NSAttributedString *string = [[self.array objectAtIndex:indexPath.row] objectForKey:@"string"];
    if (i == 0) {
        WJUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.size = size;
        cell.string = string;
        return cell;
    } else if (i == 1) {
        WJAsyncLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.size = size;
        cell.string = string;
        return cell;
    }
    
    WJYYLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.size = size;
    cell.string = string;
    return cell;
}


#pragma mark - WJFPSMonitorDelegate

- (void)monitorCurrentFPS:(int32_t)fps
{
    
}

- (void)monitorStopRecordWithMin:(int32_t)fps avg:(int32_t)avg
{
    UILabel *label = [self.labels objectAtIndex:self.index];
    [label setText:[NSString stringWithFormat:@"min=%@ avg=%@", @(fps), @(avg)]];
}

@end
