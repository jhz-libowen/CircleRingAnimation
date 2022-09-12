//
//  BWCircleRingView.h
//  CircleAnimation
//
//  Created by 李博文 on 2022/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWCircleRingView : UIView

/** 进度条的宽度 默认为10 */
@property (assign, nonatomic) CGFloat lineWidth;

/** 圆环进度动画 进度值0-1 */
- (void)strokeEndAnimation:(CGFloat)progress;

- (void)configLayer:(CGPoint)startPoint
           endPoint:(CGPoint)endPoint
         startColor:(UIColor *)startColor
           endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
