//
//  HYBezierPath.m
//  TouchPainter
//
//  Created by HEYANG on 15/12/13.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "HYBezierPath.h"

@implementation HYBezierPath

-(void)setColor:(UIColor *)color{
    _color = color;
    if (!_color) {
        _color = [UIColor blackColor];
    }
}

@end
