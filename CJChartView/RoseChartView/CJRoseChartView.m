//
//  CJRoseChartView.m
//  CJChartExample
//
//  Created by wing on 2020/3/11.
//  Copyright © 2020 Jonathan. All rights reserved.
//

#import "CJRoseChartView.h"
#import "CJRoseChartModel.h"
#import "CJChartParallelDefinition.h"

@interface CJRoseChartView ()

@property (nonatomic, strong) UIView *chartView;

/// 寻找最大的花瓣
@property (nonatomic, assign) CGFloat maxPetalSize;
/// 玫瑰花心
@property (nonatomic, assign) CGPoint roseCenter;
/// 玫瑰花径
@property (nonatomic, assign) CGFloat roseChartRadius;

/// 选中的RoseChart(Purfle风格启用)
@property (nonatomic, strong) CAShapeLayer *selectedRoseChart;
/// 选中的RoseChartIndex -1 未选中任何玫瑰区域
@property (nonatomic, assign) NSInteger selectRoseChartIndex;
/// Strike风格时候的移动距离  4.f
@property (nonatomic, assign) CGFloat strikeMove;
/// Purfle风格时候的花边宽度  4.f
@property (nonatomic, assign) CGFloat purfleWidth;

/// Chart加载动画时长
@property (nonatomic, assign) CGFloat showDuration;
/// Strike风格的动画时间
@property (nonatomic, assign) CGFloat strikeDuration;


@end

@implementation CJRoseChartView

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
    self.roseChartRadius = self.bounds.size.width / 2.f - 10.f;
    self.roseCenter = CGPointMake(self.bounds.size.width / 2.f, self.bounds.size.height / 2.f);
    [self refreshRoseChartLayer:YES];
}

- (void)configChartInfo
{
    _maxPetalSize = 1.f;
    _strikeMove = 4.f;
    _purfleWidth = 4.f;
    _showDuration = 0.6f;
    _strikeDuration = 0.2f;
    _selectRoseChartIndex = -1;
    _roseChartSelectStyle = CJPieChartSelectStylePurfle;
    
    if (!_chartView) {
        _chartView = [[UIView alloc] initWithFrame:self.bounds];
        _chartView.backgroundColor = UIColor.clearColor;
        [self addSubview:_chartView];
    }
    [self setExclusiveTouch:YES];
}

- (void)setLayerRoseData:(NSArray<CJRoseChartModel *> *)layerRoseData
{
    if (!layerRoseData.count) {
        _layerRoseData = layerRoseData;
        return;
    }
    NSMutableArray *roseData = [[NSMutableArray alloc] init];
    NSInteger count = layerRoseData.count;
    CGFloat alphaUnit = 0.6 / (count * 1.f);
    for (int i = 0; i < count; i++) {
        CJRoseChartModel *roseModel = layerRoseData[i];
        if (!roseModel.petalColor) {
            roseModel.petalColor = CJHexColor(0x26a4af, (0.4 + (i + 1) * alphaUnit));
        }
        if (self.maxPetalSize <= roseModel.petalSize) {
            self.maxPetalSize = roseModel.petalSize;
        }
        [roseData addObject:roseModel];
    }
    _layerRoseData = roseData;
    [self removeRoseChartLayer];
    [self addRoseChartToView:YES];
    
}

- (void)setRoseChartSelectStyle:(CJPieChartSelectStyle)roseChartSelectStyle
{
    _roseChartSelectStyle = roseChartSelectStyle;
    [self refreshRoseChartLayer:YES];
}

- (void)addRoseChartToView:(BOOL)animation
{
    CGFloat angleUnit = (M_PI * 2.f) / self.layerRoseData.count;
    for (int i = 0; i < self.layerRoseData.count; i++) {
        CJRoseChartModel *roseModel = self.layerRoseData[i];
        CGFloat lineWidth = self.roseChartRadius * (1.f * roseModel.petalSize / self.maxPetalSize);
        CGFloat startAngle = -M_PI_2 + i * angleUnit;
        CGFloat endAngle = startAngle + angleUnit;
        CGFloat radius = lineWidth / 2.f;
        CAShapeLayer *shapeLayer = [self roseLayerCenter:self.roseCenter radius:radius lineWidth:lineWidth startAngle:startAngle endAngle:endAngle color:roseModel.petalColor clockwise:YES];
        [self.chartView.layer addSublayer:shapeLayer];
        
        CGFloat measRadius = lineWidth + 7.f;
        CGFloat measAngle = (endAngle + startAngle) / 2.f + M_PI_2;
        CGFloat measX = self.roseCenter.x + measRadius * sin(measAngle);
        CGFloat measY = self.roseCenter.y - measRadius * cos(measAngle);
        CGPoint measPoint = CGPointMake(measX, measY);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 26.f, 6.f)];
        label.center = measPoint;
        label.textColor = UIColor.blackColor;
        label.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithFloat:roseModel.petalSize]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:7];
        [label setAdjustsFontSizeToFitWidth:YES];
        label.backgroundColor = UIColor.clearColor;
        label.layer.masksToBounds = NO;
        [self.chartView addSubview:label];
        label.transform = CGAffineTransformMakeRotation(measAngle);
    }
    
    [self setUserInteractionEnabled:YES];
}

// 创建CAShapeLayer
- (CAShapeLayer *)roseLayerCenter:(CGPoint)arcCenter radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color clockwise:(BOOL)clockwise
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = lineWidth;
    return shapeLayer;
}

- (void)addAnimationToLayer:(CAShapeLayer *)shapeLayer
{
    
    
    
}

/// 刷新玫瑰图
/// @param animation 是否开启刷新动画
- (void)refreshRoseChartLayer:(BOOL)animation
{
    self.chartView.frame = self.bounds;
    self.roseChartRadius = self.bounds.size.width / 2.f - 10.f;
    self.roseCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self removeRoseChartLayer];
    [self addRoseChartToView:YES];
    
}
/// 移除玫瑰图
- (void)removeRoseChartLayer
{
    NSMutableArray *subViews = [NSMutableArray arrayWithArray:[self.chartView subviews]];
    while (subViews.count > 0) {
        UIView *view = (UIView *)[subViews firstObject];
        if ([view superview]) {
            [view removeFromSuperview];
        }
        [subViews removeObject:view];
    }
    while ([[self.chartView.layer sublayers] count] > 0) {
        CALayer *layer = (CALayer *)[[self.chartView.layer sublayers] firstObject];
        if ([layer superlayer]) {
            [layer removeFromSuperlayer];
        }
    }
    [self.selectedRoseChart removeFromSuperlayer];
    self.selectRoseChartIndex = -1;
    [self setUserInteractionEnabled:NO];
}

@end
