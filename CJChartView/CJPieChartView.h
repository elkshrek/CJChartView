//
//  CJPieChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJChartView.h"


// 展示风格
typedef NS_OPTIONS(NSUInteger, CJPieChartShowStyle) {
    // 默认效果
    CJPieChartShowStyleNormal = 1 << 0,
    
    // 占比效果，这种情况下只有一个角度不大于1的扇形
    CJPieChartShowStyleRate   = 1 << 1,
    
    // 环状效果，这种情况下只有一个角度不大于1的扇形(圆环)
    CJPieChartShowStyleRing   = 1 << 2,
    
    // 类锯齿效果,扇形半径不等
    CJPieChartShowStyleJagged = 1 << 3,
    
};

// 选中状态风格
typedef NS_OPTIONS(NSUInteger, CJPieChartSelectStyle) {
    // 外围添加一个花边
    CJPieChartSelectStylePurfle = 1 << 0,
    
    // 向外移动
    CJPieChartSelectStyleStrike = 1 << 1,
    
};

@interface CJPieChartView : CJChartView

@property (nonatomic, weak) id <CJChartViewDelegate> cj_delegate;

@property (nonatomic, strong) NSArray<CJChartModel *> *layerPieData;

// 展示风格 默认CJPieChartShowStyleNormal
@property (nonatomic, assign) CJPieChartShowStyle pieChartShowStyle;

// 扇形区选中风格 默认CJPieChartSelectStylePurfle
@property (nonatomic, assign) CJPieChartSelectStyle pieChartSelectStyle;

@property (nonatomic, assign, readonly) CGFloat pieChartOuterRadius;// 外半径
@property (nonatomic, assign, readonly) CGFloat pieChartInnerRadius; // 内半径

@property (nonatomic, assign) CGFloat pieChartLineWidth; //线宽,可传入值|默认: 外半径 - 内半径


// layerPieData  存储的单位为CJChartModel对象
- (void)setLayerPieData:(NSArray<CJChartModel *> *)layerPieData;

// 刷新扇形图
- (void)refreshPieChartLayer;

// 移除扇形图层
- (void)removePieChartLayer;

@end
