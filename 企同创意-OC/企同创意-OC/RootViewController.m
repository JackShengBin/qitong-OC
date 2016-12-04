//
//  RootViewController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/2.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "CollectionViewController.h"
#import "MineViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    MyNavgetionController *homeNav = [[MyNavgetionController alloc] initWithRootViewController:home];
    
    home.tabBarItem.image = [[UIImage imageNamed:@"shouye-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    home.tabBarItem.selectedImage = [[UIImage imageNamed:@"shouye-0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    home.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    home.navigationItem.title = @"首页";
    
    CollectionViewController *collection = [[CollectionViewController alloc] init];
    MyNavgetionController *collectionNav = [[MyNavgetionController alloc] initWithRootViewController:collection];
    collection.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"shoucang-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"shoucang-0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    collection.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    collection.navigationItem.title = @"收藏";
    
    MineViewController *mine = [[MineViewController alloc] init];
    MyNavgetionController *mineNav = [[MyNavgetionController alloc] initWithRootViewController:mine];
    mine.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"gerenzhongxin-0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"gerenzhongxin-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mine.navigationItem.title = @"个人中心";
    mine.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    self.viewControllers = @[homeNav, collectionNav, mineNav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
