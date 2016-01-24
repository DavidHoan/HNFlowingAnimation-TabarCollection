//
//  UIView+Snapshot.m
//  HNFlowingAnimation
//
//  Created by Nguyen Duc Hoang on 1/5/16.
//  Copyright © 2016 Nguyen Duc Hoang. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)
- (UIImage *)takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES
                                           , 0.0f);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
