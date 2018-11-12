//
//  CJChartModel.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJChartModel.h"

@interface CJChartModel()

// 开始角度 [CJPieChartView]
@property (nonatomic, assign) CGFloat startAngle;
// 结束角度 [CJPieChartView]
@property (nonatomic, assign) CGFloat endAngle;

// 折线图的点index [CJLineChartView]
@property (nonatomic, assign) NSUInteger linePointIndex;




@end

@implementation CJChartModel


// 扇形图Model
+ (CJChartModel *)modelWithStart:(CGFloat)startPer end:(CGFloat)endPer
{
    CJChartModel *model = [[[self class] alloc] init];
    model.startPercentage = startPer;
    model.endPercentage = endPer;
    model.startAngle = startPer * (2 * M_PI) - M_PI_2;
    model.endAngle = endPer * (2 * M_PI) - M_PI_2;
    model.chartColor = [UIColor greenColor];
    return model;
}


// 
+ (instancetype)progressChartCurrent:(CGFloat)current total:(NSInteger)total
{
    CJChartModel *model = [[[self class] alloc] init];
    model.currentProgress = current;
    model.totalProgress = total;
    return model;
}











- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
