//
//  CJPieChartView.h
//  CJChartExample
//
//  Created by Jonathan on 2017/4/16.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJPieChartView.h"


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
    _pieChartCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self refreshPieChartLayer:YES];
}

- (void)configChartInfo
{
    _strikeMove = 6.f;
    _purfleWidth = 8.f;
    _strikeDuration = 0.2f;
    _showDuration = 0.6f;
    _pieHoopWidth = 50.f;
    _selectPicChartIndex = -1;
    _jagWidth = 4.f;
    _crackWidth = 4.f;
    _selectedPieChart = nil;
    _pieChartType = CJPieNormalChart;
    _pieChartShowStyle = CJPieChartShowStyleNormal;
    _pieChartSelectStyle = CJPieChartSelectStylePurfle;
    
    if (!_chartView) {
        _chartView = [[UIView alloc] initWithFrame:self.bounds];
        _chartView.backgroundColor = [UIColor clearColor];
        [self addSubview:_chartView];
        
        CGFloat radius = _pieChartInnerRadius > 40.f ? _pieChartInnerRadius : 40.f;
        CGFloat pgWidth = 2.f * radius * cos(M_PI_4);
        _percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, pgWidth, pgWidth)];
        _percentageLabel.center = _pieChartCenter;
        _percentageLabel.backgroundColor = [UIColor clearColor];
        _percentageLabel.numberOfLines = 2;
        _percentageLabel.adjustsFontSizeToFitWidth = YES;
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
    if (!layerPieData.count) {
        _layerPieData = layerPieData;
        return;
    }
    NSMutableArray *pieData = [[NSMutableArray alloc] init];
    if (self.pieChartShowStyle == CJPieChartShowStyleNormal || self.pieChartShowStyle == CJPieChartShowStyleJagged || self.pieChartShowStyle == CJPieChartShowStyleCrack) {
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
        if (!model.chartColor) {
            model.chartColor = [UIColor colorWithRed:(88.f / 255.f) green:(186.f / 255.f) blue:(195.f / 255.f) alpha:0.75f];
        }
        [pieData addObject:model];
    } else if (self.pieChartShowStyle == CJPieChartShowStyleRing) {
        CJPieChartModel *model = [layerPieData firstObject];
        if (!model.chartColor) {
            model.chartColor = [UIColor colorWithRed:(88.f / 255.f) green:(186.f / 255.f) blue:(195.f / 255.f) alpha:0.75f];
        }
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
    } else if(pieChartShowStyle == CJPieChartShowStyleJagged) {// CJPieChartShowStyleJagged
        [self setUserInteractionEnabled:YES];
    } else if (pieChartShowStyle == CJPieChartShowStyleCrack) {// CJPieChartShowStyleCrack
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
- (CGFloat)pieHoopWidth
{
    if (_pieHoopWidth <= self.jagWidth) {
        return self.jagWidth + 1.f;
    }
    return _pieHoopWidth;
}
- (CGFloat)calUnitJagWidth
{
    CGFloat jagUnit = self.jagWidth;
    CGFloat disJag = self.jagWidth * (self.layerPieData.count - 1);
    CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
    if (lineWidth < disJag) {
        CGFloat limitWidth = lineWidth - self.jagWidth;
        jagUnit = limitWidth / (self.layerPieData.count - 1);
    }
    return jagUnit;
}

// 刷新扇形图层
- (void)refreshPieChartLayer:(BOOL)animation
{
    CGFloat radius = self.pieChartInnerRadius;
    CGFloat pgWidth = 2.f * radius * cos(M_PI_4);
    pgWidth = pgWidth > 40.f ? pgWidth : 40.f;
    self.percentageLabel.frame = CGRectMake(0, 0, pgWidth, pgWidth);
    [self setPercentageLabelText:nil];
    self.percentageLabel.center = self.pieChartCenter;
    self.chartView.frame = self.bounds;
    self.pieChartOuterRadius = self.bounds.size.width / 2.f;
    self.pieChartCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
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
        CAShapeLayer *layer = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:(-M_PI_2) endAngle:(3 * M_PI_2) color:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1f] clockwise:YES];
        [self.chartView.layer addSublayer:layer];
        
        CJPieChartModel *model = [self.layerPieData firstObject];
        self.ratePieChart = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
        [self.chartView.layer addSublayer:self.ratePieChart];
        [self addAnimationToLayer:self.ratePieChart startPercentage:model.startPercentage endPercentage:model.endPercentage animation:animation];
        [self setPercentageLabelText:model];
    } else if (self.pieChartShowStyle == CJPieChartShowStyleRing) {// 环状效果
        CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
        CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
        CAShapeLayer *layer = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:(-M_PI_2) endAngle:(3 * M_PI_2) color:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1f] clockwise:YES];
        [self.chartView.layer addSublayer:layer];
        
        CJPieChartModel *model = [self.layerPieData firstObject];
        lineWidth = 10.f;
        radius = self.pieChartOuterRadius - lineWidth / 2;
        self.ringPieChart = [self ringPieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
        [self.chartView.layer addSublayer:self.ringPieChart];
        [self addAnimationToLayer:self.ringPieChart startPercentage:model.startPercentage endPercentage:model.endPercentage animation:animation];
        [self setPercentageLabelText:model];
    } else if (self.pieChartShowStyle == CJPieChartShowStyleJagged) {//锯齿效果
        CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
        CGFloat jagUnit = [self calUnitJagWidth];
        for (int i = 0; i < self.layerPieData.count; i++) {
            CJPieChartModel *model = self.layerPieData[i];
            CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
            CAShapeLayer *shapeLayer = [self pieShapeLayerCenter:self.pieChartCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
            [self.chartView.layer addSublayer:shapeLayer];
            lineWidth += jagUnit;
        }
        [self addPicChartAnimation:animation];
        [self setPercentageLabelText:nil];
        [self setUserInteractionEnabled:YES];
    } else if (self.pieChartShowStyle == CJPieChartShowStyleCrack) {
        // 裂痕效果
        for (int i = 0; i < self.layerPieData.count; i++) {
            CJPieChartModel *model = self.layerPieData[i];
            CGFloat lineWidth = self.pieChartOuterRadius - self.pieChartInnerRadius;
            CGFloat radius = self.pieChartInnerRadius + lineWidth / 2;
            CGPoint movePoint = [self departOfChart:model distance:self.crackWidth];
            CGPoint pieCenter = CGPointMake(self.pieChartCenter.x + movePoint.x, self.pieChartCenter.y + movePoint.y);
            CAShapeLayer *shapeLayer = [self pieShapeLayerCenter:pieCenter radius:radius lineWidth:lineWidth startAngle:model.startAngle endAngle:model.endAngle color:model.chartColor clockwise:YES];
            [self.chartView.layer addSublayer:shapeLayer];
        }
        [self addPicChartAnimation:animation];
        [self setPercentageLabelText:nil];
        [self setUserInteractionEnabled:YES];
    }
    
}

