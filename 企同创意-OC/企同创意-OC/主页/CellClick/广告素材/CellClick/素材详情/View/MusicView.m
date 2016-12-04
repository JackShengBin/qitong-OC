//
//  MusicView.m
//  ViewDemo
//
//  Created by 梦想 on 16/9/14.
//  Copyright © 2016年 lin_tong. All rights reserved.
//

#import "MusicView.h"
#import <AVFoundation/AVFoundation.h>

@implementation MusicView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createMusicBottomBtn];
    }
    return self;
}

/**
 *  点击音乐按钮显示内容
 */
- (void)createMusicBottomBtn{
    NSArray *musicPic = @[@"bendi", @"xiandai", @"yaogun", @"gudian", @"dianyin", @"DJ"];
    CGFloat btnW = (SCREENW - (musicPic.count + 1) * MARGIN) / 6;
    CGFloat btnH = btnW + 15;
    for (int i = 0; i < musicPic.count; i++) {
        NSString *imageName = musicPic[i];
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.sd_layout.widthIs(btnW).heightIs(btnH).leftSpaceToView(self, (MARGIN + btnW) * i + MARGIN).bottomSpaceToView(self, MARGIN);
    }
}
/**
 *  查询本地所有音乐
 */
/*
- (void)queryAllMusic
{
        MPMediaQuery *everything = [[MPMediaQuery alloc] init];
        NSLog(@"Logging items from a generic query...");
        NSArray *itemsFromGenericQuery = [everything items];
        NSLog(@"count = %lu", (unsigned long)itemsFromGenericQuery.count);
        for (MPMediaItem *song in itemsFromGenericQuery)
            {
                    NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
                    NSString *songArtist = [song valueForProperty:MPMediaItemPropertyArtist];
                    NSLog (@"Title:%@, Aritist:%@", songTitle, songArtist);
                }
}

 */


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
