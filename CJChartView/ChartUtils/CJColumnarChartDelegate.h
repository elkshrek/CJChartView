//
//  CJColumnarChartDelegate.h
//  CJChartExample
//
//  Created by wing on 2020/3/30.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CJColumnarChartDelegate <NSObject>


@optional

/// 选中柱状图
/// @param index 选中的柱状图下标
- (void)CJColumnarChartDidSelected:(NSInteger)index;







@end

NS_ASSUME_NONNULL_END
