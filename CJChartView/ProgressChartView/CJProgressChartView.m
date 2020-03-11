//
//  CJProgressChartView.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/17.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJProgressChartView.h"

#ifndef CJHexColor
#define CJHexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]
#endif

@interface CJProgressChartView()

@property (nonatomic, strong) UIScrollView *proChartScrollView;
@property (nonatomic, strong) UIView *proChartContentView;

@property (nonatomic, assign) NSInteger totalProgress; // 总进度
@property (nonatomic, assign) CGFloat currentProgress; // 当前进度
@property (nonatomic, strong) NSMutableArray *prgChartCellData;

/// 单页最多显示数量  default: 10
@property (nonatomic, assign) NSInteger progressShowNum;

@property (nonatomic, assign) CGFloat progressChartWidth;
@property (nonatomic, assign) CGFloat progressChartHeight;
@property (nonatomic, assign) CGFloat progressShowWidth;
@property (nonatomic, assign) CGFloat progressShowHeight;
@property (nonatomic, assign) CGFloat progressCellWidth;
@property (nonatomic, assign) CGFloat progressCellHeight;
@property (nonatomic, assign) CGFloat progressSpace; // 开始的位置的间隔


@end


@implementation CJProgressChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initChartInfo];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initChartInfo];
}

- (void)drawRect:(CGRect)rect
{
    _progressChartWidth = rect.size.width;
    _progressChartHeight = rect.size.height;
    _progressShowWidth = rect.size.width - 10.f;
    _progressCellWidth = (_progressShowWidth - _progressSpace * 2) / _progressShowNum;
    
    [self refreshProgressChartView];
}

- (void)initChartInfo
{
    _prgChartCellData = [[NSMutableArray alloc] init];
    _progressChartWidth = self.bounds.size.width;
    _progressShowWidth = self.bounds.size.width - 10.f;
    _progressChartHeight = self.bounds.size.height;
    _backProColor = CJHexColor(0xdcdcdc, 1.f);
    _curProFromColor = CJHexColor(0x7cdee7, 1.f);
    _curProToColor = CJHexColor(0x2e9aa3, 1.f);
    _anchorColor = CJHexColor(0x26a4af, 1.f);
    _progressShowHeight = 60.f;
    _progressCellHeight = 8.f;
    _progressShowNum = 10;
    _totalProgress = 10;
    _progressSpace = 8.f;
    
    _progressCellWidth = (_progressShowWidth - _progressSpace * 2) / _progressShowNum;
    
    [self configProgressChartView];
}

- (void)setTotalProgress:(NSInteger)totalProgress currentProgress:(CGFloat)currentProgress
{
    _totalProgress = totalProgress;
    _currentProgress = currentProgress;
    if (totalProgress < currentProgress) {
        _currentProgress = totalProgress;
    }
    if (totalProgress < 10) {
        _progressShowNum = totalProgress;
    } else {
        _progressShowNum = 10;
    }
    _progressCellWidth = (_progressShowWidth - _progressSpace * 2) / _progressShowNum;
    
    [self refreshProgressChartView];
}

- (void)configProgressChartView
{
    self.backgroundColor = [UIColor whiteColor];
    [self setExclusiveTouch:YES];
    if (!_proChartScrollView) {
        _proChartScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5.f, 0.f, _progressShowWidth, _progressShowHeight)];
        _proChartScrollView.center = CGPointMake(_progressChartWidth / 2, (_progressChartHeight / 2.f));
        _proChartScrollView.backgroundColor = [UIColor clearColor];
        _proChartScrollView.showsVerticalScrollIndicator = NO;
        _proChartScrollView.showsHorizontalScrollIndicator = NO;
        _proChartScrollView.scrollEnabled = YES;
        [self addSubview:_proChartScrollView];
        
        _proChartContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _progressShowWidth, _progressShowHeight)];
        _proChartContentView.backgroundColor = [UIColor clearColor];
        [_proChartScrollView addSubview:_proChartContentView];
        [_proChartScrollView setContentSize:_proChartContentView.bounds.size];
        
    }
    
}

