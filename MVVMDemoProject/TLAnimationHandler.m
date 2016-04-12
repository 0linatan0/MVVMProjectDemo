//
//  TLAnimationHandler.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "TLAnimationHandler.h"

@implementation TLAnimationHandler


- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

// A delay function
+ (void)delayWithSeconds:(double)seconds withCompletion:(void (^)())completion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

//改变背景颜色
+ (void)tintBackgroundColorWithLayer:(CALayer*)layer toColor:(UIColor *)color{
    CABasicAnimation *tintAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    tintAnimation.fromValue = (__bridge id _Nullable)(layer.backgroundColor);
    tintAnimation.toValue = (__bridge id _Nullable)(color.CGColor);
    tintAnimation.duration = 1.0;
    [layer addAnimation:tintAnimation forKey:nil];
    layer.backgroundColor = color.CGColor;
}

//图层圆角化
+ (void)roundCornersWithLayer:(CALayer*)layer toRadius:(CGFloat)radius{
    CABasicAnimation *roundAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    roundAnimation.fromValue = [NSNumber numberWithFloat:layer.cornerRadius];
    roundAnimation.toValue = [NSNumber numberWithFloat:radius];
    roundAnimation.duration = 0.33;
    [layer addAnimation:roundAnimation forKey:nil];
    layer.cornerRadius = radius;
}

@end
