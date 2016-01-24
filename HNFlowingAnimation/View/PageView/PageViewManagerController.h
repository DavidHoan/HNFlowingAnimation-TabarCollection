//
//  PageViewManagerController.h
//  RBXApp
//
//  Created by Chinh Vu on 10/29/14.
//  Copyright (c) 2014 IOSDeveloper. All rights reserved.
//

@import UIKit;
#import "PagerViewController.h"
#import "HNFlowing.h"

@interface PageViewManagerController : PagerViewController<HNFlowingDelegate> {
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnIconView1;
@property (weak, nonatomic) IBOutlet UIButton *btnIconView2;
@property (weak, nonatomic) IBOutlet UIButton *btnIconView3;
@property (weak, nonatomic) IBOutlet UIButton *btnIconView4;
@property (weak, nonatomic) IBOutlet UIButton *btnIconView5;

@property (weak, nonatomic) IBOutlet UIButton *btnView1;
@property (weak, nonatomic) IBOutlet UIButton *btnView2;
@property (weak, nonatomic) IBOutlet UIButton *btnView3;
@property (weak, nonatomic) IBOutlet UIButton *btnView4;
@property (weak, nonatomic) IBOutlet UIButton *btnView5;


@property (weak, nonatomic) IBOutlet UILabel *lblView1;
@property (weak, nonatomic) IBOutlet UILabel *lblView2;
@property (weak, nonatomic) IBOutlet UILabel *lblView3;
@property (weak, nonatomic) IBOutlet UILabel *lblView4;
@property (weak, nonatomic) IBOutlet UILabel *lblView5;
@property (strong, nonatomic) HNFlowing *hnFlowing;
@property (strong, nonatomic) NSMutableArray *tabColors;
@property(strong, nonatomic) IBOutlet UIView *bottomView;

- (void) disableAllButtons:(BOOL)isDisabled;
- (IBAction)btnView1:(id)sender;
- (IBAction)btnView2:(id)sender;
- (IBAction)btnView3:(id)sender;
- (IBAction)btnView4:(id)sender;
- (IBAction)btnView5:(id)sender;

@end
