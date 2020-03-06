//
//  CJPieHoopChartView.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJPieHoopChartView.h"


#ifndef CJHexColor
#define CJHexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]
#endif

@interface CJPieHoopChartView()

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UILabel *percentageLabel;// 显示选中的百分比

@property (nonatomic, assign) CGFloat pieChartOuterRadius; // 外半径
@property (nonatomic, assign) CGFloat pieChartInnerRadius; // 内半径
@property (nonatomic, assign) CGPoint pieChartCenter;      // 中心

@property (nonatomic, strong) CAShapeLayer *selectedPieChart;// 选中的PieChart(Purfle风格启用)
@property (nonatomic, assign) NSInteger selectPicChartIndex; // 选中的PicChartIndex -1 未选中任何扇形区域

@property (nonatomic, strong) CAShapeLayer *ratePieChart;// showStyleRate风格的Layer
@property (nonatomic, strong) CAShapeLayer *ringPieChart;// showStyleRing风格的Layer

@property (nonatomic, assign) CGFloat strikeMove;   // Strike风格时候的移动距离
@property (nonatomic, assign) CGFloat purfleWidth;  // Purfle风格时候的花边宽度

// duration
@property (nonatomic, assign) CGFloat showDuration;  // Chart加载动画时长
@property (nonatomic, assign) CGFloat strikeDuration;// Strike风格的动画时间

@end

@implementation CJPieHoopChartView


- (void)configChartInfo
{
    _strikeMove = 6.f;
    _purfleWidth = 10.f;
    _strikeDuration = 0.2f;
    _showDuration = 0.6f;
    _pieChartLineWidth = 0.f;
    _selectPicChartIndex = -1;
    _selectedPieChart = nil;
    self.pieChartShowStyle = CJPieChartShowStyleNormal;
    self.pieChartSelectStyle = CJPieChartSelectStylePurfle;
    
    if (!_chartView) {
        _percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, _pieChartInnerRadius * cos(M_PI_4), _pieChartInnerRadius * sin(M_PI_4))];
        _percentageLabel.center = _pieChartCenter;
        _percentageLabel.backgroundColor = [UIColor clearColor];
        _percentageLabel.textColor = UIColor.blackColor; //CJHexColor(0x58bac3, 1.f);
        _percentageLabel.font = [UIFont systemFontOfSize:12.f];
        _percentageLabel.textAlignment = NSTextAlignmentCenter;
        _percentageLabel.userInteractionEnabled = NO;
        _percentageLabel.text = self.centerTitle;
        [self addSubview:_percentageLabel];
        _chartView = [[UIView alloc] initWithFrame:self.bounds];
        _chartView.backgroundColor = [UIColor clearColor];
        [self addSubview:_chartView];
        
    }
    [self setExclusiveTouch:YES];
}


@end

