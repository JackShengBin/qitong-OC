//
//  CollectionTableViewCell.m
//  企同创意-OC
//
//  Created by 梦想 on 16/9/16.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import "CollectionTableViewCell.h"

@interface CollectionTableViewCell ()
@property (nonatomic, weak) UIImageView *picView;
@property (nonatomic, weak) UILabel *timeLabel;

@end

static NSString *cellId = @"cellId";
@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (CollectionTableViewCell *)collectionTableViewCellWithTableView:(UITableView *)tableView{
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CollectionTableViewCell alloc] initWithStyle:0 reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *picView = [[UIImageView alloc] init];
        [self addSubview:picView];
        picView.sd_layout.topSpaceToView(self, MARGIN).leftSpaceToView(self, 100).bottomSpaceToView(self, MARGIN).widthIs(100);
        self.picView = picView;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        self.timeLabel = timeLabel;
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLabel];
        timeLabel.sd_layout.topSpaceToView(self, 20).widthIs(200).heightIs(30).rightSpaceToView(self, 30);
    }
    return self;
}

- (void)setModel:(CollectionModel *)model{
    _model = model;
    
    self.picView.image = [UIImage imageNamed:model.picName];
    self.timeLabel.text = model.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
