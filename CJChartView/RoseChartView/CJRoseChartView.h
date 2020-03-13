//
//  CJRoseChartView.h
//  CJChartExample
//
//  Created by wing on 2020/3/11.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJChartParallelDefinition.h"
#import "CJPieChartDelegate.h"
#import "CJRoseChartModel.h"


NS_ASSUME_NONNULL_BEGIN

/// 南丁格尔玫瑰图
@interface CJRoseChartView : UIView

/// CJPieChartDelegate
@property (nonatomic, weak) id <CJPieChartDelegate> cj_delegate;

/// 南丁格尔玫瑰图数据源
@property (nonatomic, strong) NSArray<CJRoseChartModel *> *layerRoseData;

/// 玫瑰花瓣选中风格 默认CJPieChartSelectStylePurfle
@property (nonatomic, assign) CJPieChartSelectStyle roseChartSelectStyle;


/// 刷新玫瑰图
/// @param animation 是否开启刷新动画
- (void)refreshRoseChartLayer:(BOOL)animation;

/// 移除玫瑰图
- (void)removeRoseChartLayer;


@end

NS_ASSUME_NONNULL_END
