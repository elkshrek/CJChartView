//
//  CJProgressChartModel.h
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 进度条数据
@interface CJProgressChartModel : NSObject

@property (nonatomic, assign) CGFloat currentProgress;
@property (nonatomic, assign) NSInteger totalProgress;

+ (instancetype)progressChartCurrent:(CGFloat)current total:(NSInteger)total;

@end

NS_ASSUME_NONNULL_END
