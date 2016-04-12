//
//  ViewController.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/10.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TLAnimationHandler.h"
#import "TLLoginViewModel.h"
#import "BookListViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    UIActivityIndicatorView *_loading;
    UIImageView *_statusImageView;
    UILabel *_messageLabel;
    NSArray *_messages;
    UILabel *_infoLabel;
    
    CGPoint _statusPosition;
    
    TLLoginViewModel *_loginViewModel;
    BookListViewController *_bookListViewController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//     _messages = @[@"Connecting ...", @"Authorizing ...", @"Sending credentials ...", @"Failed"];
     _messages = @[@"Authorizing ...", @"Failed"];
    
    _loginBtn.layer.cornerRadius = 8.0;
    _loginBtn.layer.masksToBounds = true;
    
    _loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_loading startAnimating];
    _loading.frame = CGRectMake(0.0, 6.0, 20.0, 20.0);
    _loading.alpha = 0;
    [_loginBtn addSubview:_loading];
    
    _statusImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner"]];
    _statusImageView.hidden = YES;
    _statusImageView.center = _loginBtn.center;
    [self.view addSubview:_statusImageView];
    
    _messageLabel = [[UILabel alloc]init];
    _messageLabel.frame = CGRectMake(0, 0, _statusImageView.frame.size.width, _statusImageView.frame.size.height);
    _messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    _messageLabel.textColor = [UIColor colorWithRed:0.89 green:0.38 blue:0.0 alpha:1.0];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [_statusImageView addSubview:_messageLabel];
    
    _statusPosition = _statusImageView.center;
    
    _infoLabel = [[UILabel alloc]init];
    _infoLabel.frame = CGRectMake(0, _loginBtn.center.y+80.0, self.view.frame.size.width, 30);
    _infoLabel.backgroundColor = [UIColor clearColor];
    _infoLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.text = @"Tap on a field and enter username and password";
    [self.view insertSubview:_infoLabel belowSubview:_loginBtn];
    
    
    _loginViewModel = [[TLLoginViewModel alloc]init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [TLAnimationHandler delayWithSeconds:5 withCompletion:^{
        NSLog(@"where is the fields");
    }];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    fadeInAnimation.duration = 0.5;
    fadeInAnimation.fillMode = kCAFillModeBackwards;
    fadeInAnimation.beginTime = CACurrentMediaTime() + 0.5;
    [_cloudOne.layer addAnimation:fadeInAnimation forKey:nil];
    
    fadeInAnimation.beginTime = CACurrentMediaTime() + 0.7;
    [_cloudTwo.layer addAnimation:fadeInAnimation forKey:nil];
    
    fadeInAnimation.beginTime = CACurrentMediaTime() + 0.9;
    [_cloudThree.layer addAnimation:fadeInAnimation forKey:nil];
    
    fadeInAnimation.beginTime = CACurrentMediaTime() + 1.1;
    [_cloudFour.layer addAnimation:fadeInAnimation forKey:nil];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CAAnimationGroup *formGroupAnimation = [[CAAnimationGroup alloc]init];
    formGroupAnimation.duration = 0.5;
    formGroupAnimation.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *flyRightAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRightAnimation.fromValue = [NSNumber numberWithFloat:-self.view.bounds.size.width/2];
    flyRightAnimation.toValue = [NSNumber numberWithFloat: self.view.bounds.size.width/2];
    
    CABasicAnimation *fadeFieldInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeFieldInAnimation.fromValue = [NSNumber numberWithFloat: 0.25];
    fadeFieldInAnimation.toValue = [NSNumber numberWithFloat: 1.0];

    formGroupAnimation.animations = [NSArray arrayWithObjects:flyRightAnimation,fadeFieldInAnimation, nil];
    [_heading.layer addAnimation:formGroupAnimation forKey:nil];
    
    formGroupAnimation.delegate = self;
    [formGroupAnimation setValue:@"form" forKey:@"name"];
    [formGroupAnimation setValue:_username.layer forKey:@"layer"];
    
    formGroupAnimation.beginTime = CACurrentMediaTime() + 0.3;
    [_username.layer addAnimation:formGroupAnimation forKey: nil];
    
    [formGroupAnimation setValue:_password.layer forKey:@"layer"];
    formGroupAnimation.beginTime = CACurrentMediaTime() + 0.4;
    [_password.layer addAnimation:formGroupAnimation forKey: nil];
    
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5;
    groupAnimation.duration = 0.5;
    groupAnimation.fillMode = kCAFillModeBackwards;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *scaleDownAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleDownAnimation.fromValue = [NSNumber numberWithFloat: 3.5];
    scaleDownAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat: M_PI_4];
    rotateAnimation.toValue = [NSNumber numberWithFloat: 0.0];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    
    groupAnimation.animations = @[scaleDownAnimation,rotateAnimation,fadeAnimation];
    [_loginBtn.layer addAnimation:groupAnimation forKey:nil];
    
    [self animateCloudInLayer:_cloudOne.layer];
    [self animateCloudInLayer:_cloudTwo.layer];
    [self animateCloudInLayer:_cloudThree.layer];
    [self animateCloudInLayer:_cloudFour.layer];
    
    CABasicAnimation *flyLeftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyLeftAnimation.fromValue = [NSNumber numberWithFloat:_infoLabel.layer.position.x +
                                  self.view.frame.size.width];
    flyLeftAnimation.toValue = [NSNumber numberWithFloat: _infoLabel.layer.position.x];
    
    flyLeftAnimation.duration = 5.0;
    [_infoLabel.layer addAnimation:flyLeftAnimation forKey: @"infoappear"];
    
    CABasicAnimation *fadeLabelInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeLabelInAnimation.fromValue = [NSNumber numberWithFloat: 0.2];
    fadeLabelInAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    fadeLabelInAnimation.duration = 4.5;
    [_infoLabel.layer addAnimation:fadeLabelInAnimation forKey: @"fadein"];
    
    _username.delegate = self;
    _password.delegate = self;
    
    
    [_username.rac_textSignal subscribeNext:^(id x){
        NSLog(@"%@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(UIButton *)sender {
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect bounds = self.loginBtn.bounds;
        bounds.size.width +=80;
        self.loginBtn.bounds = bounds;
    } completion:nil];
    
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        CGPoint center =  self.loginBtn.center;
        center.y +=60.0;
        self.loginBtn.center = center;
        
        _loading.center = CGPointMake(40.0, _loginBtn.frame.size.height/2);
        _loading.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self showMessageWithIndex:0];
    }];
    
    UIColor *tintColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
    [TLAnimationHandler tintBackgroundColorWithLayer:self.loginBtn.layer toColor:tintColor];
    [TLAnimationHandler roundCornersWithLayer:self.loginBtn.layer toRadius:25.0];
    
    CALayer *balloonLayer = [[CALayer alloc]init];
    balloonLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"ballon"].CGImage);
    balloonLayer.frame = CGRectMake(-50, 0, 50, 65);
    [self.view.layer insertSublayer:balloonLayer below:_username.layer];
    
    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.duration = 12.0;
    flightAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(-50.0, 0.0)],
                               [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width+50.0, 160)],
                               [NSValue valueWithCGPoint:CGPointMake(-50.0, _loginBtn.center.y)]
                               ];
    flightAnimation.keyTimes = @[@0.0, @0.5, @1.0];
    [balloonLayer addAnimation:flightAnimation forKey:nil];
    balloonLayer.position = CGPointMake(-50.0, _loginBtn.center.y);
    
    _loginViewModel.user.userName = _username.text;
    _loginViewModel.user.password = _password.text;
}

