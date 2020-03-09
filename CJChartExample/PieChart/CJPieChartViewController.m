//
//  CJPieChartViewController.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJPieChartViewController.h"


@interface CJPieChartViewController ()<CJChartViewDelegate>

@property (weak, nonatomic) IBOutlet CJPieChartView *pieChartView;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *chartStyleSegment;

@property (weak, nonatomic) IBOutlet UISegmentedControl *percentageStyleSegment;



@end

@implementation CJPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PieChart";
    
    
//    _pieChartView.layerPieData = @[[CJPieChartModel modelWithStart:0.f end:0.89f],
//                                   [CJPieChartModel modelWithStart:0.f end:0.77f],
//                                   [CJPieChartModel modelWithStart:0.f end:0.88f],
//                                   [CJPieChartModel modelWithStart:0.f end:0.7f],
//                                   [CJPieChartModel modelWithStart:0.f end:0.8f],
//                                   [CJPieChartModel modelWithStart:0.f end:0.95f],
//                                   [CJPieChartModel modelWithStart:0.f end:1.0f]];
    //南丁格尔玫瑰图:数据或 [CJPieChartModel modelWithStart:0.f end:1.0f]];
    _pieChartView.layerPieData = @[[CJPieChartModel modelRoseWithValue:0.89f],
                                      [CJPieChartModel modelRoseWithValue:0.77f],
                                      [CJPieChartModel modelRoseWithValue:0.88f],
                                      [CJPieChartModel modelRoseWithValue:0.7f],
                                      [CJPieChartModel modelRoseWithValue:0.8f],
                                      [CJPieChartModel modelRoseWithValue:0.95f],
                                      [CJPieChartModel modelRoseWithValue:1.0f]];
    _pieChartView.cj_delegate = self;
//    _pieChartView.pieChartType = CJPieHoopChart;
    _pieChartView.pieHoopWidth = 120;
    _pieChartView.centerTitle = @"我的财富";
    
    self.refreshButton.layer.cornerRadius = 3.f;
    self.refreshButton.layer.masksToBounds = YES;
    self.removeButton.layer.cornerRadius = 3.f;
    self.removeButton.layer.masksToBounds = YES;
    self.chartStyleSegment.tintColor = [UIColor colorWithRed:(88.f / 256.f) green:(186.f / 256.f) blue:(195.f / 256.f) alpha:1.f];
    self.percentageStyleSegment.tintColor = [UIColor colorWithRed:(88.f / 256.f) green:(186.f / 256.f) blue:(195.f / 256.f) alpha:1.f];
    
    
}

#pragma mark -- CJPieChartViewDelegate
- (void)CJPieChartDidUnselect
{
    NSLog(@"CJPieChartDidUnselect");
}
- (void)CJPieChartDidSelected:(NSInteger)index
{
    NSLog(@"CJPieChartDidSelected : index %ld", (long)index);
}

- (IBAction)refreshBtnClick:(UIButton *)sender {
    
    [self.pieChartView refreshPieChartLayer:YES];
    
}

- (IBAction)removeBtnClick:(UIButton *)sender {
    
    [self.pieChartView removePieChartLayer];
    
}

- (IBAction)pieChartStyleSegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _pieChartView.pieChartSelectStyle = CJPieChartSelectStylePurfle;
    } else if (sender.selectedSegmentIndex == 1) {
        _pieChartView.pieChartSelectStyle = CJPieChartSelectStyleStrike;
    }
}

- (IBAction)piePercentageStyleSegment:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        _pieChartView.pieChartShowStyle = CJPieChartShowStyleNormal;
        [self.chartStyleSegment setEnabled:YES];
    } else if (sender.selectedSegmentIndex == 1) {
        _pieChartView.pieChartShowStyle = CJPieChartShowStyleRate;
        [self.chartStyleSegment setEnabled:NO];
    } else if (sender.selectedSegmentIndex == 2) {
        _pieChartView.pieChartShowStyle = CJPieChartShowStyleRing;
        [self.chartStyleSegment setEnabled:NO];
    }else if(sender.selectedSegmentIndex == 3){
        _pieChartView.pieChartShowStyle = CJPieChartShowStyleJagged;
        [self.chartStyleSegment setEnabled:YES];
    }else if (sender.selectedSegmentIndex == 4)
        _pieChartView.pieChartShowStyle = CJPieChartShowStyleRose;
        [self.chartStyleSegment setEnabled:YES];
}



@end
