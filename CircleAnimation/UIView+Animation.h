//
//  UIView+Animation.h
//  CircleAnimation
//
//  Created by 李博文 on 2022/9/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)

/// 🚀围绕圆心动画
- (void)rocketAnimation:(CGFloat)progress
             pathCenter:(CGPoint)pathCenter
                 radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
