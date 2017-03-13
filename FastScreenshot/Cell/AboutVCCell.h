//
//  AboutVCCell.h
//  FastScreenshot
//
//  Created by GQuEen on 17/3/13.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutVCCell : UITableViewCell
//cell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
//cell1
@property (strong, nonatomic) UILabel *contentLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView withCellType:(NSInteger)type;

@end
