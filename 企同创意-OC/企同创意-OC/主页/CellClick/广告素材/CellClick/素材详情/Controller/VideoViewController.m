//
//  VideoViewController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/6.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "VideoViewController.h"
#import "DetailView.h"
#import "MakeVideoController.h"
#import "ClearView.h"
#import "ReleaseViewController.h"

@interface VideoViewController ()

/**
 *  将四个大按钮添加到clearView上
 */
@property (nonatomic, weak) UIView *clearView;

/**
 *  底部的View
 */
@property (nonatomic, weak) UIView *bottomView;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"素材详情";
    [self createNavBarButtonItem];
    
    DetailView *detailView = [[DetailView alloc] init];
    [self.view addSubview:detailView];
    detailView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    NSArray *array = @[@"bofang", @"tianjiatupian", @"tiezhi", @"yinyue"];
    CGFloat btnW = (SCREENW - 50 * 3 - 20) / array.count;
    CGFloat btnH = btnW + 15;
    ClearView *clearView = [[ClearView alloc] init];
    clearView.btnArr = array;
    self.clearView = clearView;
    [self.view addSubview:clearView];
    clearView.sd_layout.heightIs(btnH).widthIs(SCREENW).bottomEqualToView(self.view).leftEqualToView(self.view);
    
}

- (void)createNavBarButtonItem{
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    [completeBtn addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];
    [completeBtn setImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
}
/**
 *  完成跳转页面
 */
- (void)completeClick{
    ReleaseViewController *VC = [[ReleaseViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}
/**
 *  点击返回
 */
- (void)backViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)product{
    [self.navigationController pushViewController:[[MakeVideoController alloc] init] animated:YES];
}

- (void)dealloc{
    NSLog(@"dealloc  %s", __func__);
}

@end
