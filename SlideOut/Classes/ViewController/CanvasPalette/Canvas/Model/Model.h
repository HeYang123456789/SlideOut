//
//  Model.h
//  TouchPainter
//
//  Created by HEYANG on 15/12/12.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Model : NSObject

/** red */
@property (nonatomic,strong)NSNumber* red;
/** green */
@property (nonatomic,strong)NSNumber* green;
/** blue */
@property (nonatomic,strong)NSNumber* blue;
/** stroke size */
@property (nonatomic,strong)NSNumber* size;

-(void)setRed:(NSNumber*)r green:(NSNumber*)g blue:(NSNumber*)b;
-(void)setRed:(NSNumber*)r green:(NSNumber*)g blue:(NSNumber*)b  size:(NSNumber*)s;

-(UIColor*)getModelColor;
-(CGFloat)getModelSize;
@end
