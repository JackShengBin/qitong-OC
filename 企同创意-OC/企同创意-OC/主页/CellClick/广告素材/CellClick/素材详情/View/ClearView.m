//
//  ClearView.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/13.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "ClearView.h"
#import "PlayVideoView.h"
#import "StickerView.h"
#import "MusicView.h"

@interface ClearView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIView *bottomView;

@end

@implementation ClearView

- (void)setBtnArr:(NSArray *)array{
    _btnArr = array;
    CGFloat btnW = (SCREENW - 50 * 3 - 20) / array.count;
    CGFloat btnH = btnW + 10;
    
    for (int i = 0; i < array.count; i++) {
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomBtn addTarget:self action:@selector(bottonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        bottomBtn.tag = i;
        [bottomBtn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [self addSubview:bottomBtn];
        bottomBtn.sd_layout.bottomSpaceToView(self, 3).leftSpaceToView(self, 10 + (btnW + 50) * i).widthIs(btnW).heightIs(btnH);
    }
}

- (void)bottonBtnClick:(UIButton *)btn{
    
    if (btn.tag == 0) {
        NSLog(@"播放.暂停");
        return;
    }
    if (btn.tag == 1) {
        NSLog(@"添加图片");
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"是否打开相机" message:@"打开" preferredStyle:UIAlertControllerStyleActionSheet];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertAction *alt = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //相机
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self.viewController presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alter addAction:alt];
            
        }
        //打开相册
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picController = [[UIImagePickerController alloc] init];
            picController.delegate = self;
            picController.allowsEditing = YES;
            //跳转到相册页面
            picController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.viewController presentViewController:picController animated:YES completion:nil];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alter addAction:action];
        [alter addAction:cancel];
        
        [self.viewController presentViewController:alter animated:YES completion:nil];
        return;
    }
    if (btn.tag == 2 || btn.tag == 3) {
        CGFloat viewHeight = (SCREENW - 7 * MARGIN) / 6;
        UIView *bottomView = [[UIView alloc] init];
        self.bottomView = bottomView;
        bottomView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self.superview addSubview:bottomView];
        
        UILabel *lable = [[UILabel alloc] init];
        [bottomView addSubview:lable];
        lable.textColor = [UIColor whiteColor];
        lable.sd_layout.topEqualToView(bottomView).leftEqualToView(bottomView).rightSpaceToView(bottomView, 0).heightIs(15);
        lable.font = [UIFont systemFontOfSize:13];
        lable.textAlignment = NSTextAlignmentCenter;
        switch (btn.tag) {
            case 2:{
                bottomView.frame = CGRectMake(0, SCREENH, SCREENW, viewHeight + 100);
                lable.text = @"贴纸";
                //贴纸
                StickerView *sticker = [[StickerView alloc] init];
                [bottomView addSubview:sticker];
                sticker.sd_layout.leftEqualToView(bottomView).bottomEqualToView(bottomView).rightEqualToView(bottomView).heightIs((SCREENW - MARGIN * 7) / 6.0 + 10);
                //播放
                PlayVideoView *playView = [[PlayVideoView alloc] init];
                [bottomView addSubview:playView];
                playView.sd_layout.topEqualToView(lable).leftEqualToView(bottomView).bottomSpaceToView(sticker, 0).rightEqualToView(bottomView);
            }
                break;
            default:{
                lable.text = @"音乐";
                bottomView.frame = CGRectMake(0, SCREENH, SCREENW, viewHeight + 40);
                MusicView *music = [[MusicView alloc] init];
                [bottomView addSubview:music];
                music.sd_layout.leftEqualToView(bottomView).bottomEqualToView(bottomView).rightEqualToView(bottomView).heightIs((SCREENW - MARGIN * 7) / 6.0 + 10);
            }
                break;
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.0;
            bottomView.bottom = self.bottom;
        }];
        /**
         * 角标关闭按钮
         */
        UIButton *closeBtn = [[UIButton alloc] init];
        [closeBtn addTarget:self action:@selector(closeBottomView) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        [bottomView addSubview:closeBtn];
        closeBtn.sd_layout.widthIs(15).heightEqualToWidth().rightSpaceToView(bottomView, MARGIN).topSpaceToView(bottomView, MARGIN);
    }
}

//选中图片以后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}

- (void)closeBottomView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self.bottomView.sd_y = SCREENH;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
