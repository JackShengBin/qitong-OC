//
//  PlayVideoView.m
//  ViewDemo
//
//  Created by 梦想 on 16/9/14.
//  Copyright © 2016年 lin_tong. All rights reserved.
//

#import "PlayVideoView.h"

@interface PlayVideoView (){
    BOOL _played;
}

@end

@implementation PlayVideoView

- (instancetype)init{
    if (self = [super init]) {
        self.alpha = 1.0;
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [playBtn addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        [playBtn setImage:[UIImage imageNamed:@"zhanting"] forState:UIControlStateNormal];
        [self addSubview:playBtn];
        playBtn.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 20).widthIs(50).heightIs(60);
        
        UIScrollView *videoSlider = [[UIScrollView alloc] init];
        videoSlider.showsHorizontalScrollIndicator = NO;
        videoSlider.contentSize = CGSizeMake(500, 0);
        [self addSubview:videoSlider];
        videoSlider.sd_layout.topEqualToView(playBtn).leftSpaceToView(playBtn, 20).bottomEqualToView(playBtn).rightSpaceToView(self, 20);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [videoSlider addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"zhenguisucai"];
        imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        UIImageView *fps = [[UIImageView alloc] init];
        [self addSubview:fps];
        fps.image = [UIImage imageNamed:@"zhenguibiao"];
        fps.sd_layout.centerXEqualToView(videoSlider).centerYEqualToView(videoSlider).heightRatioToView(videoSlider, 1.1).widthIs(3);
    }
    return self;
}

/**
 *  播放按钮点击事件
 */
- (void)playVideo:(UIButton *)btn{
    NSDictionary *dict;
    if (!_played) {
        dict = @{@"videoState" : @"play"};
        /**
         *  发送播放视频通知
         */
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    } else {
        dict = @{@"videoState" : @"pause"};
        [btn setImage:[UIImage imageNamed:@"zhanting"] forState:UIControlStateNormal];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playVideo" object:self userInfo:dict];
    _played = !_played;
}

// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
