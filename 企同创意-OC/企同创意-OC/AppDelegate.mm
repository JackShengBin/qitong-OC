//
//  AppDelegate.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/2.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <UMSocialQQHandler.h>
#import <UMSocialSinaSSOHandler.h>
#import <XHLaunchAd.h>

//静态广告
#define ImgUrlString1 @"http://d.hiphotos.baidu.com/image/pic/item/14ce36d3d539b60071473204e150352ac75cb7f3.jpg"
//动态广告
#define ImgUrlString2 @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    [self launchAdsView];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside =YES;
//    manager.enableAutoToolbar = NO;
    
    /**
     *  新浪微博AppKey  @"1447688248"
     *  qqAppKey十六进制    @"41E68BDB"
     */
    [UMSocialData setAppKey:@"57ca6a9f67e58ea13c0039f7"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105628123" appKey:@"n9EjgyuD4w6kLRXV" url:@"http://www.umeng.com/social"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1447688248"
                                              secret:@"26d2e020204eaf498f4863f29137138d"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    return YES;
}
//广告引导页
- (void)launchAdsView{
    //显示广告
    [XHLaunchAd showWithAdFrame:self.window.frame setAdImage:^(XHLaunchAd *launchAd) {
        //获取网络图片
        __weak typeof(launchAd)weakLaunchAd = launchAd;
        [self requestImageData:^(NSString *imageUrl, NSInteger duration, NSString *openUrl) {
            [launchAd setImageUrl:imageUrl duration:duration skipType:SkipTypeTimeText options:XHWebImageDefault completed:^(UIImage *image, NSURL *url) {
                //异步加载,完成回调,可以更新frame
                weakLaunchAd.adFrame = CGRectMake(0, 0, SCREENW, SCREENH - 150);
            } click:^{
                NSDictionary *dict = nil;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:dict completionHandler:nil];
            }];
        }];
        
    } showFinish:^{
        self.window.rootViewController = [[RootViewController alloc] init];
    }];
}

//模拟网络加载数据
- (void)requestImageData:(void(^)(NSString *imageUrl, NSInteger duration, NSString *openUrl))imageData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(imageData)
        {
            imageData(ImgUrlString2,3,@"http://www.returnoc.com");
        }
    });
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        NSLog(@"失败  %s",__func__);
    }
    return result;
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
