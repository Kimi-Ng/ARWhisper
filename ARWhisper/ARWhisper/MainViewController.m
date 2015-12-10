//
//  MainViewController.m
//  ARWhisper
//
//  Created by Cheng-Yuan Wu on 12/9/15.
//  Copyright © 2015 Kimi. All rights reserved.
//
//Ripple Effect Reference:
//https://gist.github.com/ShingoFukuyama/ad55e2f72b4c2bb22a4e
//https://github.com/skyming/BMWaveDemo

#import "MainViewController.h"

@interface MainViewController () //<UIGestureRecognizerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    singleFingerTap.delegate = self;
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{

    CGPoint touchPt = [recognizer locationInView:self.view];
    //CGPointMake(self.view.frame.origin.x + self.view.frame.size.width/2, self.view.frame.origin.y + self.view.frame.size.height/2);
    [self addTouchPointDot:self.view center:touchPt color:[UIColor blackColor] radius:3.0f];
    [self rippleWithView:self.view center:touchPt colorFrom:[UIColor redColor] colorTo:[UIColor yellowColor]];

}

- (void)rippleWithView:(UIView *)view center:(CGPoint)center colorFrom:(UIColor *)colorFrom colorTo:(UIColor *)colorTo
{
    if (!view) {
        return;
    }
    CGFloat radius = 40.0f;
    UIView *ripple = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, radius, radius)];
    ripple.layer.cornerRadius = radius * 0.5f;
    ripple.backgroundColor = colorFrom;
    ripple.alpha = 1.0f;
    [view insertSubview:ripple atIndex:0];
    ripple.center = center;
    CGFloat scale = 8.0f;
    [UIView animateWithDuration:0.6f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        ripple.transform = CGAffineTransformMakeScale(scale, scale);
        ripple.alpha = 0.0f;
        ripple.backgroundColor = colorTo;
    } completion:^(BOOL finished) {
        [ripple removeFromSuperview];
    }];
}

- (void)addTouchPointDot:(UIView *)view center:(CGPoint)center color:(UIColor *)color radius:(CGFloat)radius
{
    UIView *dot = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2*radius, 2*radius)];
    dot.layer.cornerRadius = radius;
    dot.backgroundColor = color;
    dot.alpha = 1.0f;
    [view insertSubview:dot atIndex:0];
    dot.center = center;

}

@end
