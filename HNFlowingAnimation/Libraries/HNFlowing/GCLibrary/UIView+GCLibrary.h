//
//  UIView+GCLibrary.h
//  HNFlowingAnimation
//
//  Created by Nguyen Duc Hoang on 1/7/16.
//  Copyright © 2016 Nguyen Duc Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GCLibrary)
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
- (void) shake;
@end
