//
//  ClockImageView.m
//  The Clock Drown
//
//  Created by HEYANG on 15/12/16.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

//  如果要复用的这个ClockImageView的话，要记得背景图片一同使用

#import "ClockImageView.h"
#import "YXEasing.h"

@interface ClockImageView ()

/** secondLayer */
@property (nonatomic,strong)CALayer *secondLayer;
/** minuteLayer */
@property (nonatomic,strong)CALayer *minuteLayer;
/** hourLayer */
@property (nonatomic,strong)CALayer *hourLayer;
@end

@implementation ClockImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    ClockImageView* clock;
    if (self) {
        clock = [[NSBundle mainBundle] loadNibNamed:@"ClockImageView" owner:nil options:nil][0];
        clock.backgroundColor = [UIColor whiteColor];
        clock.image = [UIImage imageNamed:@"clock.bundle/clock"];
    }
    return clock;
}

#pragma mark - 绘制时钟的秒针，分针，时针

//添加绘制的秒针
-(void)addSecond{
    CALayer* secondLayer = [CALayer layer];
    secondLayer.frame = CGRectMake(0, 0, 1, self.frame.size.width*0.45);
    secondLayer.backgroundColor = [UIColor redColor].CGColor;
    secondLayer.anchorPoint = CGPointMake(0.5, 0.9);
    secondLayer.position = CGPointMake(self.center.x, self.center.y);
    [self.layer addSublayer:secondLayer];
    self.secondLayer = secondLayer;
}


//添加绘制的分针
-(void)addMin{
    CALayer* minLayer = [CALayer layer];
    minLayer.frame = CGRectMake(0, 0, 3, self.frame.size.width*0.43);
    minLayer.backgroundColor = [UIColor blackColor].CGColor;
    minLayer.anchorPoint = CGPointMake(0.5, 0.9);
    minLayer.position = CGPointMake(self.center.x, self.center.y);
    [self.layer addSublayer:minLayer];
    self.minuteLayer = minLayer;
}

//添加绘制的时针
-(void)addHour{
    CALayer* hourLayer = [CALayer layer];
    hourLayer.frame = CGRectMake(0, 0, 5, self.frame.size.width*0.43);
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    hourLayer.anchorPoint = CGPointMake(0.5, 0.9);
    hourLayer.position = CGPointMake(self.center.x, self.center.y);
    [self.layer addSublayer:hourLayer];
    self.hourLayer = hourLayer;
}

//每秒调用一次的方法，该方法通过获取系统时间从而获取 时 分 秒 的时刻
-(void)timeChange{
    //获取系统时间的类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取日历当中的组件：年月日时分秒，这里只需要获取时分秒即可
    NSDateComponents *comp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger second = comp.second;
    NSInteger minute = comp.minute;
    NSInteger hour = comp.hour;

    
    //计算秒针旋转的角度,并让它旋转起来
    CGFloat secondAngle = second* M_PI / 30.0;
    CGFloat oldAngle = (second - 1)*M_PI / 30.0;
    [self getKeyAnimation:self.secondLayer
                oldRadian:oldAngle
                newRadian:secondAngle];
    
//    self.secondLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1);
    
    //计算分针旋转的角度，并让它旋转起来
    CGFloat minuteAngle = minute* M_PI / 30.0 + secondAngle / 60.0;
    self.minuteLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1);
    
    //计算时针旋转的角度，并让它旋转起来
    CGFloat hourAangle = hour* M_PI / 6.0 + minuteAngle / 12.0;
    self.hourLayer.transform = CATransform3DMakeRotation(hourAangle, 0, 0, 1);

    //总结：CATransform3DMakeRotation是从0开始直接到目标位置，如果变化量是30，他就直接在30
    //     所以不是每一次的变化量，而是和初始位置的间距量
}

//关键帧动画
-(void)getKeyAnimation:(CALayer*)layer oldRadian:(CGFloat)oldRadian newRadian:(CGFloat)newRadian{
    CAKeyframeAnimation* keyanim = [CAKeyframeAnimation animation];
    keyanim.duration = 1.1f;
    keyanim.keyPath = @"transform.rotation.z";
    
    keyanim.values = [YXEasing calculateFrameFromValue:oldRadian toValue:newRadian func:ElasticEaseOut frameCount:0.5*30];
    self.hourLayer.transform = CATransform3DMakeRotation(newRadian, 0, 0, 1);
    [layer addAnimation:keyanim forKey:nil];
}

//添加中心点
//-(void)addPoint{
//    CALayer* pointLayer = [CALayer alloc
////    pointLayer.
//} //无法随意添加绘制的图形，或许有我不知道的方法


-(void)awakeFromNib{
    [self addHour];
    [self addMin];
    [self addSecond];
    [self timeChange];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    
}


- (void)drawRect:(CGRect)rect {
}


@end
