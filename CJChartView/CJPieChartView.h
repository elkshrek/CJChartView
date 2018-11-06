//
//  CJPieChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJChartView.h"
#import "CJChartModel.h"

// 展示风格
typedef NS_OPTIONS(NSUInteger, CJPieChartShowStyle) {
    CJPieChartShowStyleNormal = 1 << 0,    // 默认效果
    CJPieChartShowStyleRate = 1 << 1,      // 占比效果，这种情况下只有一个角度小于1的扇形
    CJPieChartShowStyleRing = 1 << 2,      // 环状效果，这种情况下只有一个角度小于1的扇形(圆环)
    
};

// 选中状态风格
typedef NS_OPTIONS(NSUInteger, CJPieChartSelectStyle) {
    CJPieChartSelectStylePurfle = 1 << 0,  // 外围添加一个花边
    CJPieChartSelectStyleStrike = 1 << 1,  // 向外移动
    
};

@interface CJPieChartView : CJChartView

@property (nonatomic, weak) id <CJChartViewDelegate> cj_delegate;

@property (nonatomic, strong) NSArray *layerPieData;

@property (nonatomic, assign) CJPieChartShowStyle pieChartShowStyle;// 展示风格
@property (nonatomic, assign) CJPieChartSelectStyle pieChartSelectStyle;// 扇形区选中风格

@property (nonatomic, assign, readonly) CGFloat pieChartOuterRadius;// 外半径
@property (nonatomic, assign, readonly) CGFloat pieChartInnerRadius; // 内半径

// layerPieData  存储的单位为CJChartModel对象
- (void)setLayerPieData:(NSArray *)layerPieData;

// 刷新扇形图
- (void)refreshPieChartLayer;

// 移除扇形图层
- (void)removePieChartLayer;

@end
