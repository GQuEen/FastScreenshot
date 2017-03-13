//
//  AboutVCCell.m
//  FastScreenshot
//
//  Created by GQuEen on 17/3/13.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "AboutVCCell.h"

@implementation AboutVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView withCellType:(NSInteger)type{
    static NSString *identify = @"AboutVCCell";
    static NSString *identify1 = @"AboutVCCell1";
    if (type == 0) {
        AboutVCCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell = [[AboutVCCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            [cell setupCellContent];
        }
        return cell;
    }else {
        AboutVCCell *cell = [tableView dequeueReusableCellWithIdentifier:identify1];
        if (cell == nil)
        {
            cell = [[AboutVCCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify1];
            [cell setupCell1Content];
        }
        return cell;
    }
}

- (void)setupCellContent {
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 13.5, 0, 0)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 13.5, 0, 0)];
    _detailLabel.font = [UIFont systemFontOfSize:15];
    _detailLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
}
- (void)setupCell1Content {
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 13.5, 0, 0)];
    _contentLabel.font = [UIFont boldSystemFontOfSize:15];
    _contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    [self.contentView addSubview:self.contentLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
