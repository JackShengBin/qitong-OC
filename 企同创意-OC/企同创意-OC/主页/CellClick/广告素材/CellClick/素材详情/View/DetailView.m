//
//  DetailView.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/7.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "DetailView.h"
#import "VideoView.h"
#import <UIView+SDAutoLayout.h>
@interface DetailView (){
    BOOL _played;
}

@property (nonatomic, weak) VideoView *videoView;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, weak) UIButton *btn;

@end

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        VideoView *view = [[VideoView alloc] init];
        self.videoView = view;
        view.backgroundColor = [UIColor cyanColor];
        [self addSubview:view];
        view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
#pragma mark----将视频和view关联
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Video.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        self.videoView.player = [AVPlayer playerWithPlayerItem:self.playerItem];
//        view.player = self.player;
        //设置监听的名字
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        //设置通知中心
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn = btn;
        [view addSubview:btn];
        [btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        btn.center = view.center;
        btn.sd_layout.widthIs(100).heightIs(100).centerXEqualToView(view).centerYEqualToView(view);
        [btn addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/**
 *  播放按钮点击事件
 */
- (void)playVideo:(UIButton *)btn{
    NSLog(@"btnClicked");
    if (!_played) {
        [self.videoView.player play];
        [btn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        btn.hidden = YES;
    } else {
        [self.videoView.player pause];
        [btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    }
    _played = !_played;
}

// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
}
/**
 *  通知回调
 */
- (void)moviePlayDidEnd:(NSNotificationCenter *)center{
    NSLog(@"播放完毕");
    self.btn.hidden = NO;
    [self.btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [_playerItem seekToTime:CMTimeMake(0, 1)];
    _played = !_played;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(self.videoView.frame, point) && _played == YES){
        self.btn.hidden = NO;
        [self.btn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    }
}

- (void)dealloc{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
