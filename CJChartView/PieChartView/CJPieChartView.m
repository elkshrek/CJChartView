//
//  CJPieChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJPieChartView.h"


#ifndef CJHexColor
#define CJHexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]
#endif

@interface CJPieChartView ()

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UILabel *percentageLabel;// 显示选中的百分比

@property (nonatomic, assign) CGFloat pieChartOuterRadius; // 外半径
@property (nonatomic, assign) CGFloat pieChartInnerRadius; // 内半径
@property (nonatomic, assign) CGPoint pieChartCenter;      // 中心

@property (nonatomic, strong) CAShapeLayer *selectedPieChart;// 选中的PieChart(Purfle风格启用)
@property (nonatomic, assign) NSInteger selectPicChartIndex; // 选中的PicChartIndex -1 未选中任何扇形区域

@property (nonatomic, strong) CAShapeLayer *ratePieChart;// showStyleRate风格的Layer
@property (nonatomic, strong) CAShapeLayer *ringPieChart;// showStyleRing风格的Layer

@property (nonatomic, assign) CGFloat strikeMove;   // Strike风格时候的移动距离
@property (nonatomic, assign) CGFloat purfleWidth;  // Purfle风格时候的花边宽度

// duration
@property (nonatomic, assign) CGFloat showDuration;  // Chart加载动画时长
@property (nonatomic, assign) CGFloat strikeDuration;// Strike风格的动画时间

@end

@implementation CJPieChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame centerTitle:@""];
}

- (instancetype)initWithFrame:(CGRect)frame centerTitle:(NSString*)centerTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        _centerTitle = centerTitle;
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
    _pieChartOuterRadius = self.bounds.size.width / 2 - _purfleWidth;
    _pieChartCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.width / 2);
    [self refreshPieChartLayer:NO];
}

- (void)configChartInfo
{
    _strikeMove = 6.f;
    _purfleWidth = 10.f;
    _strikeDuration = 0.2f;
    _showDuration = 0.6f;
    _pieHoopWidth = 20.f;
    _selectPicChartIndex = -1;
    _selectedPieChart = nil;
    _pieChartType = CJPieNormalChart;
    _pieChartShowStyle = CJPieChartShowStyleNormal;
    _pieChartSelectStyle = CJPieChartSelectStylePurfle;
    
    if (!_chartView) {
        _chartView = [[UIView alloc] initWithFrame:self.bounds];
        _chartView.backgroundColor = [UIColor clearColor];
        [self addSubview:_chartView];
        
        CGFloat radius = _pieChartInnerRadius > 30.f ? _pieChartInnerRadius : 30.f;
        CGFloat pgWidth = 2.f * radius * cos(M_PI_4);
        _percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, pgWidth, pgWidth)];
        _percentageLabel.center = _pieChartCenter;
        _percentageLabel.backgroundColor = [UIColor clearColor];
        _percentageLabel.textColor = UIColor.blackColor; //CJHexColor(0x58bac3, 1.f);
        _percentageLabel.font = [UIFont systemFontOfSize:12.f];
        _percentageLabel.textAlignment = NSTextAlignmentCenter;
        _percentageLabel.userInteractionEnabled = NO;
        _percentageLabel.text = self.centerTitle;
        [self addSubview:_percentageLabel];
    }
    [self setExclusiveTouch:YES];
}

// 设置扇形图的分布数据{CJPieChartShowStyleRate风格时layerPieData只有一个元素}
- (void)setLayerPieData:(NSArray<CJPieChartModel *> *)layerPieData
{
    NSMutableArray *pieData = [[NSMutableArray alloc] init];
    if (self.pieChartShowStyle == CJPieChartShowStyleNormal || self.pieChartShowStyle == CJPieChartShowStyleJagged) {
        NSInteger count = layerPieData.count;
        CGFloat alphaUnit = 0.6 / (count * 1.f);
        for (int i = 0; i < count; i++) {
            CJPieChartModel *model = layerPieData[i];
            if (!model.chartColor) {
                model.chartColor = CJHexColor(0x26a4af, (0.4 + (i + 1) * alphaUnit));
            }
            [pieData addObject:model];
        }
    } else if (self.pieChartShowStyle == CJPieChartShowStyleRate) {
        CJPieChartModel *model = [layerPieData firstObject];
        model.chartColor = [UIColor colorWithRed:(88.f / 256.f) green:(186.f / 256.f) blue:(195.f / 256.f) alpha:0.75f];
        [pieData addObject:model];
    } else if (self.pieChartShowStyle == CJPieChartShowStyleRing) {
        CJPieChartModel *model = [layerPieData firstObject];
        model.chartColor = [UIColor colorWithRed:(88.f / 256.f) green:(186.f / 256.f) blue:(195.f / 256.f) alpha:0.75f];
        [pieData addObject:model];
    }
    
    _layerPieData = pieData;
    [self removePieChartLayer];
    [self addPieChartToView:YES];
}

