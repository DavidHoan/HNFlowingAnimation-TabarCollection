//
//  UIView+GCLibrary.m
//  HNFlowingAnimation
//
//  Created by Nguyen Duc Hoang on 1/7/16.
//  Copyright © 2016 Nguyen Duc Hoang. All rights reserved.
//

#import "UIView+GCLibrary.h"

@implementation UIView (GCLibrary)
- (CGFloat) height {
    return self.frame.size.height;
}

- (CGFloat) width {
    return self.frame.size.width;
}

- (CGFloat) x {
    return self.frame.origin.x;
}

- (CGFloat) y {
    return self.frame.origin.y;
}

- (CGFloat) centerY {
    return self.center.y;
}

- (CGFloat) centerX {
    return self.center.x;
}

- (void) setHeight:(CGFloat) newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (void) setWidth:(CGFloat) newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (void) setX:(CGFloat) newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (void) setY:(CGFloat) newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (void) shake {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[@(-3), @(3),@(-3), @(3), @(-2), @(2), @(-1), @(1), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
