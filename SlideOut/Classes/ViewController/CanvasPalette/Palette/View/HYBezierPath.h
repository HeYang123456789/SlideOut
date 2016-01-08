//
//  HYBezierPath.h
//  TouchPainter
//
//  Created by HEYANG on 15/12/13.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBezierPath : UIBezierPath

/** color */
@property (nonatomic,strong)UIColor *color;

/** setColor */
-(void)setColor:(UIColor *)color;
@end
