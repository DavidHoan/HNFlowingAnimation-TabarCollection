//
//  PageViewManagerController.m
//  RBXApp
//
//  Created by Chinh Vu on 10/29/14.
//  Copyright (c) 2014 IOSDeveloper. All rights reserved.
//

#import "PageViewManagerController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"

@interface PageViewManagerController()
@property (assign, nonatomic) NSUInteger numberOfTabs;
@end

@implementation PageViewManagerController {
    ViewController1 *viewController1;
    ViewController2 *viewController2;
    ViewController3 *viewController3;
    ViewController4 *viewController4;
    ViewController5 *viewController5;    
    int currentPage; //0,1,2,3,4
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    viewController1 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    viewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    viewController3 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController3"];
    viewController4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController4"];
    viewController5 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController5"];
    
    
    [self addChildViewController: viewController1];
    [self addChildViewController: viewController2];
    [self addChildViewController: viewController3];
    [self addChildViewController: viewController4];
    [self addChildViewController: viewController5];
    
    self.btnIconView1.alpha = 0.0f;
    self.btnIconView2.alpha = 0.5f;
    self.btnIconView3.alpha = 0.5f;
    self.btnIconView4.alpha = 0.5f;
    
    self.lblView1.alpha = 0.0f;
    self.lblView2.alpha = 0.5f;
    self.lblView3.alpha = 0.5f;
    self.lblView4.alpha = 0.5f;
    self.scrollView.userInteractionEnabled = NO;
    [self btnView1:self];
    
    self.hnFlowing = self.hnFlowing?self.hnFlowing:[[HNFlowing alloc] init];
    self.hnFlowing.delegate = self;
//    self.hnFlowing.endViewColor = [UIColor purpleColor];
    [self.hnFlowing setPanGesture:self.view];
    self.hnFlowing.currentVC = self;
    self.hnFlowing.previousTabVC = nil;
    self.hnFlowing.currentTabVC = viewController1;
    self.hnFlowing.nextTabVC = self.childViewControllers[1];
    self.tabColors =[NSMutableArray new];
    for (UIViewController *vc in self.childViewControllers) {
        [self.tabColors addObject:vc.view.backgroundColor];
    }
    self.hnFlowing.nextTabColor = self.tabColors[1];
    self.hnFlowing.previousTabColor = nil;
    self.hnFlowing.bottomView = self.bottomView;
    self.numberOfTabs = self.childViewControllers.count;
    [viewController1.view bringSubviewToFront:viewController1.lblView1];
}

- (void) disableAllButtons:(BOOL)isDisabled {
    if (isDisabled) {
        self.btnView1.userInteractionEnabled = NO;
        self.btnView2.userInteractionEnabled = NO;
        self.btnView3.userInteractionEnabled = NO;
        self.btnView4.userInteractionEnabled = NO;
    } else {
        self.btnView1.userInteractionEnabled = YES;
        self.btnView2.userInteractionEnabled = YES;
        self.btnView3.userInteractionEnabled = YES;
        self.btnView4.userInteractionEnabled = YES;
    }
    
}
- (void)inactiveAllButtons {
    self.btnIconView1.alpha = 0.5f;
    self.btnIconView2.alpha = 0.5f;
    self.btnIconView3.alpha = 0.5f;
    self.btnIconView4.alpha = 0.5f;
    self.btnIconView5.alpha = 0.5f;
    
    self.lblView1.alpha = 0.5f;
    self.lblView2.alpha = 0.5f;
    self.lblView3.alpha = 0.5f;
    self.lblView4.alpha = 0.5f;
    self.lblView5.alpha = 0.5f;
}

- (IBAction)btnView1:(id)sender {
    [self inactiveAllButtons];
    self.btnIconView1.alpha = 1.0f;
    self.lblView1.alpha = 1.0f;
    currentPage = 0;
    [self changePage:0];
}
- (IBAction)btnView2:(id)sender {
    [self inactiveAllButtons];
    self.btnIconView2.alpha = 1.0f;
    self.lblView2.alpha = 1.0f;
    currentPage = 1;
    [self changePage:1];
}
- (IBAction)btnView3:(id)sender {
    [self inactiveAllButtons];
    self.lblView3.alpha = 1.0f;
    self.btnIconView3.alpha = 1.0f;
    currentPage = 2;
    [self changePage:2];
}
- (IBAction)btnView4:(id)sender {
    [self inactiveAllButtons];
    self.btnIconView4.alpha = 1.0f;
    self.lblView4.alpha = 1.0f;
    currentPage = 3;
    [self changePage:3];
}
- (IBAction)btnView5:(id)sender {
    [self inactiveAllButtons];
    self.btnIconView5.alpha = 1.0f;
    self.lblView5.alpha = 1.0f;
    currentPage = 4;
    [self changePage:4];
 }

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)selectTabAtIndex:(NSInteger)tabIndex {
    switch (tabIndex) {
        case 0:
            [self btnView1:self];
            break;
        case 1:
            [self btnView2:self];
            break;
        case 2:
            [self btnView3:self];
            break;
        case 3:
            [self btnView4:self];
            break;
        case 4:
            [self btnView5:self];
            break;
            
        default:
            break;
    }
    
    if (currentPage <= 0) {
        self.hnFlowing.previousTabVC = nil;
        self.hnFlowing.nextTabVC = self.childViewControllers[1];
        
        self.hnFlowing.previousTabColor = nil;
        self.hnFlowing.nextTabColor = self.tabColors[1];
    } else if(currentPage >= self.numberOfTabs-1){
        self.hnFlowing.previousTabVC = self.childViewControllers[self.numberOfTabs - 2];
        self.hnFlowing.nextTabVC = nil;
        
        self.hnFlowing.previousTabColor = self.tabColors[self.numberOfTabs-2];
        self.hnFlowing.nextTabColor = nil;
    } else {
        self.hnFlowing.previousTabVC = self.childViewControllers[currentPage - 1];
        self.hnFlowing.nextTabVC = self.childViewControllers[currentPage + 1];
        
        self.hnFlowing.previousTabColor = self.tabColors[currentPage - 1];
        self.hnFlowing.nextTabColor = self.tabColors[currentPage + 1];
    }
    
    self.hnFlowing.currentVC = self.childViewControllers[currentPage];
}
#pragma mark - HNFlowingDelegate
-(void)flowingEndAnimation:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge {
    
}
-(void)flowingFullScreen:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge {
    if (edge == UIRectEdgeLeft && currentPage <= 0) {
        [self selectTabAtIndex:currentPage];
        return;
    }
    if (edge == UIRectEdgeRight && currentPage >= self.childViewControllers.count-1) {
        [self selectTabAtIndex:currentPage];
        return;
    }
    if (edge == UIRectEdgeLeft) {
        currentPage--;
    } else {
        currentPage++;
        
    }
    [self selectTabAtIndex:currentPage];
    
}
-(void)flowingChangedAnimation:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge position:(CGPoint)position {
    CGRect rectPosition = self.view.frame;
    rectPosition.origin.x += position.x;
    //    [self.tabsView scrollRectToVisible:rectPosition animated:YES];
}

-(void)makeScreenShot:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge {
    
}




@end
