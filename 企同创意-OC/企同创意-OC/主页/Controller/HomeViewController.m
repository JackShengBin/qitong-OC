//
//  HomeViewController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/2.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "HomeViewController.h"
#import "AdsViewController.h"
#import "VideoViewController.h"
#import <sys/utsname.h>

@interface HomeViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SDCycleScrollViewDelegate>
/**
 *  广告轮播
 */
@property (nonatomic, strong) SDCycleScrollView *adsView;
@property (nonatomic, strong) UILabel *adsLabel;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, weak) UICollectionView *collection;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *adsList;
@property (nonatomic, weak) UICollectionViewCell *cell;

@end

static NSString *adsCellId = @"adsCellId";
static NSString *scCellId = @"scCellId";
static NSString *headerId = @"headerId";

@implementation HomeViewController

/**
 *  此处高能
 */
- (SDCycleScrollView *)adsView{
    if (!_adsView) {
        _adsView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placehoder"]];
    }
    return _adsView;
}
- (UILabel *)adsLabel{
    if (!_adsLabel) {
        _adsLabel = [[UILabel alloc] init];
        _adsLabel.text = @"广告素材库";
        _adsLabel.textColor = [UIColor grayColor];
        _adsLabel.backgroundColor = [UIColor whiteColor];
        _adsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _adsLabel;
}
- (UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.backgroundColor = [UIColor whiteColor];
        _showLabel.text = @"案例展示";
        _showLabel.textColor = [UIColor grayColor];
        _showLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _showLabel;
}
- (NSArray *)adsList{
    if (!_adsList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
        _adsList = [NSArray arrayWithContentsOfFile:path];
    }
    return _adsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"帮助" style:UIBarButtonItemStylePlain target:self action:@selector(helpClick)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout = layout;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collection.backgroundColor = [UIColor grayColor];
    collection.dataSource = self;
    collection.delegate = self;
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:adsCellId];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:scCellId];
    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.view addSubview:collection];
    _collection = collection;
}

#pragma mark----collection datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else {
        return 9;
    }
}
#pragma mark----cell页面
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:adsCellId forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UICollectionViewCell alloc] init];
        }
        NSInteger index = indexPath.row - 1;
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:index inSection:indexPath.section];
    
        UICollectionViewCell *lastCell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexP];
        NSString *imageNamed = [NSString stringWithFormat:@"ads-%ld", indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        imageView.frame = cell.bounds;
        [cell addSubview:imageView];
        if (indexPath.row > 0) {
            CGRect frame = cell.frame;
            if (indexPath.row == 5) {
                return cell;
            }
            frame.origin.x = CGRectGetMaxX(lastCell.frame);
            cell.frame = frame;
        }else if (indexPath.row == 10){
            CGRect frame = cell.bounds;
            frame.size.width = SCREENW - CGRectGetMaxX(lastCell.frame);
            cell.bounds = frame;
        }
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:scCellId forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UICollectionViewCell alloc] init];
        }
        NSString *imageNamed = [NSString stringWithFormat:@"anli-%ld", indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3;
        imageView.frame = cell.bounds;
        [cell addSubview:imageView];
    }
    return cell;
}
#pragma mark----cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width;
    CGFloat height;
    if (indexPath.section == 0) {
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, MARGIN, 0);
        width = SCREENW / 5;
        height = width;
    }else{
        _layout.minimumLineSpacing = 4;
        _layout.minimumInteritemSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        width = (self.view.width - MARGIN * 4) / 3;
        height = width + 10;
    }
    return CGSizeMake(width, height);
}
#pragma mark----header的视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        NSLog(@"%@", [self iphoneType]);
        
//        if ([[self iphoneType] containsString:@"Plus"]){
//            return CGSizeMake(SCREENW, 185);
//        }
        return CGSizeMake(SCREENW, 185);
    }else{
        return CGSizeMake(SCREENW, 25);
    }
    
}
#pragma mark----headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [view addSubview:self.adsView];
        self.adsView.sd_layout.topSpaceToView(self.navigationController.navigationBar, -64);
        self.adsView.sd_layout.leftEqualToView(self.view);
        self.adsView.sd_layout.heightIs(view.height - 32);
        self.adsView.sd_layout.rightEqualToView(self.view);
        _adsView.imageURLStringsGroup = @[@"http://pic.qiantucdn.com/images/slideshow/57abdee6552ba.jpg",
                                         @"http://pic.qiantucdn.com/images/slideshow/57c3e659c576c.jpg",
                                         @"http://pic.qiantucdn.com/images/slideshow/57b511b50f54e.jpg",
                                         @"http://pic.qiantucdn.com/images/slideshow/57c63a8c69c0e.jpg"];
        [view addSubview:self.adsLabel];
        self.adsLabel.sd_layout.topSpaceToView(self.adsView, MARGIN);
        self.adsLabel.sd_layout.leftEqualToView(self.view);
        self.adsLabel.sd_layout.heightIs(25);
        self.adsLabel.sd_layout.rightEqualToView(self.view);
        
    }else{
        [view addSubview:self.showLabel];
        self.showLabel.sd_layout.topSpaceToView(_collection.mj_header, 0.0);
        self.showLabel.sd_layout.leftEqualToView(self.view);
        self.showLabel.sd_layout.heightIs(25);
        self.showLabel.sd_layout.rightEqualToView(self.view);
    }
    
    return view;
}
#pragma mark----cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"第%ld组%ld个cell被点击", indexPath.section, indexPath.row);
        AdsViewController *adsVC = [[AdsViewController alloc] init];
        adsVC.row = indexPath.row;
        NSDictionary *dict = self.adsList[indexPath.row];
        NSString *title = [NSString stringWithFormat:@"%@广告素材", [dict objectForKey:@"title"]];
        adsVC.title = title;
        [self.navigationController pushViewController:adsVC animated:YES];
    }else{
        VideoViewController *video = [[VideoViewController alloc] init];
        [self.navigationController pushViewController:video animated:YES];
    }
}
/**
 *  点击广告图片回调
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"图片点击   %ld", index);
}
#pragma mark----点击事件
- (void)loginClick{
    NSLog(@"登录");
}
- (void)helpClick{
    NSLog(@"帮助");
    //分享
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"57ca6a9f67e58ea13c0039f7" shareText:@"我的App分享" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToTencent,nil] delegate:nil];
}

- (NSString *)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])   return @"iPhone Simulator";
    
    return platform;
    
}

- (void)dealloc{
    NSLog(@"%s被销毁",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
