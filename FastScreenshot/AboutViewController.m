//
//  AboutViewController.m
//  FastScreenshot
//
//  Created by GQuEen on 17/3/13.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (strong, nonatomic) UIImageView *logoImageView;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于";
    self.navigationItem.rightBarButtonItem = nil;
    [self.view addSubview:self.logoImageView];
    
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStylePlain];
        
        
        return _tableView;
    }
    return _tableView;
}

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, 100, 100)];
        _logoImageView.backgroundColor = [UIColor blueColor];
        _logoImageView.clipsToBounds = YES;
        _logoImageView.layer.cornerRadius = 3;
        _logoImageView.center = CGPointMake(MAIN_SCREEN_WIDTH/2-self.logoImageView.frame.size.width/2, 45+self.logoImageView.frame.size.height/2);
    }
    return _logoImageView;
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
