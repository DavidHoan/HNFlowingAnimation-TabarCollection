# HNFlowingAnimation
This library is used to show liquid's effect while transmitting pageViewController. Compatible with iOS 7,8,9
HNFlowingAnimation
A UIViewController Category to display a ViewController as a popup with different transition effects.
Written by Nguyen Duc Hoang, January 2016.

##Installation

Open in Xcode7.2 Objective C project. Also you need to add the QuartzCore-Framework to your project.

##Usage

First you have to import the Library:
\#import "HNFlowing.h"
And delegation:
@interface YourViewController<HNFlowingDelegate> {
...
}
In viewDidLoad:
self.hnFlowing = self.hnFlowing?self.hnFlowing:[[HNFlowing alloc] init];
self.hnFlowing.delegate = self;
[self.hnFlowing setPanGesture:self.view];

Set your viewcontrollers:
self.hnFlowing.currentVC = self;
self.hnFlowing.previousTabVC = nil;
self.hnFlowing.currentTabVC = viewController1;
self.hnFlowing.nextTabVC = self.childViewControllers[1];
Your ViewController Color:
self.tabColors =[NSMutableArray new];
for (UIViewController *vc in self.childViewControllers) {     [self.tabColors addObject:vc.view.backgroundColor];
}
self.hnFlowing.nextTabColor = self.tabColors[1];
self.hnFlowing.previousTabColor = nil;
self.hnFlowing.bottomView = self.bottomView;
self.numberOfTabs = self.childViewControllers.count;

Delegate in views' transition
\#pragma mark - HNFlowingDelegate
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

##Demo

You can open the HNFlowingAnimationDemo demo project in Xcode and run it on your iPhone as well as in the Simulator.
<br></br>
<img src="https://raw.github.com/sunlight3d/HNFlowingAnimation/master/assets/pic01.png" width="283" height="500"/>
<img src="https://raw.github.com/sunlight3d/HNFlowingAnimation/master/assets/pic02.png" width="283" height="500"/>
<img src="https://raw.github.com/sunlight3d/HNFlowingAnimation/master/assets/pic03.png" width="283" height="500"/>
<img src="https://raw.github.com/sunlight3d/HNFlowingAnimation/master/assets/pic04.png" width="283" height="500"/>
<img src="https://raw.github.com/sunlight3d/HNFlowingAnimation/master/assets/pic05.png" width="283" height="500"/>
##Collaboration

Feel free to collaborate with ideas, issues and/or pull requests.
Anything relating to this project and hiring me for outsourcing work, please contact me:
Nguyen Duc Hoang. Skype: sunlight3d@icloud.com

##License

HNFlowingAnimation is available under the Apache 2.0 license. See the LICENSE file for more info.
