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
    return [CJPieChartModel modelWithStart:startPer end:endPer color:nil];
}
/// 务必使用此方法生成数据模型
/// @param startPer 开始百分比
/// @param endPer   结束百分比
/// @param color    扇形区颜色
+ (instancetype)modelWithStart:(CGFloat)startPer end:(CGFloat)endPer color:(UIColor * _Nullable)color
{
    CJPieChartModel *model = [[[self class] alloc] init];
    model.startPercentage = startPer;
    model.endPercentage = endPer;
    model.startAngle = startPer * (2 * M_PI) - M_PI_2;
    model.endAngle = endPer * (2 * M_PI) - M_PI_2;
    model.chartColor = color;
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)new
{
    return [super new];
}


@end
