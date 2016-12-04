//
//  CollectionTableViewCell.h
//  企同创意-OC
//
//  Created by 梦想 on 16/9/16.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"


@interface CollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) CollectionModel *model;

+ (CollectionTableViewCell *)collectionTableViewCellWithTableView:(UITableView *)tableView;

@end
