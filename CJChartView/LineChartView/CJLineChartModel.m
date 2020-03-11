//
//  CJLineChartModel.m
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJLineChartModel.h"

@interface CJLineChartModel ()

// 折线图的点index [CJLineChartView]
@property (nonatomic, assign) NSUInteger linePointIndex;

@end

@implementation CJLineChartModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 0x26a4af
        self.LineColor = [UIColor colorWithRed:(38.f / 255.f) green:(164.f / 255.f) blue:(175.f / 255.f) alpha:1.f];
    }
    return self;
}


/// 使用折线图的折点坐标创建数据
/// @param pointX 折点x坐标
/// @param pointY 折点y坐标
+ (instancetype)lineChartModel:(CGFloat)pointX pointY:(CGFloat)pointY
{
    CJLineChartModel *lineModel = [[CJLineChartModel alloc] init];
    lineModel.lineChartPointX = pointX;
    lineModel.lineChartPointY = pointY;
    return lineModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
