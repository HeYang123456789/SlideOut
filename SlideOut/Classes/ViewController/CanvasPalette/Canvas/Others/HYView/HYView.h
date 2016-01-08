//
//  HYView.h
//  ProjectionTest
//
//  Created by HEYANG on 15/11/27.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYView : UIView

/** 自定义Frame.orgin */
@property (nonatomic,assign)CGPoint origin;

+ (instancetype)shareHyView;

-(void)setOrigin:(CGPoint)origin;

@end