- (void)setPieChartType:(CJPieChartType)pieChartType
{
    _pieChartType = pieChartType;
    [self refreshPieChartLayer:YES];
}

- (void)setPieChartSelectStyle:(CJPieChartSelectStyle)pieChartSelectStyle
{
    _pieChartSelectStyle = pieChartSelectStyle;
    [self refreshPieChartLayer:YES];
}

- (void)setPieChartShowStyle:(CJPieChartShowStyle)pieChartShowStyle
{
    if (pieChartShowStyle == CJPieChartShowStyleNormal) {// CJPieChartShowStyleNormal
        [self setUserInteractionEnabled:YES];
    } else if (pieChartShowStyle == CJPieChartShowStyleRate) {// CJPieChartShowStyleRate
        [self setUserInteractionEnabled:NO];
    } else if (pieChartShowStyle == CJPieChartShowStyleRing) {// CJPieChartShowStyleRing
        [self setUserInteractionEnabled:NO];
    }else if(pieChartShowStyle == CJPieChartShowStyleJagged) {// CJPieChartShowStyleJagged
        [self setUserInteractionEnabled:YES];
    }
    _pieChartShowStyle = pieChartShowStyle;
    [self refreshPieChartLayer:YES];
}

- (void)setCenterTitleColor:(UIColor *)centerTitleColor
{
    if (centerTitleColor) {
        _centerTitleColor = centerTitleColor;
        self.percentageLabel.textColor = centerTitleColor;
    }
}

- (void)setPercentageLabelText:(CJPieChartModel *)chartModel
{
    self.percentageLabel.text = @"";
    if (chartModel == nil) {
        self.percentageLabel.text = self.centerTitle;
        self.percentageLabel.textColor = self.centerTitleColor;
    } else {
        if ([chartModel isKindOfClass:[CJPieChartModel class]]) {
            self.percentageLabel.text = [NSString stringWithFormat:@"%.1f%%", (chartModel.endPercentage - chartModel.startPercentage) * 100];
        }
    }
}

- (CGFloat)pieChartInnerRadius
{
    if (self.pieChartType == CJPieNormalChart) {
        return 0.f;
    } else {// CJPieHoopChart
        CGFloat radius = self.pieChartOuterRadius - self.pieHoopWidth;
        return radius > 0.f ? radius : 0.f;
    }
}

// 刷新扇形图层
- (void)refreshPieChartLayer:(BOOL)animation
{
    CGFloat radius = self.pieChartInnerRadius > 30.f ? self.pieChartInnerRadius : 30.f;
    CGFloat pgWidth = 2.f * radius * cos(M_PI_4);
    self.percentageLabel.frame = CGRectMake(0, 0, pgWidth, pgWidth);
    [self setPercentageLabelText:nil];
    self.percentageLabel.center = self.pieChartCenter;
    self.chartView.frame = self.bounds;
    [self removePieChartLayer];
    [self addPieChartToView:animation];
}

// 删除当前页面的所有扇形图层
- (void)removePieChartLayer
{
    while ([[self.chartView.layer sublayers] count] > 0) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *)[[self.chartView.layer sublayers] firstObject];
        if ([shapeLayer superlayer]) {
            [shapeLayer removeFromSuperlayer];
        }
    }
    [self.selectedPieChart removeFromSuperlayer];
    self.selectPicChartIndex = -1;
    [self setPercentageLabelText:nil];
    [self setUserInteractionEnabled:NO];
}

