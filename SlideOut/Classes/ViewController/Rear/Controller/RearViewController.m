//
//  RearViewController.m
//  SlideOut
//
//  Created by HEYANG on 15/12/14.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "RearViewController.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "CanvasViewController.h"
#import "RightViewController.h"

@interface RearViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 辅助变量 表示是否是刚刚显示过的控制器 */
@property (nonatomic,assign)NSInteger isSameViewController;
@end

@implementation RearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Rear View", nil);
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]
                               initWithStyle:UITableViewCellStyleValue1
                             reuseIdentifier:nil];
    NSString* textStr = nil;
    if (indexPath.row == 0) {
        textStr = @"Front View";
    }else if (indexPath.row == 1){
        textStr = @"Canvas View";
    }
    cell.textLabel.text = textStr;
    return cell;
}
//1、实现点击cell触发跳转页面
#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //2、获取ReavelViewController对象
    SWRevealViewController* revealViewController = self.revealViewController;
    
    //5、优化，和cell的循环利用同样的思想
    // selecting row
    NSInteger curRow = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    if (curRow == self.isSameViewController) {
        [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    
    
    
    //3、如果要跳转其他页面就要重新创建其页面
    UIViewController *newFrontVC = nil;
    if (curRow == 0) {
        newFrontVC = [FrontViewController new];
        revealViewController.rightViewController = [RightViewController new];
    }else if (curRow == 1){
        newFrontVC = [CanvasViewController new];
        revealViewController.rightViewController = nil;
    }
    //4、创建
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:newFrontVC];
    [revealViewController pushFrontViewController:navigationController animated:YES];
    
    self.isSameViewController = curRow;
}
@end
