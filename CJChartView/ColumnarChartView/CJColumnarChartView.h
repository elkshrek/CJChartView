//
//  CJColumnarChartView.h
//  CJChartExample
//
//  Created by wing on 2020/3/30.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJColumnarChartModel.h"
#import "CJColumnarChartDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJColumnarChartView : UIView

/// CJColumnarChartDelegate
@property (nonatomic, weak) id <CJColumnarChartDelegate> cj_delegate;







@end

NS_ASSUME_NONNULL_END
