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
@property (nonatomic, strong) UIView *infoView;

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
    
    [self addSubview:self.chartView];
    [self addSubview:self.infoView];
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
        CGFloat roseSize = self.roseChartRadius * (1.f * roseModel.petalSize / self.maxPetalSize);
        CGFloat startAngle = -M_PI_2 + i * angleUnit;
        CGFloat endAngle = startAngle + angleUnit;
        CGFloat radius = roseSize / 2.f;
        CAShapeLayer *shapeLayer = [self pieShapeLayerCenter:self.roseCenter radius:radius lineWidth:roseSize startAngle:startAngle endAngle:endAngle color:roseModel.petalColor clockwise:YES];
        [self.chartView.layer addSublayer:shapeLayer];
        
        CGFloat measRadius = roseSize + 7.f;
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
        [self.infoView addSubview:label];
        CGFloat rotateAngle = measAngle;
        if (startAngle > 0 && endAngle < M_PI) {
            rotateAngle += M_PI;
        }
        label.transform = CGAffineTransformMakeRotation(rotateAngle);
    }
    [self addAnimationToLayer:YES];
    [self setUserInteractionEnabled:YES];
}

- (void)addAnimationToLayer:(BOOL)animation
{
    if (animation) {
        self.infoView.hidden = YES;
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @(0.02f);
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.duration = self.showDuration;
        scaleAnimation.fillMode = kCAFillModeBackwards;
        scaleAnimation.removedOnCompletion = YES;
        [self.chartView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [self setUserInteractionEnabled:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.showDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.infoView.hidden = NO;
            [self setUserInteractionEnabled:YES];
        });
    }
    
}

/// 刷新玫瑰图
/// @param animation 是否开启刷新动画
- (void)refreshRoseChartLayer:(BOOL)animation
{
    [self removeRoseChartLayer];
    self.chartView.frame = self.bounds;
    self.infoView.frame = self.bounds;
    self.roseChartRadius = self.bounds.size.width / 2.f - 10.f;
    self.roseCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self addRoseChartToView:YES];
    
}
/// 移除玫瑰图
- (void)removeRoseChartLayer
{
    NSMutableArray *subViews = [NSMutableArray arrayWithArray:[self.infoView subviews]];
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

#pragma mark -- Touch事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLoc = [touch locationInView:[touch view]];
    NSInteger index = [self locationRoseChartArea:touchLoc];
    
    CGFloat distanceFromCenter = sqrtf(powf((touchLoc.y - self.roseCenter.y),2) + powf((touchLoc.x - self.roseCenter.x),2));
    CJRoseChartModel *roseModel = self.layerRoseData[index];
    CGFloat roseSize = self.roseChartRadius * (1.f * roseModel.petalSize / self.maxPetalSize);
    
    // 点在花瓣外时取消选中状态
    if (distanceFromCenter > roseSize) {
        if ([self.cj_delegate respondsToSelector:@selector(CJPieChartDidUnselect)]) {
            [self.cj_delegate CJPieChartDidUnselect];
        }
        if (self.roseChartSelectStyle == CJPieChartSelectStylePurfle) {
            [self.selectedRoseChart removeFromSuperlayer];
            self.selectRoseChartIndex = -1;
        } else if (self.roseChartSelectStyle == CJPieChartSelectStyleStrike) {
            [self switchSelectChartLayerWithIndex:self.selectRoseChartIndex];
        }
        return;
    }
    
    if ([self.cj_delegate respondsToSelector:@selector(CJPieChartDidSelected:)]) {
        [self.cj_delegate CJPieChartDidSelected:index];
    }
    [self switchSelectChartLayerWithIndex:index];
    
}
// 添加选中效果
- (void)switchSelectChartLayerWithIndex:(NSInteger)index
{
    NSInteger oldIndex = self.selectRoseChartIndex;
    switch (self.roseChartSelectStyle) {
        case CJPieChartSelectStylePurfle:
            [self roseChartSelectStylePurfle:index];
            break;
        case CJPieChartSelectStyleStrike:
            [self roseChartSelectStyleStrike:oldIndex current:index];
            break;
            
        default:
            break;
    }
    
}
// CJPieChartSelectStylePurfle 外围添加一个花边
- (void)roseChartSelectStylePurfle:(NSInteger)index
{
    if (self.selectRoseChartIndex != -1) {// 当前有选中的花瓣
        if (self.selectRoseChartIndex == index) {
            // 选中已经选中的花瓣时,默认取消当前选中状态
            [self.selectedRoseChart removeFromSuperlayer];
            self.selectRoseChartIndex = -1;
            return;
        }
    }
    if (self.selectRoseChartIndex != -1) {
        [self.selectedRoseChart removeFromSuperlayer];
    }
    // 否则高亮最新选中的扇区
    CJRoseChartModel *model = self.layerRoseData[index];
    const CGFloat *components = CGColorGetComponents(model.petalColor.CGColor);
    CGFloat redFloat = components[0];
    CGFloat greenFloat = components[1];
    CGFloat blueFloat = components[2];
    CGFloat alphaFloat = components[3];
    UIColor *selectColor = [UIColor colorWithRed:redFloat green:greenFloat blue:blueFloat alpha:(alphaFloat * 0.5f)];
    
    CGFloat laceSize = self.roseChartRadius * (1.f * model.petalSize / self.maxPetalSize) + self.purfleWidth / 2.f;
    CGFloat angleUnit = (M_PI * 2.f) / self.layerRoseData.count;
    CGFloat startAngle = -M_PI_2 + index * angleUnit;
    CGFloat endAngle = startAngle + angleUnit;
    
    self.selectedRoseChart = [self pieShapeLayerCenter:self.roseCenter radius:laceSize lineWidth:self.purfleWidth startAngle:startAngle endAngle:endAngle color:selectColor clockwise:YES];
    [self.chartView.layer addSublayer:self.selectedRoseChart];
    self.selectRoseChartIndex = index;
}

