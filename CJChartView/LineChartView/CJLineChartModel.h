//
//  CJLineChartModel.h
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 折现线统计图
@interface CJLineChartModel : NSObject

/// 点的x坐标值
@property (nonatomic, assign) CGFloat lineChartPointX;
/// 点的y坐标值
@property (nonatomic, assign) CGFloat lineChartPointY;
/// 当前点的下标 表示当前点是折线图上的第几个点
@property (nonatomic, assign, readonly) NSUInteger linePointIndex;
/// 上一个点到这个点的线段颜色 默认：0x26a4af
@property (nonatomic, strong) UIColor *LineColor;


/// 使用折线图的折点坐标创建数据
/// @param pointX 折点x坐标
/// @param pointY 折点y坐标
+ (instancetype)lineChartModel:(CGFloat)pointX pointY:(CGFloat)pointY;


@end

NS_ASSUME_NONNULL_END
