//
//  CJLineChartView.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/21.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJLineChartView.h"
#import "CJChartParallelDefinition.h"


@interface CJLineChartView ()

@property (nonatomic, strong) UIView *lineContView;

@property (nonatomic, strong) UIView *dikeView;

/// 折线图的点数据源
@property (nonatomic, strong) NSArray<CJLineChartModel *> *linePointData;

/// 折线图的横向展示范围
@property (nonatomic, assign) CGFloat lineContWidth;
/// 折线图的纵向展示范围
@property (nonatomic, assign) CGFloat lineContHeight;




@end

@implementation CJLineChartView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configChartInfo];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configChartInfo];
}
- (void)drawRect:(CGRect)rect
{
    self.lineContView.frame = self.bounds;
    self.lineContWidth = self.bounds.size.width;
    self.lineContHeight = self.bounds.size.height;
    
}

- (void)configChartInfo
{
    [self addSubview:self.lineContView];
    [self addSubview:self.dikeView];
    self.dikeView.hidden = YES;
    self.lineWidth = self.lineWidth ?: 2.f;
    
    
}

/// 设置折现图的数据
- (void)setLinePointData:(NSArray<CJLineChartModel *> *)linePointData animation:(BOOL)animation
{
    self.linePointData = linePointData;
    // ...
    
    
}














- (UIView *)lineContView
{
    return _lineContView ?: ({
        _lineContView = [[UIView alloc] init];
        _lineContView.backgroundColor = UIColor.clearColor;
        _lineContView;
    });
}

- (UIView *)dikeView
{
    return _dikeView ?: ({
        _dikeView = [[UIView alloc] init];
        _dikeView.backgroundColor = CJHexColor(0x333333, 0.35f);
        _dikeView;
    });
}


@end
