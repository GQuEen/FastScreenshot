//
//  AboutViewController.m
//  FastScreenshot
//
//  Created by GQuEen on 17/3/13.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutVCCell.h"

#define BACK_COLOR ([UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1])


@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property (strong, nonatomic) UIImageView *logoImageView;

@property (strong, nonatomic) UIView *headBackView;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"关于";
    self.navigationItem.rightBarButtonItem = nil;
    [self.view addSubview:self.headBackView];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 190, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-190-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACK_COLOR;
        _tableView.sectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        return _tableView;
    }
    return _tableView;
}

//- (UIImageView *)logoImageView {
//    
//    if (!_logoImageView) {
//        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, 100, 100)];
//        _logoImageView.backgroundColor = [UIColor blueColor];
//        _logoImageView.clipsToBounds = YES;
//        _logoImageView.layer.cornerRadius = 10;
//        _logoImageView.center = CGPointMake(MAIN_SCREEN_WIDTH/2, 45+self.logoImageView.frame.size.height/2);
//    }
//    return _logoImageView;
//}

- (UIView *)headBackView {
    if (!_headBackView) {
        //创建背景view
        _headBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 190)];
        _headBackView.backgroundColor = BACK_COLOR;
        
        //创建logoView
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, 100, 100)];
        logoImageView.backgroundColor = IMAGE_COLOR;
        logoImageView.layer.cornerRadius = 10;
        logoImageView.center = CGPointMake(MAIN_SCREEN_WIDTH/2, 45 + logoImageView.frame.size.height/2);
        
        logoImageView.layer.shadowColor = IMAGE_COLOR.CGColor;
        logoImageView.layer.shadowOffset = CGSizeMake(0, 0);
        logoImageView.layer.shadowOpacity = 0.8;
        logoImageView.layer.shadowRadius = 2;
        
        //创建版本号label
        UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        versionLabel.text = @"快截图 v1.0";
        versionLabel.font = [UIFont systemFontOfSize:13];
        versionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [versionLabel sizeToFit];
        versionLabel.center = CGPointMake(CGRectGetMidX(logoImageView.frame), CGRectGetMaxY(logoImageView.frame)+versionLabel.frame.size.height/2+10);
        
        [_headBackView addSubview:versionLabel];
        [_headBackView addSubview:logoImageView];
        return _headBackView;
    }
    return _headBackView;
}

//改变headerView的背景颜色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = BACK_COLOR;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSLog(@"返回第一节的行数");
        return 3;
    }else if (section == 1){
        NSLog(@"返回第二节的行数");
        return 2;
    }else {
        return 0;
    }
}

//设置第一section的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 40)];
        headView.backgroundColor = BACK_COLOR;
        
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        headLabel.text = @"开发人员信息";
        headLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        headLabel.font = [UIFont boldSystemFontOfSize:13];
        [headLabel sizeToFit];
        headLabel.center = CGPointMake(15+CGRectGetMidX(headLabel.frame), headView.frame.size.height/2);
        [headView addSubview:headLabel];
        return headView;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }else if (section == 1){
        return 30;
    }else {
        return 0.000001;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"第一节");
        AboutVCCell *cell = [AboutVCCell cellWithTableView:tableView withCellType:0];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"产品";
            cell.detailLabel.text = @"@Vinni-Wong";
        }else if (indexPath.row == 1) {
            cell.titleLabel.text = @"开发";
            cell.detailLabel.text = @"@JIYEON2__GG";
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"设计";
            cell.detailLabel.text = @"@随你们去";
        }
        [cell.titleLabel sizeToFit];
        [cell.detailLabel sizeToFit];
        
        cell.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
        return cell;
    }else if (indexPath.section == 1){
        NSLog(@"第二节");
        AboutVCCell *cell = [AboutVCCell cellWithTableView:tableView withCellType:1];
        if (indexPath.row == 0) {
            cell.contentLabel.text = @"建议反馈";
        }else if (indexPath.row == 1) {
            cell.contentLabel.text = @"给快截图评分";
        }
        [cell.contentLabel sizeToFit];
        return cell;
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
