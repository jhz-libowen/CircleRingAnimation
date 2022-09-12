//
//  UIView+Tools.m
//  EGou
//
//  Created by 李博文 on 2019/10/8.
//  Copyright © 2019 com.emar.egou. All rights reserved.
//

#import "UIView+Tools.h"
#import <objc/runtime.h>
static const char * kHitEdgeInsets = "hitEdgeInset";
static NSString * kisNeedsInsert = @"isNeedsInsert";
static const char * UIViewName_Key = "BUAdSDK_adslotID";

@implementation UIView (Tools)



- (void)setBUAdSDK_adslotID:(NSString *)adslotID {
    objc_setAssociatedObject(self, UIViewName_Key, adslotID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)BUAdSDK_adslotID {
    return objc_getAssociatedObject(self, UIViewName_Key);
}

#pragma mark - set Method
-(void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets{
    NSValue *value = [NSValue value:&hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, kHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsNeedsInsert:(BOOL)isNeedsInsert {
    objc_setAssociatedObject(self, &kisNeedsInsert, @(isNeedsInsert),  OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - get method
-(UIEdgeInsets)hitEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, kHitEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets:UIEdgeInsetsZero;
}

- (BOOL)isNeedsInsert {
    return [objc_getAssociatedObject(self, &kisNeedsInsert) boolValue];
}

#pragma mark - override super method
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

- (void)setGradientColorWithDirections:(GradientColorDirections)directions start:(UIColor *)startColor end:(UIColor *)endColor
{
    NSMutableArray <CAGradientLayer *>*arrM = [NSMutableArray array];
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [arrM addObject:(CAGradientLayer *)layer];
        }
    }
    [arrM makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.frame = self.bounds;
    
    
    switch (directions) {
        case GradientColorDirections_Left:
            gradientLayer.startPoint =  CGPointMake(1.0, 0.5);
            gradientLayer.endPoint = CGPointMake(0.0, 0.5);
            break;
        case GradientColorDirections_Right:
            gradientLayer.startPoint =  CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
            break;
        case GradientColorDirections_Top:
            gradientLayer.startPoint =  CGPointMake(0.5, 1.0);
            gradientLayer.endPoint = CGPointMake(0.5, 0.0);
            break;
        case GradientColorDirections_DiagonalDown:
            gradientLayer.startPoint =  CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
            case GradientColorDirections_HomeHeader:
            gradientLayer.startPoint =  CGPointMake(0.25, 0.0);
            gradientLayer.endPoint = CGPointMake(1.15, 1.53);
            break;
        default:
            gradientLayer.startPoint =  CGPointMake(0.5, 0.0);
            gradientLayer.endPoint = CGPointMake(0.5, 1.0);
            break;
    }
//    gradientLayer.locations = @[@0.0, @0.9];
    
    if ([self isKindOfClass:[UIButton class]] || self.isNeedsInsert) {
        [self.layer insertSublayer:gradientLayer atIndex:0];
    }else {
        [self.layer addSublayer:gradientLayer];
    }
}

- (void)EG_CornerRadiusLeftandRight:(CGFloat)cornerRadii
{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

- (void)EG_CornerRadiusLeftBottomandRightBottom:(CGFloat)cornerRadii
{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

@end
