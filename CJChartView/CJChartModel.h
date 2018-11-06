//
//  CJChartModel.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJChartModel : NSObject

// 扇形图 CJPieChartView
@property (nonatomic, assign) CGFloat startPercentage;// 开始百分比
@property (nonatomic, assign) CGFloat endPercentage;  // 结束百分比
@property (nonatomic, assign, readonly) CGFloat startAngle;// 开始角度
@property (nonatomic, assign, readonly) CGFloat endAngle;  // 结束角度
@property (nonatomic, strong) UIColor *chartColor; // 扇形区颜色

+ (instancetype)modelWithStart:(CGFloat)startPer end:(CGFloat)endPer;



// 进度条 CJProgressChartView
@property (nonatomic, assign) CGFloat currentProgress;
@property (nonatomic, assign) NSInteger totalProgress;

+ (instancetype)progressChartCurrent:(CGFloat)current total:(NSInteger)total;



// 折线图 CJLineChartView
@property (nonatomic, assign) CGFloat lineChartPointX;
@property (nonatomic, assign) CGFloat lineChartPointY;
@property (nonatomic, assign, readonly) NSUInteger linePointIndex;



@end
