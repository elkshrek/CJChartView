//
//  CJLineChartModel.h
//  CJChartExample
//
//  Created by wing on 2020/3/6.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 线性图数据
@interface CJLineChartModel : NSObject

@property (nonatomic, assign) CGFloat lineChartPointX;
@property (nonatomic, assign) CGFloat lineChartPointY;
@property (nonatomic, assign, readonly) NSUInteger linePointIndex;


@end

NS_ASSUME_NONNULL_END
