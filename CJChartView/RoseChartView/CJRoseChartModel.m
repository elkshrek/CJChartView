//
//  CJRoseChartModel.m
//  CJChartExample
//
//  Created by wing on 2020/3/11.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJRoseChartModel.h"

@implementation CJRoseChartModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.petalSize = 1.f;
    }
    return self;
}


/// 玫瑰花瓣数据初始化
/// @param petalSize 花瓣尺寸
+ (instancetype)roseWithPetal:(CGFloat)petalSize color:(UIColor *)petalColor
{
    CJRoseChartModel *roseModel = [[CJRoseChartModel alloc] init];
    roseModel.petalSize = petalSize;
    roseModel.petalColor = petalColor;
    return roseModel;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
