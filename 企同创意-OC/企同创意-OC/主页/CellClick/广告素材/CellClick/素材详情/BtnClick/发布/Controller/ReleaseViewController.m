//
//  ReleaseViewController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/16.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "ReleaseViewController.h"
#import "PlayVideoView.h"
#import "DetailView.h"
#import "ActionSheetView.h"
#import <UMSocial.h>
#import <WXApiObject.h>
#import <Social/Social.h>

@interface ReleaseViewController ()

@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView{
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"发布";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存到相册" style:UIBarButtonItemStyleDone target:self action:@selector(saveToLib)];
    
    DetailView *audioView = [[DetailView alloc] init];
    audioView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:audioView];
    audioView.sd_layout.heightIs(300).leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view);
    
    PlayVideoView *playView = [[PlayVideoView alloc] init];
    playView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:playView];
    playView.sd_layout.topSpaceToView(audioView, 0).leftSpaceToView(self.view, 0).heightIs(100).rightEqualToView(self.view);
    
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"傍晚的法国巴黎....";
    [self.view addSubview:textView];
    textView.sd_layout.topSpaceToView(playView, 0).leftEqualToView(self.view).bottomSpaceToView(self.view, 49).rightEqualToView(self.view);

    UIButton *releaseBtn = [[UIButton alloc] init];
    [self.view addSubview:releaseBtn];
    [releaseBtn addTarget:self action:@selector(releaseVideo) forControlEvents:UIControlEventTouchUpInside];
    [releaseBtn setImage:[UIImage imageNamed:@"fenbu"] forState:UIControlStateNormal];
    releaseBtn.sd_layout.heightIs(49).leftEqualToView(self.view).widthIs((SCREENW - MARGIN) / 2.0).bottomEqualToView(self.view);
    releaseBtn.sd_cornerRadius = @(MARGIN);
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [self.view addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    shareBtn.sd_layout.heightIs(49).leftSpaceToView(releaseBtn, MARGIN).widthIs((SCREENW - MARGIN) / 2.0).bottomEqualToView(self.view);
    shareBtn.sd_cornerRadius = @(MARGIN);
    

}
/**
 *  保存到相册
 */
- (void)saveToLib{
    NSLog(@"保存到相册");
}
/**
 *  发布视频
 */
- (void)releaseVideo{
    NSLog(@"发布到素材");
}
/**
 *  分享视频
 */
- (void)shareClick{
    NSArray *titlearr = @[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间",@"新浪微博",@"复制链接"];
    NSArray *imageArr = @[@"wechat",@"wechatquan",@"tcentQQ",@"tcentkongjian",@"sinaweibo",@"copyUrl"];
    ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"测试" and:ShowTypeIsShareStyle];
    
#warning 分享功能有bug
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%ld\n当前选中的按钮title====%@",btnTag,titlearr[btnTag]);
        switch (btnTag) {
            case 0:{
                NSLog(@"微信分享未实现");
            }
            case 1:
                break;
            case 2:{
                //需要自定义面板样式的开发者需要自己绘制UI，在对应的分享按钮中调用此接口
                [UMSocialData defaultData].extConfig.title = @"来自蜂播的分享";
                [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
                UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                                    @"http://www.baidu.com/img/bdlogo.gif"];
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"你想说点什么..." image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                    if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                        NSLog(@"分享成功！");
                    }
                }];
            }
                break;
            case 3:{
                //需要自定义面板样式的开发者需要自己绘制UI，在对应的分享按钮中调用此接口
                [UMSocialData defaultData].extConfig.title = @"来自蜂播的分享";
                [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
                UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                                    @"http://www.baidu.com/img/bdlogo.gif"];
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"你想说点什么..." image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                    if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                        NSLog(@"分享成功！");
                    }
                }];
            }
                break;
            case 4:{
                //需要自定义面板样式的开发者需要自己绘制UI，在对应的分享按钮中调用此接口
                [UMSocialData defaultData].extConfig.title = @"我设置的Title";
//                [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
                UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeVideo url:
                                                    @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"];
//                UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeMusic url:@"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3"];
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"你想说点什么..." image:[UIImage imageNamed:@"placehoder"] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                    if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                        NSLog(@"分享成功！");
                    }
                }];
            }
                break;
            case 5:
                break;
            default:
                break;
        }
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
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
