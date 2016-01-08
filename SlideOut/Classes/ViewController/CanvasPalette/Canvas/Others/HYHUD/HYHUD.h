//
//  HYHUD.h
//  指示器
//
//  Created by HEYANG on 15/11/26.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYHUD : UILabel

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

+(instancetype)shareHudWithTitle:(NSString*)title;

-(void)show;

@end