// 创建环状CAShapeLayer
- (CAShapeLayer *)ringPieShapeLayerCenter:(CGPoint)arcCenter radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color clockwise:(BOOL)clockwise
{
    CAShapeLayer *shapeLayer = [self pieShapeLayerCenter:arcCenter radius:radius lineWidth:lineWidth startAngle:startAngle endAngle:endAngle color:color clockwise:clockwise];
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
    if (distanceFromCenter < self.pieChartInnerRadius || distanceFromCenter > self.pieChartOuterRadius) {
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
    CJPieChartModel *model = self.layerPieData[index];
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
    CGFloat jagUnit = [self calUnitJagWidth];
    if (self.pieChartShowStyle == CJPieChartShowStyleJagged) {
        pieRadius += jagUnit * index;
    }
    CGPoint centPoint = self.pieChartCenter;
    if (self.pieChartShowStyle == CJPieChartShowStyleCrack) {
        CGPoint departPoint = [self departOfChart:model distance:self.crackWidth];
        centPoint = CGPointMake(centPoint.x + departPoint.x, centPoint.y + departPoint.y);
    }
    self.selectedPieChart = [self pieShapeLayerCenter:centPoint radius:pieRadius lineWidth:self.purfleWidth startAngle:model.startAngle endAngle:model.endAngle color:selectColor clockwise:YES];
    [self.chartView.layer addSublayer:self.selectedPieChart];
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
        [self animationChartLayerStrike:nowLayer fromValue:fromValue toValue:toValue duration:self.strikeDuration];
        self.selectPicChartIndex = nowIndex;
    } else if (oldIndex == nowIndex) {// 选择了已经选中的layer
        CJPieChartModel *model = _layerPieData[oldIndex];
        NSValue *fromValue = [self pointOfShapeLayer:model move:_strikeMove];
        NSValue *toValue = [self pointOfShapeLayer:model move:0.f];
        CAShapeLayer *shapeLayer = (CAShapeLayer *)layers[oldIndex];
        [self animationChartLayerStrike:shapeLayer fromValue:fromValue toValue:toValue duration:self.strikeDuration];
        self.selectPicChartIndex = -1;
    } else {// 选择的不是已选中的layer
        CJPieChartModel *oldModel = _layerPieData[oldIndex];
        NSValue *oldFromValue = [self pointOfShapeLayer:oldModel move:_strikeMove];
        NSValue *oldToValue = [self pointOfShapeLayer:oldModel move:0.f];
        CAShapeLayer *oldLayer = (CAShapeLayer *)layers[oldIndex];
        [self animationChartLayerStrike:oldLayer fromValue:oldFromValue toValue:oldToValue duration:self.strikeDuration];
        
        CJPieChartModel *nowModel = _layerPieData[nowIndex];
        NSValue *nowFromValue = [self pointOfShapeLayer:nowModel move:0.f];
        NSValue *nowToValue = [self pointOfShapeLayer:nowModel move:_strikeMove];
        CAShapeLayer *nowLayer = (CAShapeLayer *)layers[nowIndex];
        [self animationChartLayerStrike:nowLayer fromValue:nowFromValue toValue:nowToValue duration:self.strikeDuration];
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
    CGPoint centerPoint = [self departOfChart:model distance:move];
    NSValue *value = [NSValue valueWithCGPoint:centerPoint];
    return value;
}
/// 偏离距离
/// @param model    饼图model
/// @param distance 偏离半径
- (CGPoint)departOfChart:(CJPieChartModel *)model distance:(CGFloat)distance
{
    CGFloat centerPercentage = 1.0 * (model.endPercentage + model.startPercentage) / 2;
    CGFloat centerAngle = centerPercentage * (2 * M_PI) - M_PI_2;
    CGPoint movePoint = CGPointMake(distance * cos(centerAngle), distance * sin(centerAngle));
    return movePoint;
}

// 计算touch的是哪一个扇形区域返回Index
- (NSInteger)locationPieChartArea:(CGPoint)touchLoc
{
    NSInteger index = 0;
    CGFloat percentage = [self findPercentageOfAngleInCircle:self.pieChartCenter fromPoint:touchLoc];
    
    for (int i = 0; i < self.layerPieData.count; i++) {
        CJPieChartModel *model = self.layerPieData[i];
        if (percentage <= model.endPercentage) {
            index = i;
            break;
        }
    }
    
    return index;
}

#pragma mark - 添加动画
- (void)addPicChartAnimation:(BOOL)animation
{
    NSArray *layers = [self.chartView.layer sublayers];
    for (int i = 0; i < self.layerPieData.count; i++) {
        CJPieChartModel *model = self.layerPieData[i];
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
        shapeAnimation.beginTime = CACurrentMediaTime() + self.showDuration * startPercentage;
        shapeAnimation.duration = self.showDuration * (endPercentage - startPercentage);
        shapeAnimation.fillMode = kCAFillModeBackwards;
        shapeAnimation.removedOnCompletion = YES;
        [shapeLayer addAnimation:shapeAnimation forKey:@"shapeAnimation"];
    }
}


@end