- (void)refreshProgressChartView
{
    _proChartScrollView.frame = CGRectMake(5.f, 0.f, _progressShowWidth, _progressShowHeight);
    _proChartScrollView.center = CGPointMake(_progressChartWidth / 2, (_progressChartHeight / 2.f));
    _proChartContentView.frame = CGRectMake(0, 0, (_totalProgress * _progressCellWidth + 2 * _progressSpace), _progressShowHeight);
    _proChartScrollView.contentSize = _proChartContentView.bounds.size;
    NSMutableArray *subViews = [NSMutableArray arrayWithArray:[_proChartContentView subviews]];
    while (subViews.count > 0) {
        UIView *view = (UIView *)[subViews firstObject];
        if ([view superview]) {
            [view removeFromSuperview];
        }
        [subViews removeObject:view];
    }
    while ([[_proChartContentView.layer sublayers] count] > 0) {
        CALayer *layer = (CALayer *)[[_proChartContentView.layer sublayers] firstObject];
        if ([layer superlayer]) {
            [layer removeFromSuperlayer];
        }
    }
    
    CAShapeLayer *totalShapeLayer = [self progressShapeLayerProgress:_totalProgress color:_backProColor];
    [_proChartContentView.layer addSublayer:totalShapeLayer];
    CAShapeLayer *currentShapeLayer = [self progressShapeLayerProgress:_currentProgress color:_curProFromColor];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] initWithLayer:currentShapeLayer];
    gradientLayer.startPoint = CGPointMake(0.f, 0.f);
    gradientLayer.endPoint = CGPointMake(1.f, 0.f);
    [gradientLayer setColors:@[(__bridge id)_curProFromColor.CGColor, (__bridge id)_curProToColor.CGColor]];
    gradientLayer.frame = CGRectMake(0, 0, (_progressSpace + _progressCellWidth * _totalProgress), _progressChartHeight);
    [gradientLayer setMask:currentShapeLayer];
    [_proChartContentView.layer addSublayer:gradientLayer];
    [self addAnimationToLayer:currentShapeLayer progress:_currentProgress];
    
    CGFloat labWidth = 30.f;
    for (int i = 0; i <= _totalProgress; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i * _progressCellWidth + _progressSpace - labWidth / 2) , 17.5f, labWidth, 12.f)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9];
        label.text = [NSString stringWithFormat:@"%d", i];
        if (i <= _currentProgress) {
            if (i == floor(_currentProgress)) {
                label.textColor = [UIColor whiteColor];
                CAShapeLayer *anchorLayer = [self anchorShapeLayerCenter:CGPointMake((i * _progressCellWidth + _progressSpace - 0.3f), 23.2f) radius:6.2f color:_anchorColor clockwise:YES];
                [_proChartContentView.layer addSublayer:anchorLayer];
            } else {
                label.textColor = self.anchorColor;
            }
        } else {
            label.textColor = [UIColor blackColor];
        }
        
        [_proChartContentView addSubview:label];
        if (i != 0 && i != _totalProgress) {
            CAShapeLayer *spaceLayer = [self spaceShapeLayerRect:CGRectMake((i * _progressCellWidth + _progressSpace - 1.5 / 2) , (37.0 - _progressCellHeight / 2), 1.5f, _progressCellHeight) color:[UIColor whiteColor] clockwise:YES];
            [_proChartContentView.layer addSublayer:spaceLayer];
        }
        
    }
    
}

// 创建CAShapeLayer
- (CAShapeLayer *)progressShapeLayerProgress:(CGFloat)progress color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    CGFloat fromX = _progressSpace + _progressCellHeight / 2;
    CGFloat toX = (progress * _progressCellWidth + _progressSpace - _progressCellHeight / 2);
    CGFloat proWidth = progress * _progressCellWidth;
    if (proWidth <= _progressCellHeight) {
        toX = fromX;
    }
    [bezierPath moveToPoint:CGPointMake(fromX, 37.f)];
    [bezierPath addLineToPoint:CGPointMake(toX, 37.f)];
    
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = _progressCellHeight;
    shapeLayer.cornerRadius = _progressCellHeight / 2;
    shapeLayer.lineCap = kCALineCapRound;
    if (proWidth == 0) {
        shapeLayer.lineCap = kCALineCapButt;
    }
    shapeLayer.path = bezierPath.CGPath;
    
    return shapeLayer;
}

// 锚点
- (CAShapeLayer *)anchorShapeLayerCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color clockwise:(BOOL)clockwise
{
    CGFloat startAngle = M_PI_4 * 3;
    CGFloat endAngle = M_PI_4;
    CGFloat space = radius * cos(M_PI_4);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(center.x + space, center.y + space)];
    [bezierPath addLineToPoint:CGPointMake(center.x, center.y + 2 * space)];
    [bezierPath addLineToPoint:CGPointMake(center.x - space, center.y + space)];
    [bezierPath closePath];
    
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    
    [bezierPath appendPath:arcPath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    return shapeLayer;
}

// 空隙
- (CAShapeLayer *)spaceShapeLayerRect:(CGRect)rect color:(UIColor *)color clockwise:(BOOL)clockwise
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    return shapeLayer;
}
// 添加动画
- (void)addAnimationToLayer:(CAShapeLayer *)shapeLayer progress:(CGFloat)progress
{
    CABasicAnimation *shapeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    shapeAnimation.fromValue = @0.f;
    shapeAnimation.toValue = @1.f;
    shapeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shapeAnimation.beginTime = CACurrentMediaTime();
    shapeAnimation.duration = 1.f * progress / _totalProgress;
    shapeAnimation.fillMode = kCAFillModeBackwards;
    shapeAnimation.removedOnCompletion = YES;
    [shapeLayer addAnimation:shapeAnimation forKey:@"shapeAnimation"];
    
    CGPoint offset = CGPointMake(0.f, 0.f);
    if (progress <= 10) {
        offset = CGPointMake(0.f, 0.f);
    } else if ((_totalProgress - progress) <= 5.f) {
        CGFloat offsetX = _progressSpace / 2 + (_totalProgress - 10)* _progressCellWidth;
        offset = CGPointMake(offsetX, 0.f);
    } else {
        CGFloat offsetX = _progressSpace / 2 + (progress - 5)* _progressCellWidth;
        offset = CGPointMake(offsetX, 0.f);
    }
    
    [UIView animateWithDuration:(1.f * progress / _totalProgress) animations:^{
        [self.proChartScrollView setContentOffset:offset animated:NO];
    }];
    
}



@end
