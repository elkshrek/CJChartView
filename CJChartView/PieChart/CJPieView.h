//
//  CJPieView.h
//  CJChartExample
//
//  Created by wing on 2020/3/30.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPieChartDelegate.h"

// 饼图、玫瑰图 选中状态风格
typedef NS_OPTIONS(NSUInteger, CJPieChartSelectStyle) {
    /// 外围添加一个花边   默认值
    CJPieChartSelectStylePurfle = 1 << 0,
    /// 向外移动
    CJPieChartSelectStyleStrike = 1 << 1,
    
};


NS_ASSUME_NONNULL_BEGIN

@interface CJPieView : UIView

/// CJPieChartDelegate
@property (nonatomic, weak) id <CJPieChartDelegate> cj_delegate;



/// 创建饼图CAShapeLayer
/// @param arcCenter  饼图中心位置
/// @param radius     饼图半径
/// @param lineWidth  饼环宽度
/// @param startAngle 开始角度
/// @param endAngle   结束角度
/// @param color      饼图颜色
/// @param clockwise  绘制方向是否顺时针
- (CAShapeLayer *)pieShapeLayerCenter:(CGPoint)arcCenter radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color clockwise:(BOOL)clockwise;



/// Strike 向外移动效果动画
/// @param shapeLayer 漂移的CAShapeLayer
/// @param fromValue  开始值
/// @param toValue    结束值
/// @param duration   动画时间
- (void)animationChartLayerStrike:(CAShapeLayer *)shapeLayer fromValue:(NSValue *)fromValue toValue:(NSValue *)toValue duration:(CGFloat)duration;




// 获取点击位置的百分位置
- (CGFloat)findPercentageOfAngleInCircle:(CGPoint)center fromPoint:(CGPoint)reference;





@end

NS_ASSUME_NONNULL_END
