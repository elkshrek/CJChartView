//
//  CJRootViewController.m
//  CJChartExample
//
//  Created by Jonathan on 2018/11/8.
//  Copyright © 2018年 Jonathan. All rights reserved.
//

#import "CJRootViewController.h"
#import "CJPieChartViewController.h"
#import "CJProgressChartViewController.h"
#import "CJNightRoseViewController.h"

@interface CJRootViewController ()


@property (weak, nonatomic) IBOutlet CJProgressChartView *progressView;

- (IBAction)PieChartButton:(UIButton *)sender;

- (IBAction)ProgressChartButton:(UIButton *)sender;


@end

@implementation CJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chart";
    
    [_progressView setTotalProgress:10 currentProgress:6.6f];
    
    
}

- (IBAction)PieChartButton:(UIButton *)sender
{
    
    CJPieChartViewController *pieChartVC = [[CJPieChartViewController alloc] init];
    [self.navigationController pushViewController:pieChartVC animated:YES];
    
}

- (IBAction)ProgressChartButton:(UIButton *)sender
{
    
    CJProgressChartViewController *progressChartVC = [[CJProgressChartViewController alloc] init];
    [self.navigationController pushViewController:progressChartVC animated:YES];
    
}

- (IBAction)roseChartButton:(UIButton *)sender
{
    CJNightRoseViewController *roseVC = [[CJNightRoseViewController alloc] init];
    [self.navigationController pushViewController:roseVC animated:YES];
    
}



@end
