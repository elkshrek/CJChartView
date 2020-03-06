//
//  CJProgressChartModel.m
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJProgressChartModel.h"

@implementation CJProgressChartModel

+ (instancetype)progressChartCurrent:(CGFloat)current total:(NSInteger)total
{
    CJProgressChartModel *model = [[[self class] alloc] init];
    model.currentProgress = current;
    model.totalProgress = total;
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
