//
//  CJColumnarChartModel.h
//  CJChartExample
//
//  Created by wing on 2020/3/30.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 柱状图
@interface CJColumnarChartModel : NSObject

/// 柱状图值 (Y轴值)
@property (nonatomic, assign) CGFloat value;
/// 横坐标值 (X轴值)
@property (nonatomic, assign) CGFloat abscissa;
/// 横坐标显示内容 没有值的时候直接显示abscissa值
@property (nonatomic, copy) NSString *absDescription;

/// 柱状图颜色  默认: 0x26a4af
@property (nonatomic, strong) UIColor *columnarColor;


/// 柱状图数据初始化
/// @param value          柱状图值 (Y轴值)
/// @param abscissa       横坐标值 (X轴值)
/// @param absDescription 横坐标显示内容
/// @param columnarColor  柱状图颜色 默认: 0x26a4af
+ (instancetype)columnarChartValue:(CGFloat)value abscissa:(CGFloat)abscissa absDes:(NSString * _Nullable)absDescription color:(UIColor * _Nullable)columnarColor;


@end

NS_ASSUME_NONNULL_END
