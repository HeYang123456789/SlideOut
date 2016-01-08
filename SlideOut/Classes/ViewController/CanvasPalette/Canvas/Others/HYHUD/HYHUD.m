//
//  HYHUD.m
//  指示器
//
//  Created by HEYANG on 15/11/26.
//  Copyright © 2015年 HEYANG. All rights reserved.
//
#import "HYHUD.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

//自定义原始位置
#define originFrame CGRectMake(80, 250, 0, 0)

@interface HYHUD ()

/** 尺寸 */
@property (nonatomic,assign)CGSize size;

@end

@implementation HYHUD

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.alpha = 0.0f;//这里的透明度是将整个控件的透明度都改了，包括前景色
        /*
         * 不用这段代码：self.layer.backgroundColor = [UIColor blackColor].CGColor;而用下一行代码
         * 因为我希望，hud背景是半透明的，但是文字前景色是完全不透明的，所以需要将背景独立出来设置初始透明度
         */
        self.layer.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:0.4f].CGColor;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}
+(instancetype)shareHudWithTitle:(NSString*)title{
    HYHUD* hud = [[HYHUD alloc] init];
    hud.frame = originFrame;
    NSString* str = [NSString stringWithFormat:@"🐶 %@",title];
    hud.text = str;
    [hud sizeToFit];
    return hud;
}

-(void)show{
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.alpha = 1.0f;
                         self.frame = CGRectMake(80, 250, screenW*0.5, 50);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.6
                                               delay:1.5
                                             options:kNilOptions
                                          animations:^{
                                              self.alpha = 0.0f;
                                              self.frame = originFrame;
                                          }
                                          completion:nil];
                     }];
}

-(void)setSize:(CGSize)size{
    _size = size;
    CGRect frame = self.frame;
    frame.size = _size;
    self.frame = frame;
}
@end









