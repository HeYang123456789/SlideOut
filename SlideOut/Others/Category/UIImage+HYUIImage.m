//
//  UIImage+HYUIImage.m
//  SlideOut
//
//  Created by HEYANG on 15/12/15.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "UIImage+HYUIImage.h"

@implementation UIImage (HYUIImage)

+(UIImage *)imageWithRenderingOriginalName:(NSString*)name{
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
