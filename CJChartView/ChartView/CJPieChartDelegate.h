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

// CJPieChartDelegate
- (void)CJPieChartDidSelected:(NSInteger)index;
- (void)CJPieChartDidUnselect;



@end

NS_ASSUME_NONNULL_END
