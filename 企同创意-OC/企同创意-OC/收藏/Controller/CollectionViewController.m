//
//  CollectionViewController.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/16.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

static NSString *cellId = @"cellId";

@implementation CollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchClick)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        UIImageView *imageView = [[UIImageView alloc] init];
        [cell addSubview:imageView];
        imageView.sd_layout.topSpaceToView(cell, MARGIN).leftSpaceToView(cell, 100).bottomSpaceToView(cell, MARGIN).widthIs(100);
        imageView.image = [UIImage imageNamed:@"bingxiang-4"];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"2018-08-08";
        timeLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:timeLabel];
        timeLabel.sd_layout.topSpaceToView(cell, 20).widthIs(200).heightIs(30).rightSpaceToView(cell, 30);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)searchClick{
    NSLog(@"搜索中...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
