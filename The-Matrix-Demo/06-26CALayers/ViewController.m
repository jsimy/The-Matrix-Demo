//
//  ViewController.m
//  06-26CALayers
//
//  Created by sj_imy on 15-6-26.
//  Copyright (c) 2015年 盛东. All rights reserved.
//

// 为了实现透视效果, 应该以字体大小为参数, 字体大的字符串下落越快, 并且字体大的字符串颜色越'亮',

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.userInteractionEnabled = NO;
    
    for (int i = 0; i < 180; i++) {
      
        [self startAnimation];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    [self startAnimation];
}

- (void)startAnimation
{
    UIView *SDView = [[UIView alloc]init];
    
    SDView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    // 1.拼接随机字符串,
    NSMutableString *str1 = [NSMutableString string];
    int count = arc4random_uniform(18)+8;
    for (int i = 0 ; i < count; i++) {
        char index = arc4random_uniform(100)%2 ? '0' : '1';
        [str1 appendFormat:@"%c",index];
        [str1 appendString:@"\r"];
        [str1 appendString:@"\n"];
    }
    
    NSString *str = [str1 copy];
    UILabel *label = [[UILabel alloc]init];
    label.text = str;
    label.numberOfLines = 0;
    
    // 以fontSize为参数
    CGFloat fontSize = arc4random_uniform(13)+8;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    label.font = font;
    [label sizeToFit];
    label.textColor = [UIColor colorWithRed:0 green:(fontSize - 8)/20 blue:0 alpha:1];
    
    CGFloat height = label.bounds.size.height;
    
    CGFloat time =(arc4random_uniform(119)+1)/10.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SDView addSubview:label];
        [self.view addSubview:SDView];
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
        
        // 随机 x
        CGFloat x = arc4random_uniform(375);
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, -height)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(x, 667)];
        
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        anim.delegate = self;
        
        anim.duration = 8*8.0/fontSize;
        
        [SDView.layer addAnimation:anim forKey:nil];
    });
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
