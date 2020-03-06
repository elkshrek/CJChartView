//
//  CJPieChartModel.h
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 扇形图数据
@interface CJPieChartModel : NSObject

/// 开始百分比
@property (nonatomic, assign) CGFloat startPercentage;
/// 结束百分比
@property (nonatomic, assign) CGFloat endPercentage;
/// 开始角度
@property (nonatomic, assign, readonly) CGFloat startAngle;
/// 结束角度
@property (nonatomic, assign, readonly) CGFloat endAngle;
/// 扇形区颜色   默认为: 0x26a4af
@property (nonatomic, strong) UIColor *chartColor;


/// 务必使用此方法生成数据模型
/// @param startPer 开始百分比
/// @param endPer   结束百分比
+ (instancetype)modelWithStart:(CGFloat)startPer end:(CGFloat)endPer;



@end

NS_ASSUME_NONNULL_END
