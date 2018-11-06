//
//  CJChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/17.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CJHexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]

@protocol CJChartViewDelegate <NSObject>

@optional

// PieChartViewDelegate
- (void)CJPieChartDidSelected:(NSInteger)index;
- (void)CJPieChartDidUnselect;




@end



@interface CJChartView : UIView

@end