- (void)resetForm{
    CAKeyframeAnimation *wobbleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    wobbleAnimation.duration = 0.25;
    wobbleAnimation.repeatCount = 4;
    wobbleAnimation.values = @[@0.0, @(-M_PI_4/4), @0.0, @(M_PI_4/4), @0.0];
    wobbleAnimation.keyTimes = @[@0.0, @0.25, @0.5, @0.75, @1.0];
    [_heading.layer addAnimation:wobbleAnimation forKey:nil];
    
    [UIView transitionWithView:_statusImageView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        _statusImageView.hidden = YES;
        _statusImageView.center = _statusPosition;
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        CGPoint center =  self.loginBtn.center;
        center.y +=60.0;
        self.loginBtn.center = center;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
        _loading.center = CGPointMake(-20.0, 16.0);
        _loading.alpha = 0;
        
        CGRect bounds = self.loginBtn.bounds;
        bounds.size.width -=80;
        CGPoint center =  self.loginBtn.center;
        
        self.loginBtn.bounds = bounds;
        self.loginBtn.center = CGPointMake(center.x, center.y-120);
    } completion:^(BOOL finished){
        UIColor *tintColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        [TLAnimationHandler tintBackgroundColorWithLayer:self.loginBtn.layer toColor:tintColor];
        [TLAnimationHandler roundCornersWithLayer:self.loginBtn.layer toRadius:10.0];
    }];
}

