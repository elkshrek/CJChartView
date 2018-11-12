//
//  CJPieChartViewController.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJPieChartViewController.h"
#import "CJPieChartView.h"


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
    
    
    _pieChartView.layerPieData = @[[CJChartModel modelWithStart:0.f end:0.4f],
                                   [CJChartModel modelWithStart:0.4f end:0.7f],
                                   [CJChartModel modelWithStart:0.7f end:0.8f],
                                   [CJChartModel modelWithStart:0.8f end:0.95f],
                                   [CJChartModel modelWithStart:0.95f end:1.0f]];
    _pieChartView.cj_delegate = self;
    
    
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
    
    [self.pieChartView refreshPieChartLayer];
    
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
    }
    
}



@end
