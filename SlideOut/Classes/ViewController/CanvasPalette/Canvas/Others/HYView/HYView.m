
//
//  HYView.m
//  ProjectionTest
//
//  Created by HEYANG on 15/11/27.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "HYView.h"

@implementation HYView
-(void)awakeFromNib{
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(35, 100, 300, 50);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    //阴影的透明度
    self.layer.shadowOpacity = 0.5f;
    //阴影的圆角度数
    self.layer.shadowRadius = 3.0f;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 15;
}
+ (instancetype)shareHyView{
    return [[self alloc] init];
}
#pragma mark - 重写frame的set方法
-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

@end
