//
//  CJProgressChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/17.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJChartView.h"
#import "CJChartModel.h"

@interface CJProgressChartView : CJChartView

@property (nonatomic, assign, readonly) NSInteger totalProgress;// 总进度
@property (nonatomic, assign, readonly) CGFloat currentProgress;  // 当前进度

// 设置总进度和当前进度
- (void)setTotalProgress:(NSInteger)totalProgress currentProgress:(CGFloat)currentProgress;















@end
