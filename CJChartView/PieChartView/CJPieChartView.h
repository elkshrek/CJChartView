//
//  CJPieChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//
/// 扇形饼图
#import "CJChartView.h"
#import "CJPieChartModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 饼图样式
typedef NS_OPTIONS(NSUInteger, CJPieChartType) {
    /// 扇形饼图 默认值
    CJPieNormalChart   = 1 << 0,
    /// 环状饼图
    CJPieHoopChart     = 1 << 1,
};

/// 展示风格
typedef NS_OPTIONS(NSUInteger, CJPieChartShowStyle) {
    /// 默认效果
    CJPieChartShowStyleNormal = 1 << 0,
    /// 占比效果，这种情况下只有一个角度不大于1的扇形
    CJPieChartShowStyleRate   = 1 << 1,
    /// 环状效果，这种情况下只有一个角度不大于1的扇形(圆环)
    CJPieChartShowStyleRing   = 1 << 2,
    /// 类锯齿效果,扇形半径不等
    CJPieChartShowStyleJagged = 1 << 3,
    
};

// 选中状态风格
typedef NS_OPTIONS(NSUInteger, CJPieChartSelectStyle) {
    /// 外围添加一个花边   默认值
    CJPieChartSelectStylePurfle = 1 << 0,
    /// 向外移动
    CJPieChartSelectStyleStrike = 1 << 1,
    
};

/// 扇形饼图
@interface CJPieChartView : CJChartView

/// CJChartViewDelegate
@property (nonatomic, weak) id <CJChartViewDelegate> cj_delegate;
/// 扇形区域数据源
@property (nonatomic, strong) NSArray<CJPieChartModel *> *layerPieData;

/// 饼图样式 默认CJPieNormalChart
@property (nonatomic, assign) CJPieChartType pieChartType;
/// 展示风格 默认CJPieChartShowStyleNormal
@property (nonatomic, assign) CJPieChartShowStyle pieChartShowStyle;
/// 扇形区选中风格 默认CJPieChartSelectStylePurfle
@property (nonatomic, assign) CJPieChartSelectStyle pieChartSelectStyle;

/// 环宽 饼图样式为CJPieHoopChart时有效 默认:为20
@property (nonatomic, assign) CGFloat pieHoopWidth;
/// 外半径 ≈ self.frame.width/2
@property (nonatomic, assign, readonly) CGFloat pieChartOuterRadius;
/// 内半径 = 外半径 - 环宽
@property (nonatomic, assign, readonly) CGFloat pieChartInnerRadius;

@property (nonatomic, strong) UIColor * centerTitleColor;
@property (nonatomic, strong) NSString * centerTitle;


/// 初始化方法
/// @param frame       frame
/// @param centerTitle 中心文字
- (instancetype)initWithFrame:(CGRect)frame centerTitle:(NSString *)centerTitle;


/// 设置扇形图数据：存储的单位为CJPieChartModel对象
/// @param layerPieData CJPieChartModel对象
- (void)setLayerPieData:(NSArray<CJPieChartModel *> *)layerPieData;


/// 刷新扇形图
/// @param animation 是否开启刷新动画
- (void)refreshPieChartLayer:(BOOL)animation;

// 移除扇形图层
- (void)removePieChartLayer;



@end

NS_ASSUME_NONNULL_END
