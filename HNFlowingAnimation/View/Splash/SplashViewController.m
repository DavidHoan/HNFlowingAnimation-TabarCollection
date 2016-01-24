//
//  SplashViewController.m
//  HNFlowingAnimation
//
//  Created by Nguyen Duc Hoang on 1/21/16.
//  Copyright © 2016 IOSDeveloper. All rights reserved.
//

#import "SplashViewController.h"
#import "PageViewManagerController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(showPageManagerController) withObject:self afterDelay:0.01];
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
- (void)showPageManagerController {
    PageViewManagerController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewManagerController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
