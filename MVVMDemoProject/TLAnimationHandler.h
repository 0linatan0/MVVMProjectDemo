//
//  TLAnimationHandler.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TLAnimationHandler : NSObject

//图层圆角化
+ (void)roundCornersWithLayer:(CALayer*)layer toRadius:(CGFloat)radius;

//改变背景颜色
+ (void)tintBackgroundColorWithLayer:(CALayer*)layer toColor:(UIColor *)color;

// A delay function
+ (void)delayWithSeconds:(double)seconds withCompletion:(void (^)())completion;
    
@end
