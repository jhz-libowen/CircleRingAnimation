//
//  UIView+Tools.h
//  EGou
//
//  Created by 李博文 on 2019/10/8.
//  Copyright © 2019 com.emar.egou. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientColorDirections) {
    GradientColorDirections_Right,
    GradientColorDirections_Left,
    GradientColorDirections_Top,
    GradientColorDirections_Bottom,
    GradientColorDirections_HomeHeader,
    GradientColorDirections_DiagonalDown
};

@interface UIView (Tools)

@property (nonatomic, copy) NSString *BUAdSDK_adslotID;

@property(nonatomic, assign) BOOL isNeedsInsert;

/**
自定义响应边界 UIEdgeInsetsMake(top, left, bottom, right). 负值表示扩大  正值表示缩小  0表示不变
 
例如： self.view.hitEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);  表示上 左 下 右 分别增加10dp的点击区域大小
*/
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;

//设置渐变色
- (void)setGradientColorWithDirections:(GradientColorDirections)directions start:(UIColor *)startColor end:(UIColor *)endColor;

//上边左右圆角
- (void)EG_CornerRadiusLeftandRight:(CGFloat)cornerRadii;
- (void)EG_CornerRadiusLeftBottomandRightBottom:(CGFloat)cornerRadii;

@end

NS_ASSUME_NONNULL_END
