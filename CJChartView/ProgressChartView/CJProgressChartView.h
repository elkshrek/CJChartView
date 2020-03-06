//
//  CJProgressChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/17.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJChartView.h"

/// 仿网易云音乐等级进度条
@interface CJProgressChartView : CJChartView

@property (nonatomic, assign, readonly) NSInteger totalProgress;// 总进度
@property (nonatomic, assign, readonly) CGFloat currentProgress;// 当前进度

/// 当前进度为渐变色
/// 当前进度渐变的初始颜色  default: 0x7cdee7
@property (nonatomic, strong) UIColor *curProFromColor;
/// 当前进度渐变的结束颜色  default: 0x2e9aa3
@property (nonatomic, strong) UIColor *curProToColor;
/// 锚点颜色  default: 0x26a4af
@property (nonatomic, strong) UIColor *anchorColor;
/// 背景总进度颜色 default: 0xdcdcdc
@property (nonatomic, strong) UIColor *backProColor;

// 设置总进度和当前进度
- (void)setTotalProgress:(NSInteger)totalProgress currentProgress:(CGFloat)currentProgress;



@end
