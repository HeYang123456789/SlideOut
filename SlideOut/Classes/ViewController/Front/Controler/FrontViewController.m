//
//  FrontViewController.m
//  SlideOut
//
//  Created by HEYANG on 15/12/14.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "UIImage+HYUIImage.h"
#import "ClockImageView.h"

@interface FrontViewController ()

@end

@implementation FrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、设置导航条显示的标题
    self.title = @"Front View";
    
    //2、利用框架内置的可以直接使用的手势
    //  注意：不需要通过alloc-init新建哦，直接用self.revealViewController就能获取容器控制器
    //SWRevealViewController *revealController = [[SWRevealViewController alloc] init];
    SWRevealViewController* revealController = self.revealViewController;
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //3、为导航控制器添加Item，并设置Item跳转的视图 这里可能以后容易遗忘，要多敲代码多看
    // 本来我以为应该跳转到后置控制器rearVC的，但是这里是直接跳转到容器控制器revealVC
    // target:跳转到的目标控制器 action:并执行目标控制器对象里的方法，这里是revealToggle:方法，固定的，要熟悉
    UIImage* image = [UIImage imageWithRenderingOriginalName:@"reveal-icon"];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc]
                                         initWithImage:image
                                                 style:UIBarButtonItemStylePlain
                                                target:revealController
                                                action:@selector(revealToggle:)];
    UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc]
                                        initWithImage:image
                                        style:UIBarButtonItemStylePlain
                                        target:revealController
                                        action:@selector(rightRevealToggle:)];
    
//    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc]
//                                         initWithImage:[UIImage imageNamed:@"reveal-icon"]
//                                         style:UIBarButtonItemStylePlain
//                                         target:revealController
//                                         action:@selector(revealToggle:)];
    
//    UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc]
//                                        initWithImage:[UIImage imageNamed:@"reveal-icon"]
//                                                style:UIBarButtonItemStylePlain
//                                               target:revealController
//                                               action:@selector(rightRevealToggle:)];
    //4、为导航控制器添加item
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [self setup];

}


-(void)setup{
    
    ClockImageView* clockView = [[ClockImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    clockView.center = self.view.center;
    [self.view addSubview:clockView];
}

@end
