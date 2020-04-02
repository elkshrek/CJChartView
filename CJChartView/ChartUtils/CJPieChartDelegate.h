//
//  CJPieChartDelegate.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/17.
//  Copyright © 2017 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CJPieChartDelegate <NSObject>

@optional

/// 选中扇区
/// @param index 选中扇区的下标
- (void)CJPieChartDidSelected:(NSInteger)index;
/// 取消选中扇区
- (void)CJPieChartDidUnselect;



@end

NS_ASSUME_NONNULL_END
