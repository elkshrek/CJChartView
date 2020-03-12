//
//  CJNightRoseViewController.m
//  CJChartExample
//
//  Created by wing on 2020/3/12.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJNightRoseViewController.h"

@interface CJNightRoseViewController ()<CJPieChartDelegate>

@property (nonatomic, strong) CJRoseChartView *roseChartView;

@property (nonatomic, strong) UILabel *selectLabel;
@property (nonatomic, strong) UISegmentedControl *selectStyleSegment;

@end

@implementation CJNightRoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RoseChart";
    
    [self configSubview];
    
    
}

- (void)configSubview
{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.roseChartView];
    [self.view addSubview:self.selectLabel];
    [self.view addSubview:self.selectStyleSegment];
    
    NSArray *roseArray = @[[CJRoseChartModel roseWithPetal:69.3f color:nil]
                           ,[CJRoseChartModel roseWithPetal:32.43f color:nil]
                           ,[CJRoseChartModel roseWithPetal:89.17f color:nil]
                           ,[CJRoseChartModel roseWithPetal:40.06f color:nil]
                           ,[CJRoseChartModel roseWithPetal:98.3f color:nil]
                           ,[CJRoseChartModel roseWithPetal:67.7f color:nil]
                           ,[CJRoseChartModel roseWithPetal:78.36f color:nil]
                           ,[CJRoseChartModel roseWithPetal:51.53f color:nil]
                           ,[CJRoseChartModel roseWithPetal:15.89f color:nil]];
    self.roseChartView.layerRoseData = roseArray;
    
}


- (void)selStyleSegmentAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.roseChartView.roseChartSelectStyle = CJPieChartSelectStylePurfle;
    } else if (sender.selectedSegmentIndex == 1) {
        self.roseChartView.roseChartSelectStyle = CJPieChartSelectStyleStrike;
    }
}

- (CJRoseChartView *)roseChartView
{
    return _roseChartView ?: ({
        _roseChartView = [[CJRoseChartView alloc] initWithFrame:CGRectMake(35.f, 95.f, [UIScreen mainScreen].bounds.size.width - 70.f, [UIScreen mainScreen].bounds.size.width - 70.f)];
        _roseChartView.cj_delegate = self;
        _roseChartView;
    });
}
- (UILabel *)selectLabel
{
    return _selectLabel ?: ({
        _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.f, CGRectGetMaxY(self.roseChartView.frame) + 20.f, CGRectGetWidth(self.roseChartView.frame), 18.f)];
        _selectLabel.text = @"玫瑰花瓣选中效果";
        _selectLabel.textColor = CJHexColor(0x26a4af, 1.f);
        _selectLabel.font = [UIFont systemFontOfSize:12.f];
        _selectLabel;
    });
}
- (UISegmentedControl *)selectStyleSegment
{
    return _selectStyleSegment ?: ({
        _selectStyleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Purfle", @"Strike"]];
        _selectStyleSegment.frame = CGRectMake(35.f, CGRectGetMaxY(self.selectLabel.frame) + 5.f, CGRectGetWidth(self.roseChartView.frame), 32.f);
        [_selectStyleSegment setSelectedSegmentIndex:0];
        [_selectStyleSegment addTarget:self action:@selector(selStyleSegmentAction:) forControlEvents:UIControlEventTouchUpInside];
        _selectStyleSegment;
    });
}

@end
