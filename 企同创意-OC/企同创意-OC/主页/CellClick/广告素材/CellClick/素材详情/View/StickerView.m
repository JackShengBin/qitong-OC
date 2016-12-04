//
//  StickerView.m
//  ViewDemo
//
//  Created by 梦想 on 16/9/14.
//  Copyright © 2016年 lin_tong. All rights reserved.
//

#import "StickerView.h"

@interface StickerView ()

//推荐下图片名称
@property (nonatomic, strong) NSMutableArray *recmdNameArr;
/**
 *  通用下图片名称
 */
@property (nonatomic, strong) NSMutableArray *usualArr;
/**
 *  存储按钮的数组
 */
@property (nonatomic, strong) NSMutableArray *btnsArray;
/**
 *  推荐按钮
 */
@property (nonatomic, weak) UIButton *recommendBtn;
/**
 *  常用按钮
 */
@property (nonatomic, weak) UIButton *usualBtn;

@end

@implementation StickerView

//推荐下图片名称
- (NSMutableArray *)recmdNameArr{
    if (!_recmdNameArr) {
        _recmdNameArr = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            NSString *imageName = [NSString stringWithFormat:@"tiezhi-%d",i];
            [_recmdNameArr addObject:imageName];
        }
    }
    return _recmdNameArr;
}

- (NSMutableArray *)usualArr{
    if (!_usualArr) {
        _usualArr = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            NSString *imageName = [NSString stringWithFormat:@"changyongsucai-%d",i];
            [_usualArr addObject:imageName];
        }
    }
    return _usualArr;
}

- (NSMutableArray *)btnsArray{
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createView];
        self.alpha = 1.0;
        UIButton *recommendBtn = [[UIButton alloc] init];
        self.recommendBtn = recommendBtn;
        [recommendBtn setImage:[UIImage imageNamed:@"tuijian-0"] forState:UIControlStateNormal];
        [recommendBtn setImage:[UIImage imageNamed:@"tuijian-1"] forState:UIControlStateSelected];
        [recommendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        recommendBtn.tag = 0;
        [self addSubview:recommendBtn];
        recommendBtn.sd_layout.leftSpaceToView(self, MARGIN).widthIs(60).bottomEqualToView(self).heightIs(15);
        
        UIButton *usualBtn = [[UIButton alloc] init];
        self.usualBtn = usualBtn;
        usualBtn.tag = 1;
        [usualBtn setImage:[UIImage imageNamed:@"changyong-1"] forState:UIControlStateNormal];
        [usualBtn setImage:[UIImage imageNamed:@"changyong-0"] forState:UIControlStateSelected];
        [usualBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:usualBtn];
        usualBtn.sd_layout.leftSpaceToView(recommendBtn, MARGIN).widthIs(60).bottomEqualToView(self).heightIs(15);
    }
    return self;
}

- (void)createView {
    
    CGFloat btnW = (SCREENW - MARGIN * 7) / 6.0;
    CGFloat btnH = btnW;
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:self.recmdNameArr[i]] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.sd_layout.leftSpaceToView(self, MARGIN + (btnW + MARGIN) * i).bottomSpaceToView(self, 15).widthIs(btnW).heightIs(btnH);
        [self.btnsArray addObject:btn];
    }
    
}
//更换底部颜色
- (void)btnClick:(UIButton *)btn{
    int i = 0;
    NSArray *array;
    if (btn.tag == 1) {
        self.usualBtn.selected = YES;
        self.recommendBtn.selected = YES;
        array = self.usualArr;
    }else{
        self.usualBtn.selected = NO;
        self.recommendBtn.selected = NO;
        array = self.recmdNameArr;
    }
    for (UIButton *btn in self.btnsArray) {
        [btn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        i++;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
