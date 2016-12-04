//
//  AdsImageView.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/9.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "AdsImageView.h"

@interface AdsImageView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation AdsImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        self.scrollView = scrollView;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor blueColor];
        [self addSubview:scrollView];
        scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(30, 0, 30, 0));
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liulan"]];
        [scrollView addSubview:imageView];
        imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        self.imageView = imageView;
        
    }
    return self;
}


- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
    self.scrollView.contentSize = CGSizeMake(500, 500);
    self.scrollView.bounces = NO;
    [self.scrollView setZoomScale:2];
    NSLog(@"%@", NSStringFromCGSize(_scrollView.contentSize));
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
