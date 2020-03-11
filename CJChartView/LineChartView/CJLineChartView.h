//
//  CJLineChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/21.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJLineChartModel.h"


/// 折现线统计图
@interface CJLineChartView : UIView


/// 折线图开始的点坐标 默认: (0, 0)
@property (nonatomic, assign) CGPoint lineBeginPoint;

/// 折线的粗细度  默认: 2.f
@property (nonatomic, assign) CGFloat lineWidth;

/// 折线图的点数据源
@property (nonatomic, strong, readonly) NSArray<CJLineChartModel *> *linePointData;


/// 设置折现图的数据
/// @param linePointData 折线图折点信息数据
/// @param animation     是否开启绘制动画
- (void)setLinePointData:(NSArray<CJLineChartModel *> *)linePointData animation:(BOOL)animation;




@end