#pragma mark -- 创建扇形图层添加到图层上
- (void)addPieChartToView:(BOOL)animation
{
    if (self.pieChartShowStyle == CJPieChartShowStyleNormal) { // 默认效果
        for (int i = 0; i < self.layerPieData.count; i++) {
            CJPieChartModel *model = self.layerPieData[i];
            CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
            CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
            CAShapeLayer *shapeLayer = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
            [self.chartView.layer addSublayer:shapeLayer];
        }
        [self addPicChartAnimation:animation];
        [self setPercentageLabelText:nil];
        [self setUserInteractionEnabled:YES];
        
    } else if (self.pieChartShowStyle == CJPieChartShowStyleRate) {// 占比效果
        CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
        CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
        CAShapeLayer *layer = [self pieShapeLayerCenter:_pieChartCenter radius:radius lineWidth:lineWidth startAngle:(-M_PI_2) endAngle:(3 * M_PI_2) color:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1f] clockwise:YES];
        [_chartView.layer addSublayer:layer];
        
        CJPieChartModel *model = [_layerPieData firstObject];
        self.ratePieChart = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
        [_chartView.layer addSublayer:self.ratePieChart];
        [self addAnimationToLayer:self.ratePieChart startPercentage:model.startPercentage endPercentage:model.endPercentage animation:animation];
        [self setPercentageLabelText:model];
    } else if (self.pieChartShowStyle == CJPieChartShowStyleRing) {// 环状效果
        CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
        CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
        CAShapeLayer *layer = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:(-M_PI_2) endAngle:(3 * M_PI_2) color:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1f] clockwise:YES];
        [_chartView.layer addSublayer:layer];
        
        CJPieChartModel *model = [_layerPieData firstObject];
        lineWidth = 10.f;
        radius = self.pieChartOuterRadius - lineWidth / 2;
        self.ringPieChart = [self ringPieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
        [_chartView.layer addSublayer:self.ringPieChart];
        [self addAnimationToLayer:self.ringPieChart startPercentage:model.startPercentage endPercentage:model.endPercentage animation:animation];
        [self setPercentageLabelText:model];
    } else if(_pieChartShowStyle == CJPieChartShowStyleJagged) {//锯齿效果
//        CGFloat fault = (_layerPieData.count * 5);
        CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
        for (int i = 0; i < _layerPieData.count; i++) {
            CJPieChartModel *model = _layerPieData[i];
            CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
            CAShapeLayer *shapeLayer = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
            [_chartView.layer addSublayer:shapeLayer];
            lineWidth += 5;
        }
        [self addPicChartAnimation:animation];
        [self setPercentageLabelText:nil];
        [self setUserInteractionEnabled:YES];
    }
}

// 创建CAShapeLayer
- (CAShapeLayer *)pieShapeLayerCenter:(CGPoint)arcCenter radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color clockwise:(BOOL)clockwise
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = lineWidth;
    return shapeLayer;
}

// 创建环状CAShapeLayer
- (CAShapeLayer *)ringPieShapeLayerCenter:(CGPoint)arcCenter radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color clockwise:(BOOL)clockwise
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    return shapeLayer;
}

#pragma mark -- 扇形区域Touch事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLoc = [touch locationInView:[touch view]];
    NSInteger index = [self locationPieChartArea:touchLoc];
    
    CGFloat distanceFromCenter = sqrtf(powf((touchLoc.y - self.pieChartCenter.y),2) + powf((touchLoc.x - self.pieChartCenter.x),2));
    // 点在扇形区域外面的时候取消选中状态
    if (distanceFromCenter < _pieChartInnerRadius || distanceFromCenter > _pieChartOuterRadius) {
        if ([self.cj_delegate respondsToSelector:@selector(CJPieChartDidUnselect)]) {
            [self.cj_delegate CJPieChartDidUnselect];
        }
        [self setPercentageLabelText:nil];
        if (self.pieChartSelectStyle == CJPieChartSelectStylePurfle) {
            [self.selectedPieChart removeFromSuperlayer];
            self.selectPicChartIndex = -1;
        } else if (self.pieChartSelectStyle == CJPieChartSelectStyleStrike) {
            [self switchSelectChartLayerWithIndex:self.selectPicChartIndex];
        }
        return;
    }
    
    if ([self.cj_delegate respondsToSelector:@selector(CJPieChartDidSelected:)]) {
        [self.cj_delegate CJPieChartDidSelected:index];
    }
    CJPieChartModel *model = _layerPieData[index];
    [self setPercentageLabelText:model];
    [self switchSelectChartLayerWithIndex:index];
    
}

