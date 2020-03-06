//
//  CJPieHoopChartView.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJPieChartView.h"


/// 环状饼图
@interface CJPieHoopChartView : CJPieChartView


/// 环宽,可设置值  默认:为20
@property (nonatomic, assign) CGFloat pieChartLineWidth;

/// 内半径 = 外半径 - 环宽(默认:20)
@property (nonatomic, assign, readonly) CGFloat pieChartInnerRadius;




@end

