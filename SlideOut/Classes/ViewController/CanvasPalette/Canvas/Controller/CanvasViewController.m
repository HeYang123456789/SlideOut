//
//  CanvasViewController.m
//  TouchPainter
//
//  Created by HEYANG on 15/12/11.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "CanvasViewController.h"
#import "PaletteViewController.h"
#import "HYHUD.h"
#import "CancasView.h"

#import "SWRevealViewController.h"

@interface CanvasViewController ()<UIActionSheetDelegate> {
    BOOL _isHud;
    int _isHud_camera;
}

/** PaletteVC */
@property (nonatomic,strong)PaletteViewController *paletteVC;

/* 子控件CancasView的实例对象 */
@property (weak, nonatomic) IBOutlet CancasView *canvasView;
/* 橡皮和画笔需要切换 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *brush_rubber;

@end

@implementation CanvasViewController


#pragma mark - 控制器的生命周期的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.canvasView.model = self.paletteVC.model;
}

#pragma mark - 初始化的方法
-(void)setup{
    //设置导航条title
    self.title = @"Drawing Board";
    //因为需要所以创建这个对象 并利用内部封装好的手势方法
    SWRevealViewController* revealViewController = self.revealViewController;
    [revealViewController panGestureRecognizer];
    [revealViewController tapGestureRecognizer];
    //设置导航条的左边item
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon"] style:UIBarButtonItemStylePlain target:revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    if (!_isHud) {
        HYHUD* hud = [HYHUD shareHudWithTitle:@"直接在这里绘图哦"];
        [self.view addSubview:hud];
        [hud show];
        _isHud = YES;
    }
    
}

#pragma mark - 重写方法
-(PaletteViewController *)paletteVC{
    if (_paletteVC == nil) {
        _paletteVC = [PaletteViewController new];
        _paletteVC.model = self.canvasView.model;
    }
    return _paletteVC;
}
#pragma mark - 进入设置画笔页面
//进入palette的Modal视图用的BarbuttonItem监听的方法
- (IBAction)paletteClick:(UIBarButtonItem *)sender {
    
    [self presentViewController:self.paletteVC animated:YES completion:nil];
    
    
}
#pragma mark - 撤销，全撤销，重做
- (IBAction)replay:(UIBarButtonItem *)sender {
    [self replayFounction];
    [self.canvasView setNeedsDisplay];
}
-(void)replayFounction{
    if (self.canvasView.array.count>=1) {
        [self.canvasView.replayArray addObject:[self.canvasView.array lastObject]];;
        [self.canvasView.array removeLastObject];
    }
}
- (IBAction)forward:(UIBarButtonItem *)sender {
    [self forwardFounction];
    [self.canvasView setNeedsDisplay];
}
-(void)forwardFounction{
    if (self.canvasView.replayArray.count>=1) {
        [self.canvasView.array addObject:[self.canvasView.replayArray lastObject]];
        [self.canvasView.replayArray removeLastObject];
    }
}
- (IBAction)replayAll:(UIBarButtonItem *)sender {
    NSInteger n = self.canvasView.array.count;
    for (int i = 0; i< n; i++) {
        [self replayFounction];
    }
    [self.canvasView setNeedsDisplay];
}
#pragma mark - 使用橡皮擦
- (IBAction)rubber:(UIBarButtonItem *)sender {
    if (![self.canvasView isRubber]) {
        self.brush_rubber.image = [UIImage imageNamed:@"brush"];
    }else{
        self.brush_rubber.image = [UIImage imageNamed:@"rubber"];
    }
    self.canvasView.rubber = ![self.canvasView isRubber];
}

#pragma mark - 删除当前画板
//这里应该用上苹果提供的内置的绚丽的动画效果
- (IBAction)delete:(UIBarButtonItem *)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"要删除当前绘画板么？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //动画操作，然后删除操作
        [self changeUIView1];
        [self.canvasView clear];
    }
}

/** 转场动画 */
-(void) changeUIView1{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.canvasView cache:YES];
    [self.canvasView exchangeSubviewAtIndex:1 withSubviewAtIndex:0  ];
    [UIView commitAnimations];
}
-(void) changeUIView2{
    NSLog(@"%d",_isHud_camera);
    if (!_isHud_camera) {
        HYHUD* hud = [HYHUD shareHudWithTitle:@"保存在相册里了哦"];
        [self.view addSubview:hud];
        [hud show];
    }
}

#pragma mark - 存储在相册中
- (IBAction)albumn:(UIBarButtonItem *)sender {
    [self changeUIView2];
    //把画板上的内容生成一张图片,保存到系统相册当中.
    UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, NO, 0);
    //把画板的内容渲染到上下文当中.
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.canvasView.layer renderInContext:ctx];
    //从上下文当中生成一张图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    //把生成的图片写入到系统相册
    //注意:保存完毕执行的这方法必须得要是
    //- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    _isHud_camera = 1;
    
    NSLog(@"%s",__func__);
}



@end
