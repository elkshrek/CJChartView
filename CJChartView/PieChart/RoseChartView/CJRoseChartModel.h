//
//  CJRoseChartModel.h
//  CJChartExample
//
//  Created by wing on 2020/3/11.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 南丁格尔玫瑰图
@interface CJRoseChartModel : NSObject

/// 玫瑰花瓣尺寸,即图表数据  默认: 1
@property (nonatomic, assign) CGFloat petalSize;

/// 玫瑰花瓣颜色  默认: 0x26a4af
@property (nonatomic, strong) UIColor *petalColor;


/// 玫瑰花瓣数据初始化
/// @param petalSize  花瓣尺寸
/// @param petalColor 花瓣颜色，可为空，为空时默认 0x26a4af
+ (instancetype)roseWithPetal:(CGFloat)petalSize color:(UIColor *_Nullable)petalColor;



@end

NS_ASSUME_NONNULL_END
