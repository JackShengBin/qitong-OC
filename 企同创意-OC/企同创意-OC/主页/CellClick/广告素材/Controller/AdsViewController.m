//
//  AdsViewController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/4.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "AdsViewController.h"
#import "VideoViewController.h"
#import "AdsModel.h"

@interface AdsViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) UIView *redView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UICollectionView *collection;

@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *listArray;

/**
 *  点击cell
 */
@property (nonatomic, assign) NSIndexPath *indexPath;

@end

static NSString *cellId = @"cellId";
@implementation AdsViewController

/**
 *  tableView的数据源
 */
- (NSArray *)listArray{
    if (!_listArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
        _listArray = [AdsModel mj_objectArrayWithKeyValuesArray:[[[NSArray arrayWithContentsOfFile:path] objectAtIndex:self.row] objectForKeyedSubscript:@"sub"]];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    _searchBar = searchBar;
//    searchBar.showsSearchResultsButton = YES;
    searchBar.barTintColor = [UIColor colorWithRed:0.90f green:0.11f blue:0.21f alpha:1.00f];
    searchBar.backgroundColor = [UIColor colorWithRed:0.90f green:0.11f blue:0.21f alpha:1.00f];
    [self.view addSubview:searchBar];
    searchBar.sd_layout.topSpaceToView(self.view, 66).leftEqualToView(self.view).heightIs(50).rightSpaceToView(self.view,70);
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor = searchBar.backgroundColor;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    searchBtn.sd_layout.topSpaceToView(self.view, 66).leftSpaceToView(searchBar, 0).heightRatioToView(searchBar, 1.0).rightSpaceToView(self.view, 0);
    
    UITableView *tableView = [[UITableView alloc] init];
    _tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.sd_layout.topSpaceToView(searchBar, 0).leftEqualToView(searchBar).heightIs(SCREENH - CGRectGetMaxY(searchBar.frame)).widthIs(100);
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.separatorStyle = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = MARGIN;
    layout.minimumInteritemSpacing = MARGIN;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collection = collection;
    collection.backgroundColor = [UIColor grayColor];
    collection.dataSource = self;
    collection.delegate = self;
    [self.view addSubview:collection];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    collection.sd_layout.topSpaceToView(searchBar, 0).leftSpaceToView(tableView, 0).bottomEqualToView(self.view).rightEqualToView(self.view);
    
}

#pragma mark----collectionView数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    AdsModel *mode = self.listArray[self.indexPath.row];
    return mode.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = MARGIN;
    
    AdsModel *mode = self.listArray[self.indexPath.row];
    NSString *imageNamed = [NSString stringWithFormat:@"%@-%ld", mode.image, indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    cell.backgroundView = imageView;
    
    return cell;
}

#pragma mark----collection代理方法
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(MARGIN, MARGIN, MARGIN, MARGIN);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (collectionView.width - MARGIN * 4) / 3;
    CGFloat height = width + 30;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    [self.navigationController pushViewController:videoVC animated:YES];
}

#pragma mark----tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    AdsModel *model = self.listArray[indexPath.row];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        UIView *redView = [[UIView alloc] init];
        [view addSubview:redView];
        redView.backgroundColor = [UIColor colorWithRed:0.90f green:0.11f blue:0.21f alpha:1.00f];
        redView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 95));
        
        UIView *garyView = [[UIView alloc] init];
        [cell addSubview:garyView];
        garyView.backgroundColor = [UIColor grayColor];
        garyView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        garyView.sd_layout.heightIs(2);
        cell.selectedBackgroundView = view;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor redColor];
    _indexPath = indexPath;
    [self.collection reloadData];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor grayColor];
}

- (void)search{
    NSLog(@"搜索中...");
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor redColor];
}

- (void)dealloc{
    NSLog(@"广告  %s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
