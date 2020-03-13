//
//  CJChartParallelDefinition.h
//  CJChartExample
//
//  Created by wing on 2020/3/11.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#ifndef CJChartParallelDefinition_h
#define CJChartParallelDefinition_h


// 饼图、玫瑰图 选中状态风格
typedef NS_OPTIONS(NSUInteger, CJPieChartSelectStyle) {
    /// 外围添加一个花边   默认值
    CJPieChartSelectStylePurfle = 1 << 0,
    /// 向外移动
    CJPieChartSelectStyleStrike = 1 << 1,
    
};





#ifndef CJHexColor
#define CJHexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]
#endif


#endif /* CJChartParallelDefinition_h */