// 添加选中效果
- (void)switchSelectChartLayerWithIndex:(NSInteger)index
{
    NSInteger oldIndex = self.selectPicChartIndex;
//    NSLog(@"oldIndex %ld", (long)oldIndex);
    if (oldIndex == index) {
        [self setPercentageLabelText:nil];
    }
    switch (self.pieChartSelectStyle) {
        case CJPieChartSelectStylePurfle:
            [self pieChartSelectStylePurfle:index];
            break;
        case CJPieChartSelectStyleStrike:
            [self pieChartSelectStyleStrike:oldIndex current:index];
            break;
            
        default:
            break;
    }
    
}

// CJPieChartSelectStylePurfle 外围添加一个花边
- (void)pieChartSelectStylePurfle:(NSInteger)index
{
    if (self.selectPicChartIndex != -1) {// 当前有选中的扇区
        if (self.selectPicChartIndex == index) {// 选中已经选中的扇区时,默认取消当前选中状态
            [self.selectedPieChart removeFromSuperlayer];
            self.selectPicChartIndex = -1;
            return;
        }
    }
    if (self.selectPicChartIndex != -1) {
        [self.selectedPieChart removeFromSuperlayer];
    }
    // 否则高亮最新选中的扇区
    CJPieChartModel *model = _layerPieData[index];
    const CGFloat *components = CGColorGetComponents(model.chartColor.CGColor);
    CGFloat redFloat = components[0];
    CGFloat greenFloat = components[1];
    CGFloat blueFloat = components[2];
    CGFloat alphaFloat = components[3];
    UIColor *selectColor = [UIColor colorWithRed:redFloat green:greenFloat blue:blueFloat alpha:(alphaFloat * 0.5f)];
    
    CGFloat pieRadius = self.pieChartOuterRadius + _purfleWidth / 2.f;
    if (self.pieChartShowStyle == CJPieChartShowStyleJagged) {
        pieRadius += 5.f * index;
    }
    self.selectedPieChart = [self pieShapeLayerCenter:_pieChartCenter radius:pieRadius lineWidth:_purfleWidth startAngle:model.startAngle endAngle:model.endAngle color:selectColor clockwise:YES];
    [_chartView.layer addSublayer:self.selectedPieChart];
    self.selectPicChartIndex = index;
}

// CJPieChartSelectStyleStrike 向外移动效果
- (void)pieChartSelectStyleStrike:(NSInteger)oldIndex current:(NSInteger)nowIndex
{
    NSArray *layers = [_chartView.layer sublayers];
    self.selectedPieChart = nil;
    if (oldIndex == -1) {// 没有选中任何layer
        if (nowIndex == -1) {
            return;
        }
        CJPieChartModel *nowModel = _layerPieData[nowIndex];
        NSValue *fromValue = [self pointOfShapeLayer:nowModel move:0.f];
        NSValue *toValue = [self pointOfShapeLayer:nowModel move:_strikeMove];
        CAShapeLayer *nowLayer = (CAShapeLayer *)layers[nowIndex];
        [self animationChartLayerStrike:nowLayer fromValue:fromValue toValue:toValue];
        self.selectPicChartIndex = nowIndex;
    } else if (oldIndex == nowIndex) {// 选择了已经选中的layer
        CJPieChartModel *model = _layerPieData[oldIndex];
        NSValue *fromValue = [self pointOfShapeLayer:model move:_strikeMove];
        NSValue *toValue = [self pointOfShapeLayer:model move:0.f];
        CAShapeLayer *shapeLayer = (CAShapeLayer *)layers[oldIndex];
        [self animationChartLayerStrike:shapeLayer fromValue:fromValue toValue:toValue];
        self.selectPicChartIndex = -1;
    } else {// 选择的不是已选中的layer
        CJPieChartModel *oldModel = _layerPieData[oldIndex];
        NSValue *oldFromValue = [self pointOfShapeLayer:oldModel move:_strikeMove];
        NSValue *oldToValue = [self pointOfShapeLayer:oldModel move:0.f];
        CAShapeLayer *oldLayer = (CAShapeLayer *)layers[oldIndex];
        [self animationChartLayerStrike:oldLayer fromValue:oldFromValue toValue:oldToValue];
        
        CJPieChartModel *nowModel = _layerPieData[nowIndex];
        NSValue *nowFromValue = [self pointOfShapeLayer:nowModel move:0.f];
        NSValue *nowToValue = [self pointOfShapeLayer:nowModel move:_strikeMove];
        CAShapeLayer *nowLayer = (CAShapeLayer *)layers[nowIndex];
        [self animationChartLayerStrike:nowLayer fromValue:nowFromValue toValue:nowToValue];
        self.selectPicChartIndex = nowIndex;
    }
    [self setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.strikeDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setUserInteractionEnabled:YES];
    });
    
}

