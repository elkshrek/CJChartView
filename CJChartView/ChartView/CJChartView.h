//
//  CJChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/17.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CJChartViewDelegate <NSObject>

@optional

// PieChartViewDelegate
- (void)CJPieChartDidSelected:(NSInteger)index;
- (void)CJPieChartDidUnselect;


@end

@interface CJChartView : UIView


@end
