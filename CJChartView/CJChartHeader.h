//
//  CJChartHeader.h
//  CJChartExample
//
//  Created by Jonathan on 2018/11/8.
//  Copyright © 2018年 Jonathan. All rights reserved.
//

#ifndef CJChartHeader_h
#define CJChartHeader_h



#define CJNavStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)



#define CJHexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]




#endif /* CJChartHeader_h */
