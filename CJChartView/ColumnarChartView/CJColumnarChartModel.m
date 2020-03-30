//
//  CJColumnarChartModel.m
//  CJChartExample
//
//  Created by wing on 2020/3/30.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJColumnarChartModel.h"

@implementation CJColumnarChartModel


/// 柱状图数据初始化
+ (instancetype)columnarChartValue:(CGFloat)value abscissa:(CGFloat)abscissa absDes:(NSString * _Nullable)absDescription color:(UIColor * _Nullable)columnarColor
{
    CJColumnarChartModel *chartModel = [[CJColumnarChartModel alloc] init];
    chartModel.value = value;
    chartModel.abscissa = abscissa;
    chartModel.absDescription = absDescription ?: @"";
    chartModel.columnarColor = columnarColor;
    
    return chartModel;
}





@end
