//
//  BWCircleRingView.m
//  CircleAnimation
//
//  Created by 李博文 on 2022/9/11.
//

#import "BWCircleRingView.h"
#import "UIView+Tools.h"

@interface BWCircleRingView ()

@property(nonatomic, strong) CAGradientLayer *gradientLayer;
@property(nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation BWCircleRingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _lineWidth = 10;
    [self.layer addSublayer:self.gradientLayer];
    [self.layer setMask:self.shapeLayer];
}

#pragma mark -- overload
- (void)drawRect:(CGRect)rect {
    self.gradientLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    CGFloat slideLength = self.bounds.size.width;
    CGFloat centerX = slideLength/2;
    CGFloat centerY = slideLength/2;
    // 添加Mask轨道
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:(slideLength-_lineWidth)/2 startAngle:M_PI_2 endAngle:(2*M_PI) +  M_PI_2 clockwise:YES];
    _shapeLayer.path = bezierPath.CGPath;
}

#pragma mark -- animation
- (void)strokeEndAnimation:(CGFloat)progress {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = [NSNumber numberWithFloat:0];
    strokeEndAnimation.toValue = [NSNumber numberWithFloat:progress];
    strokeEndAnimation.repeatCount = 1;
    strokeEndAnimation.duration = 1;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    [self.shapeLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}

#pragma mark -- config
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    _shapeLayer.lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)configLayer:(CGPoint)startPoint
           endPoint:(CGPoint)endPoint
         startColor:(UIColor *)startColor
           endColor:(UIColor *)endColor {
    self.gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    [self.gradientLayer setStartPoint:startPoint];
    [self.gradientLayer setEndPoint:endPoint];
}

#pragma mark -- lazy
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        //圆环遮罩
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.lineWidth = _lineWidth;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 0;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineDashPhase = 0.8;
    }
    return _shapeLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        //初始化一个渐变图层
        _gradientLayer = [CAGradientLayer layer];
        [_gradientLayer setLocations:@[@0,@1]];
    }
    return _gradientLayer;
}

@end
