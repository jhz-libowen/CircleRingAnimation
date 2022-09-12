//
//  ViewController.m
//  CircleAnimation
//
//  Created by 李博文 on 2022/9/11.
//

#import "ViewController.h"
#import "BWCircleRingView.h"
#import "UIView+Animation.h""

/**
 *  颜色
 */

#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kUIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)a]

@interface ViewController ()

@property(nonatomic, strong) BWCircleRingView *bw_view;
@property(nonatomic, strong) UIImageView *rocketImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bw_view = [[BWCircleRingView alloc] initWithFrame:CGRectMake(0, 0, 264, 264)];
    [self.view addSubview:_bw_view];
    _bw_view.center = CGPointMake(self.view.center.x, self.view.center.y);
    [_bw_view configLayer:CGPointMake(0.25, 0.5) endPoint:CGPointMake(0.75, 0.5) startColor:kUIColorFromRGB(0xDEE3F5) endColor:kUIColorFromRGB(0x9EB2E1)];
    
    _rocketImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"temp"]];
    [self.view addSubview:_rocketImgView];
    _rocketImgView.center = CGPointMake(_bw_view.center.x, _bw_view.center.y + 310/2);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat random = (arc4random()%10 + 1)*0.1;
    
    [_bw_view strokeEndAnimation:random];
    
    _bw_view.lineWidth = random*20;
    [_bw_view configLayer:CGPointMake(0.25, 0.5) endPoint:CGPointMake(0.75, 0.5) startColor:kUIColorFromRGB(0xFF995C) endColor:kUIColorFromRGB(0xFFE254)];
    

    [_rocketImgView rocketAnimation:random pathCenter:_bw_view.center radius:310/2];
}


 

@end
