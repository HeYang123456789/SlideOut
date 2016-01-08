//
//  CancasView.h
//  TouchPainter
//
//  Created by HEYANG on 15/12/12.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface CancasView : UIView

/** model */
@property (nonatomic,strong)Model *model;

/** 存储path的可变数组索引 */
@property (nonatomic,strong)NSMutableArray *array;

/** 存储撤销的path的可变数组索引 */
@property (nonatomic,strong)NSMutableArray *replayArray;


/** 是否使用橡皮 */
@property (nonatomic,assign,getter=isRubber)BOOL rubber;

-(void)clear;

@end
