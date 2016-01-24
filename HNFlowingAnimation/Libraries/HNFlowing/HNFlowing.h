/**********************************************************************************************************
//  HNFlowing.h - Library to create Flowing Animation.
//  Created by Nguyen Duc Hoang on 1/3/16. Skype: sunlight3d@icloud.com, Tel: 0084-0964896239
//  Copyright © 2016 Nguyen Duc Hoang. All rights reserved.
***********************************************************************************************************/

#import <Foundation/Foundation.h>
#import "UIView+Snapshot.h"
#import "UIView+GCLibrary.h"
@import UIKit;
@class HNFlowing;
@protocol HNFlowingDelegate <NSObject>
@optional
-(void)flowingEndAnimation:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge;
-(void)flowingFullScreen:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge;
-(void)flowingChangedAnimation:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge position:(CGPoint)position;
-(void)makeScreenShot:(HNFlowing *)hnFlowing edge:(UIRectEdge)edge;
@end

@interface HNFlowing : NSObject

@property(strong, nonatomic) UIColor *endViewColor;

@property(assign, nonatomic) id<HNFlowingDelegate> delegate;
@property(strong, nonatomic) UIView *viewBottom;
@property(strong, nonatomic) UIViewController *currentVC;
@property(strong, nonatomic) UIView *bottomView;

@property(strong, nonatomic) UIViewController *previousTabVC;
@property(strong, nonatomic) UIViewController *currentTabVC;
@property(strong, nonatomic) UIViewController *nextTabVC;

@property(strong, nonatomic) UIColor *previousTabColor;
@property(strong, nonatomic) UIColor *currentTabColor;
@property(strong, nonatomic) UIColor *nextTabColor;

-(void)setScreenEdgeGesture:(UIView *)view edge:(UIRectEdge)edge;
-(void)setPanGesture:(UIView *)view;
-(void)setTapGesture:(UIView *)view;
@end