// 获取当前model对应的Layer的中心位置NSValue
- (NSValue *)pointOfShapeLayer:(CJPieChartModel *)model move:(CGFloat)move
{
    CGFloat centerPercentage = 1.0 * (model.endPercentage + model.startPercentage) / 2;
    CGFloat centerAngle = centerPercentage * (2 * M_PI) - M_PI_2;
    CGPoint centerPoint = CGPointMake(move * cos(centerAngle), move * sin(centerAngle));
    NSValue *value = [NSValue valueWithCGPoint:centerPoint];
    return value;
}

// 计算touch的是哪一个扇形区域返回Index
- (NSInteger)locationPieChartArea:(CGPoint)touchLoc
{
    NSInteger index = 0;
    CGFloat percentage = [self findPercentageOfAngleInCircle:self.pieChartCenter fromPoint:touchLoc];
    
    for (int i = 0; i < _layerPieData.count; i++) {
        CJPieChartModel *model = _layerPieData[i];
        if (percentage <= model.endPercentage) {
            index = i;
            break;
        }
    }
    
    return index;
}

// 获取点击位置的百分位置
- (CGFloat)findPercentageOfAngleInCircle:(CGPoint)center fromPoint:(CGPoint)reference
{
    CGFloat angleOfLine = atanf((reference.y - center.y) / (reference.x - center.x));
    CGFloat percentage = (angleOfLine + M_PI_2) / (2 * M_PI);
    return (reference.x - center.x) > 0 ? percentage : percentage + .5;
}

#pragma mark - 添加动画
- (void)addPicChartAnimation:(BOOL)animation
{
    NSArray *layers = [_chartView.layer sublayers];
    for (int i = 0; i < _layerPieData.count; i++) {
        CJPieChartModel *model = _layerPieData[i];
        CAShapeLayer *layer = layers[i];
        [self addAnimationToLayer:layer startPercentage:model.startPercentage endPercentage:model.endPercentage animation:animation];
    }
}

// 加载展开动画
- (void)addAnimationToLayer:(CAShapeLayer *)shapeLayer startPercentage:(CGFloat)startPercentage endPercentage:(CGFloat)endPercentage animation:(BOOL)animation
{
    if (animation) {
        CABasicAnimation *shapeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        shapeAnimation.fromValue = @0.f;
        shapeAnimation.toValue = @1.f;
        shapeAnimation.beginTime = CACurrentMediaTime() + _showDuration * startPercentage;
        shapeAnimation.duration = _showDuration * (endPercentage - startPercentage);
        shapeAnimation.fillMode = kCAFillModeBackwards;
        shapeAnimation.removedOnCompletion = YES;
        [shapeLayer addAnimation:shapeAnimation forKey:@"shapeAnimation"];
    }
}

// Strike 向外移动效果动画
- (void)animationChartLayerStrike:(CAShapeLayer *)shapeLayer fromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = _strikeDuration;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    [shapeLayer addAnimation:animation forKey:@"StrikeAnimation"];
}


@end
