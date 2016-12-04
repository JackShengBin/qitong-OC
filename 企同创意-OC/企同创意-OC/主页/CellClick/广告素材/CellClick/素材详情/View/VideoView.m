//
//  VideoView.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/7.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "VideoView.h"

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (Class)layerClass{
    return [AVPlayerLayer class];
}
/**
 *  重写player的set get方法
 */
- (AVPlayer *)player{
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end
