//
//  GGNavigationController.m
//  FastScreenshot
//
//  Created by GQuEen on 17/3/30.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "GGNavigationController.h"

@interface GGNavigationController ()

@end

@implementation GGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [[UIButton alloc]init];
        [backBtn setImage:[UIImage imageNamed:@"tab_back.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"tab_pre_back.png"] forState:UIControlStateHighlighted];
        backBtn.frame = CGRectMake(0, 0, 70, 30);
        [backBtn setTitleColor:MAIN_FONT_COLOR forState:UIControlStateNormal];
        backBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backBtn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    [super pushViewController:viewController animated:animated];
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
