//
//  MakeVideoController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/7.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "MakeVideoController.h"
#import "AdsImageView.h"
@interface MakeVideoController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/**
 *  存储图片的数组
 */
@property (nonatomic, strong) NSMutableArray *imageArr;
/**
 *  存储按钮的数组
 */
@property (nonatomic, strong) NSMutableArray *btnArr;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) AdsImageView *adsView;

@property (nonatomic, weak) UIImage *image;

@end

@implementation MakeVideoController

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.title = @"素材编辑";

    UIButton *importBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [importBtn setImage:[UIImage imageNamed:@"daorutupian"] forState:UIControlStateNormal];
    [importBtn addTarget:self action:@selector(importImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:importBtn];
    importBtn.sd_layout.heightIs(53).leftEqualToView(self.view).bottomEqualToView(self.view).widthIs(self.view.width);
    
    AdsImageView *adsView = [[AdsImageView alloc] init];
    [self.view addSubview:adsView];
    adsView.sd_layout.topSpaceToView(self.view, 64).leftEqualToView(self.view).heightIs(300).rightEqualToView(self.view);
    self.adsView = adsView;
}

//导入图片
- (void)importImage:(UIButton *)btn{

    UIImagePickerController *picController = [[UIImagePickerController alloc] init];
    picController.delegate = self;
    picController.allowsEditing = YES;
    //跳转到相册页面
    picController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picController animated:YES completion:nil];
    
}

//选中图片以后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageArr addObject:image];
    [self.btnArr removeAllObjects];
    CGFloat btnW = (SCREENW - 30 * 5) / 4;
    for (int i = 0; i <= self.imageArr.count / 4; i++) {
        for (int j = 0; j < self.imageArr.count % 4; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.btnArr addObject:btn];
            [btn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:self.imageArr[i * 4 + j] forState:UIControlStateNormal];
            [self.view addSubview:btn];
            btn.sd_layout.topSpaceToView(self.adsView, 30 + btnW * i).leftSpaceToView(self.view, 30 + (btnW + 30) * j).widthIs(btnW).heightEqualToWidth(btnW);
            [btn updateLayout];
        }
    }
    
}

/**
 *  选择小图显示大图
 */
- (void)selectImage:(UIButton *)btn{
    
    for (UIButton *btn in self.btnArr) {
        btn.layer.borderColor = [UIColor clearColor].CGColor;
    }
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0;
    
    int i = 0;
    for (UIButton *selectBtn in self.btnArr) {
        if (selectBtn == btn) {
            
            self.adsView.image = self.imageArr[i];
        }
        i++;
    }
    NSLog(@"%s", __func__);
}

- (void)dealloc{
    NSLog(@"dealloc   %s", __func__);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"scrollView    %@\nimageView   %@", self.scrollView, NSStringFromCGRect(self.imageView.frame));
}

@end