// CJPieChartSelectStyleStrike 向外移动效果
- (void)roseChartSelectStyleStrike:(NSInteger)oldIndex current:(NSInteger)nowIndex
{
    NSArray *layers = [self.chartView.layer sublayers];
    self.selectedRoseChart = nil;
    if (oldIndex == -1) {// 没有选中任何layer
        if (nowIndex == -1) {
            return;
        }
        NSValue *fromValue = [self pointOfShapeLayer:nowIndex move:0.f];
        NSValue *toValue = [self pointOfShapeLayer:nowIndex move:self.strikeMove];
        CAShapeLayer *nowLayer = (CAShapeLayer *)layers[nowIndex];
        [self animationChartLayerStrike:nowLayer fromValue:fromValue toValue:toValue duration:self.strikeDuration];
        self.selectRoseChartIndex = nowIndex;
    } else if (oldIndex == nowIndex) {// 选择了已经选中的layer
        NSValue *fromValue = [self pointOfShapeLayer:oldIndex move:self.strikeMove];
        NSValue *toValue = [self pointOfShapeLayer:oldIndex move:0.f];
        CAShapeLayer *shapeLayer = (CAShapeLayer *)layers[oldIndex];
        [self animationChartLayerStrike:shapeLayer fromValue:fromValue toValue:toValue duration:self.strikeDuration];
        self.selectRoseChartIndex = -1;
    } else {// 选择的不是已选中的layer
        NSValue *oldFromValue = [self pointOfShapeLayer:oldIndex move:self.strikeMove];
        NSValue *oldToValue = [self pointOfShapeLayer:oldIndex move:0.f];
        CAShapeLayer *oldLayer = (CAShapeLayer *)layers[oldIndex];
        [self animationChartLayerStrike:oldLayer fromValue:oldFromValue toValue:oldToValue duration:self.strikeDuration];
        
        NSValue *nowFromValue = [self pointOfShapeLayer:nowIndex move:0.f];
        NSValue *nowToValue = [self pointOfShapeLayer:nowIndex move:self.strikeMove];
        CAShapeLayer *nowLayer = (CAShapeLayer *)layers[nowIndex];
        [self animationChartLayerStrike:nowLayer fromValue:nowFromValue toValue:nowToValue duration:self.strikeDuration];
        self.selectRoseChartIndex = nowIndex;
    }
    [self setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.strikeDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setUserInteractionEnabled:YES];
    });
    
}

// 计算touch的是哪一个花瓣区域返回Index
- (NSInteger)locationRoseChartArea:(CGPoint)touchLoc
{
    CGFloat percentage = [self findPercentageOfAngleInCircle:self.roseCenter fromPoint:touchLoc];
    NSInteger index = floorl(1.f * percentage * self.layerRoseData.count);
    return index;
}

// 获取当前Layer的中心位置NSValue
- (NSValue *)pointOfShapeLayer:(NSInteger)index move:(CGFloat)move
{
    CGFloat angleUnit = (M_PI * 2.f) / self.layerRoseData.count;
    CGFloat centerAngle = (index + 0.5f) * angleUnit - M_PI_2;
    CGPoint centerPoint = CGPointMake(move * cos(centerAngle), move * sin(centerAngle));
    NSValue *value = [NSValue valueWithCGPoint:centerPoint];
    return value;
}

- (UIView *)chartView
{
    return _chartView ?: ({
        _chartView = [[UIView alloc] initWithFrame:self.bounds];
        _chartView.backgroundColor = UIColor.clearColor;
        _chartView;
    });
}
- (UIView *)infoView
{
    return _infoView ?: ({
        _infoView = [[UIView alloc] initWithFrame:self.bounds];
        _infoView.backgroundColor = UIColor.clearColor;
        _infoView;
    });
}

@end
