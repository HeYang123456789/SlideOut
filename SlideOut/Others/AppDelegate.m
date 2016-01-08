//
//  AppDelegate.m
//  SlideOut
//
//  Created by HEYANG on 15/12/14.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h" //1、导入这个框架头文件
#import "FrontViewController.h"
#import "RearViewController.h"
#import "RightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //2、创建并为AppDelegate添加UIWindow对象
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
    //3、因为要创建的SWRevealViewController对象是要作为其他控制器的容器的。
    // 所以，要创建需要容纳的 后置控制器(左侧栏)、前置控制器、右置控制器<rear,front,right>
    // 先在项目工程里，新建这三个继承UIVC的控制器以及各自管理的xib。
    
    //3-1 创建这三个控制器对象
    FrontViewController* frontVC = [[FrontViewController alloc] init];
    RearViewController* rearVC = [[RearViewController alloc] init];
    RightViewController* rightVC = [[RightViewController alloc] init];
    //3-2 因为便于交互和前置控制器视图和后置视图交互，所以需要导航控制器的导航条作用
    //    并将前面创建的frontVC和rearVC设置其对应导航控制器的根控制器
    UINavigationController *frontNavigationVC = [[UINavigationController alloc] initWithRootViewController:frontVC];
    UINavigationController *rearNavigationVC = [[UINavigationController alloc] initWithRootViewController:rearVC];
    //3-3 在这里rightVC就不设置添加到导航控制器了，实际开发根据实际需求。
    
    //4 创建SWRevealViewController对象作为容器，并在仅仅提供的初始化方法添加后置和前置控制器
    //  这里当然添加的是 后置和前置 导航控制器
    SWRevealViewController* revealViewController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationVC frontViewController:frontNavigationVC];
    
    //5 设置右置控制器背景为green，然后添加进这个revealViewController容器中
    [rightVC.view setBackgroundColor:[UIColor greenColor]];
    revealViewController.rightViewController = rightVC;
    
    
    //6、最后把这个容器revealViewController添加进这个AppleDelegate成为window的根控制器
    self.window.rootViewController = revealViewController;
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
