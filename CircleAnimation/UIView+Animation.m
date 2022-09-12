//
//  UIView+Animation.m
//  CircleAnimation
//
//  Created by 李博文 on 2022/9/12.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)rocketAnimation:(CGFloat)progress
             pathCenter:(CGPoint)pathCenter
                 radius:(CGFloat)radius {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat endAngle = progress*(2*M_PI) + M_PI_2 - M_PI/20;
    if (progress >= 1) {
        endAngle += M_PI/20;
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:radius startAngle:M_PI_2 endAngle:endAngle clockwise:YES];
    keyframeAnimation.path = bezierPath.CGPath;
    keyframeAnimation.calculationMode = kCAAnimationPaced;
    keyframeAnimation.rotationMode = kCAAnimationRotateAutoReverse;
    keyframeAnimation.duration = 1;
    keyframeAnimation.repeatCount = 1;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:keyframeAnimation forKey:@"rocketAnimation"];
}

@end