- (void)showMessageWithIndex:(int)index{
    _messageLabel.text = _messages[index];
    
    [UIView transitionWithView:_statusImageView duration:0.33 options:UIViewAnimationOptionCurveEaseOut & UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        _statusImageView.hidden = NO;
    } completion:^(BOOL finished){
        [TLAnimationHandler delayWithSeconds:2.0 withCompletion:^{
            if (index < _messages.count - 1) {
                if ([_loginViewModel judgeUser])
                {
                    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
                    _bookListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"booklistView"];
                    [self presentViewController:_bookListViewController animated:YES completion:nil];
                }else
                {
                    [self removeMessageWithIndex:index];
                }
            }else{
                [self resetForm];
            }
        }];
    }];
}

- (void)removeMessageWithIndex:(int)index
{
    [UIView transitionWithView:_statusImageView duration:0.33 options:UIViewAnimationOptionCurveEaseOut & UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        CGPoint center = _statusImageView.center;
        center.x += self.view.frame.size.width;
        _statusImageView.center = center;
    } completion:^(BOOL finished){
        [TLAnimationHandler delayWithSeconds:2.0 withCompletion:^{
            _statusImageView.hidden = YES;
            _statusImageView.center = _statusPosition;
            [self showMessageWithIndex:index +1];
        }];
    }];
}

//云朵动画
- (void)animateCloudInLayer:(CALayer*)layer{
    NSTimeInterval duration = (self.view.layer.frame.size.width - layer.frame.origin.x) * 60.0 / self.view.layer.frame.size.width;
    
    CABasicAnimation *cloudMoveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    cloudMoveAnimation.toValue = [NSNumber numberWithDouble:self.view.bounds.size.width + layer.bounds.size.width/2];
    cloudMoveAnimation.duration = duration;
    cloudMoveAnimation.delegate = self;
    [cloudMoveAnimation setValue:@"cloud" forKey:@"name"];
    [cloudMoveAnimation setValue:layer forKey:@"layer"];
    
    [layer addAnimation:cloudMoveAnimation forKey:nil];
}

//文本输入
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@",_infoLabel.layer.animationKeys);
    [_infoLabel.layer removeAnimationForKey:@"infoappear"];
}

//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag)
    {
        NSLog(@"animation did finish");
        NSString *name = [anim valueForKey:@"name"];
        if ([name isEqualToString:@"form"])
        {
            CALayer *layer = [anim valueForKey:@"layer"];
            [anim setValue:nil forKey:@"layer"];
            CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            pulseAnimation.fromValue = [NSNumber numberWithFloat:1.25];
            pulseAnimation.toValue = [NSNumber numberWithFloat:1.0];
            pulseAnimation.duration = 0.25;
            [layer addAnimation:pulseAnimation forKey:nil];
        }
        if ([name isEqualToString:@"cloud"])
        {
            CALayer *layer = [anim valueForKey:@"layer"];
            [anim setValue:nil forKey:@"layer"];
            CGPoint position = layer.position;
            position.x = -layer.bounds.size.width/2;
            layer.position = position;
            __weak __typeof(self)weakSelf = self;
            [TLAnimationHandler delayWithSeconds:0.5 withCompletion:^{
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                [strongSelf animateCloudInLayer:layer];
            }];
        }
    }
}


-(void)dealloc
{
    _username.delegate = nil;
    _password.delegate = nil;
}

@end
