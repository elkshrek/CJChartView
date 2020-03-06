//
//  CJPieChartModel.m
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJPieChartModel.h"

@interface CJPieChartModel ()

// 开始角度
@property (nonatomic, assign) CGFloat startAngle;
// 结束角度
@property (nonatomic, assign) CGFloat endAngle;


@end

@implementation CJPieChartModel


/// 扇形图Model
/// @param startPer 开始百分比
/// @param endPer   结束百分比
+ (instancetype)modelWithStart:(CGFloat)startPer end:(CGFloat)endPer
{
    CJPieChartModel *model = [[[self class] alloc] init];
    model.startPercentage = startPer;
    model.endPercentage = endPer;
    model.startAngle = startPer * (2 * M_PI) - M_PI_2;
    model.endAngle = endPer * (2 * M_PI) - M_PI_2;
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
