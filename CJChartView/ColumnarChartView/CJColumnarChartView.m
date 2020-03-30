//
//  CJColumnarChartView.m
//  CJChartExample
//
//  Created by wing on 2020/3/30.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJColumnarChartView.h"


@interface CJColumnarChartView ()

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UIView *anchorView;

/// 柱状图数据源
@property (nonatomic, strong) NSArray<CJColumnarChartModel *> *layerColData;

/// 高亮状态
@property (nonatomic, strong) UIView *highlightView;




@end

@implementation CJColumnarChartView



- (void)setLayerColData:(NSArray<CJColumnarChartModel *> *)layerColData
{
    
    _layerColData = layerColData;
}






@end
