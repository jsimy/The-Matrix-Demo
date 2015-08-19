//
//  SDCALayer.h
//  06-26CALayers
//
//  Created by sj_imy on 15-6-26.
//  Copyright (c) 2015年 盛东. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface SDCALayer : CALayer

@property (nonatomic ,copy)NSString *text;

- (instancetype)initWithText:(NSString *)string andWithTextColor:(UIColor *)color andWithTextSize:(UIFont *)font;

@end
