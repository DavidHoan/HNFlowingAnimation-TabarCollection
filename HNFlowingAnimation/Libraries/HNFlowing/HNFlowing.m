//
//  HNFlowing.m
//  HNFlowingAnimation
//  Created by Nguyen Duc Hoang on 1/3/16. Skype: sunlight3d@icloud.com, Tel: 0084-0964896239
//  Copyright © 2016 Nguyen Duc Hoang. All rights reserved.
//

#import "HNFlowing.h"
#define SMILE_ICON @""
#define ENABLE_SMILE_ICON 0

@implementation HNFlowing {
    CAShapeLayer *shapeLayer;
    CADisplayLink *displayLink;
    
    CGFloat frameWidth;
    CGFloat frameHeight;
    UILabel *lblSmileIcon;
    UIImageView *viewSmileIcon;
    BOOL useFontAwesome;
    CGFloat percentAngle;
    
    UIImageView *barTopImageView;
    UIImageView *screenShotImageView;
    UIImageView *barBottomImageView;
    
    BOOL takeScreenShot;
    UIRectEdge currentEdge;
    CGFloat durationOfChangePosition;
    CGPoint leftRightPosition;
    BOOL enableAnimation;
    UIBezierPath *currentPath;
    UIBezierPath *previousPath;
    CGPoint centerPosition;
    CGFloat widthToStartFullScreen;
    CGFloat velocityX;
    
    CGPoint startPoint;
    CGPoint p1;
    CGPoint p5;
    CGPoint p3;
    CGPoint p;
    CGPoint p4;
    CGPoint p6;
    CGPoint p2;
    CGPoint endPoint;
    UIView *currentView;
    UIPanGestureRecognizer *panGestureRecognizer;
    int flowingPoint;
    int numberOfBegin;
    int numberOfFullScreen;
}
@synthesize currentTabColor;
struct YValues {
    CGFloat y1;
    CGFloat y2;
};

typedef struct YValues YValues;

- (id)init {
    if (self == [super init]) {
        shapeLayer = [[CAShapeLayer alloc] init];
        previousPath = [[UIBezierPath alloc] init];
        currentPath = [[UIBezierPath alloc] init];
    }
    return self;
}

-(void)setScreenEdgeGesture:(UIView *)view edge:(UIRectEdge)edge {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
    screenEdgePanGesture.edges = edge;
    [screenEdgePanGesture addTarget:self action:@selector(panToPresentAction:)];
    [view addGestureRecognizer:screenEdgePanGesture];
    useFontAwesome = NO;
}
-(void)startUpdateLoop {
    displayLink.paused = false;
}

-(void)stopUpdateLoop {
    displayLink.paused = true;
}

-(void)setTapGesture:(UIView *)view {
    UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] init];
    tapGesture.minimumPressDuration = .1;
    [tapGesture addTarget:self action:@selector(panToPresentAction:)];
    [view addGestureRecognizer:tapGesture];
    useFontAwesome = NO;
}

-(void)setPanGesture:(UIView *)view {
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
//    shapeLayer = [[CAShapeLayer alloc] init];
    [panGestureRecognizer addTarget:self action:@selector(panToPresentAction:)];
    [view addGestureRecognizer: panGestureRecognizer];
    useFontAwesome = NO;
}

-(void)panToPresentAction:(UIPanGestureRecognizer *)panGesture {
    numberOfBegin = (numberOfBegin > 10000)?0:numberOfBegin;
    numberOfFullScreen = (numberOfFullScreen > 10000)?0:numberOfFullScreen;
    UIView *view = panGesture.view;
    currentView = view;
    UIGestureRecognizerState currentState = panGesture.state;
    CGPoint position = [panGesture locationInView:panGesture.view];
    frameWidth = [[UIScreen mainScreen] bounds].size.width;
    frameHeight = [[UIScreen mainScreen] bounds].size.height;
    widthToStartFullScreen = frameWidth/2;
    centerPosition = CGPointMake(frameWidth/2, frameHeight/2);
    if ([panGesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        currentEdge = ((UIScreenEdgePanGestureRecognizer *)panGesture).edges;
        if ((!self.previousTabVC && currentEdge==UIRectEdgeLeft) || (!self.nextTabVC && currentEdge==UIRectEdgeRight)) {
            enableAnimation = NO;
            return;
        } else {
            enableAnimation = YES;
        }
    }
    
    switch (currentState) {
        case UIGestureRecognizerStateBegan: {
            numberOfBegin = 1;
            numberOfFullScreen = 0;
            NSLog(@"gesture begin");
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            velocityX = [panGesture velocityInView:view].x;
            [self removeShapeLayerAndSmileIcon];
            flowingPoint = 1;
            [shapeLayer removeFromSuperlayer];
            if([panGesture isKindOfClass:[UIPanGestureRecognizer class]]) {
                if (position.x >0 && position.x < frameWidth/2-10 && velocityX>0) {
                    currentEdge = UIRectEdgeLeft;
                } else if (position.x > frameWidth - (frameWidth/2 - 10) && velocityX<0) {
                    currentEdge = UIRectEdgeRight;
                } else {
                    currentEdge = UIRectEdgeNone;
                }
            }
            if (currentEdge == UIRectEdgeLeft) {
                startPoint = CGPointMake(0, 0);
                endPoint = CGPointMake(0, frameHeight);
            } else {
                startPoint = CGPointMake(frameWidth, 0);
                endPoint = CGPointMake(frameWidth, frameHeight);
            }
            if ((!self.previousTabVC && currentEdge==UIRectEdgeLeft) || (!self.nextTabVC && currentEdge==UIRectEdgeRight)) {
                enableAnimation = NO;
                return;
            } else {
                enableAnimation = YES;
            }
            [self makeScreenShotImage];
            takeScreenShot = NO;
            percentAngle = 0.7;
            if (lblSmileIcon) {
               [lblSmileIcon removeFromSuperview];
            }
            
            if (useFontAwesome) {
                lblSmileIcon = [[UILabel alloc] initWithFrame:CGRectMake(-200, 0, 100, 100)];
                lblSmileIcon.textColor = [UIColor whiteColor];
                [lblSmileIcon setFont:[UIFont fontWithName:@"FontAwesome" size:40]];
                lblSmileIcon.text = SMILE_ICON;
                [view addSubview:lblSmileIcon];
            } else {
                viewSmileIcon = [[UIImageView alloc] initWithFrame:CGRectMake(-200, 0, 100, 100)];
#if ENABLE_SMILE_ICON
                viewSmileIcon.image = [UIImage imageNamed:@"smile_icon.png"];
#else
                viewSmileIcon.hidden = YES;
#endif                
                [view addSubview:viewSmileIcon];
            }
            [self makeBottomTabScreenShotImage];
        }
            
            break;
        case UIGestureRecognizerStateChanged: {
            NSLog(@"gesture changed");
            if (!enableAnimation) {
                return;
            }
            durationOfChangePosition = 0;
            [self drawFlowingAtPosition:position inView:view];
            CGPoint smilePosition = position;
            if (currentEdge == UIRectEdgeLeft) {
                smilePosition.x = position.x - 120;
            } else {
                smilePosition.x = position.x + 120;
            }
            smilePosition.y = ([self getYMiddleLine:smilePosition.x WithEdge:currentEdge atPosition:position] + position.y)/2;
            if (useFontAwesome) {
                lblSmileIcon.center = position;
            } else {
                viewSmileIcon.center = smilePosition;
                [view bringSubviewToFront:viewSmileIcon];
            }
            CGFloat angleSmile = atan((position.y - frameHeight/2)/position.x);
            if (angleSmile > 0.29) {
                angleSmile = 0.29;
            } else if(angleSmile < -0.29) {
                angleSmile = -0.29;
            }
            viewSmileIcon.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angleSmile);
            [self.delegate flowingChangedAnimation:self edge:currentEdge position:position];
            if((position.x > 0.5*frameWidth && currentEdge == UIRectEdgeLeft) ||
               (position.x < 0.5*frameWidth && currentEdge == UIRectEdgeRight)) {
                if (!takeScreenShot) {
                    [self.delegate makeScreenShot:self edge:currentEdge];
                    takeScreenShot = YES;
                }
                [self moveScreenShotToPosition:position timeInterval:0];
                screenShotImageView.hidden = NO;
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded: {
            NSLog(@"gesture end");
            flowingPoint++;
            if (!enableAnimation) {
                return;
            }
            if((currentEdge == UIRectEdgeLeft && position.x > 0.55*frameWidth) ||
               (currentEdge == UIRectEdgeRight && position.x < (1-0.55)*frameWidth)
               ) {
                if (currentEdge == UIRectEdgeLeft) {
                    [self drawFlowingAtPosition:CGPointMake(frameWidth, position.y) inView:view];
                } else {
                    [self drawFlowingAtPosition:CGPointMake(0, position.y) inView:view];
                }
            } else {
                if (currentEdge == UIRectEdgeLeft) {
                    [self drawFlowingAtPosition:CGPointMake(0, position.y) inView:view];
                } else {
                    [self drawFlowingAtPosition:CGPointMake(frameWidth, position.y) inView:view];
                }
                
                [self moveScreenShotToPosition: centerPosition timeInterval:0.2];
            }
            [view shake];
            takeScreenShot = NO;
            [barBottomImageView removeFromSuperview];
            barBottomImageView = nil;
        }
            break;
        
        default:
            break;
    }
}

- (void)removeShapeLayerAndSmileIcon {
//    panGestureRecognizer.enabled = YES;
    [shapeLayer removeFromSuperlayer];
    if (useFontAwesome) {
        lblSmileIcon.text = @"";
        [lblSmileIcon removeFromSuperview];
    } else {
        [viewSmileIcon removeFromSuperview];
    }
    [screenShotImageView removeFromSuperview];
    screenShotImageView = nil;
    [barBottomImageView removeFromSuperview];
    barBottomImageView = nil;
}

- (void) drawFlowingAtPosition:(CGPoint)position inView:(UIView *)view {
    if (numberOfBegin == numberOfFullScreen) {
        return;
    }
    if (flowingPoint >=3 || currentEdge==UIRectEdgeNone) {
        return;
    }
    currentPath = [[UIBezierPath alloc] init];
    startPoint = (currentEdge == UIRectEdgeLeft)?CGPointMake(0, 0):CGPointMake(frameWidth, 0);
    p = position;
    p1.x = [self getP1xFromPx:p.x];
    if (currentEdge == UIRectEdgeLeft) {
        p.x = p1.x>=frameWidth?frameWidth:p.x;
    } else {
        p.x = p1.x<=0?0:p.x;
    }
    p1.y = 0;
    
    p3 = CGPointMake((p1.x + p.x)/2, (p1.y + p.y)/2);
    p5 = CGPointMake((p1.x + p3.x)/2, (p1.y + p3.y)/2 + 10);
    
    p2.x = p1.x;
    p2.y = frameHeight;
    p4 = CGPointMake((p2.x + p.x)/2, (p2.y + p.y)/2 );
    p6 = CGPointMake((p2.x + p4.x)/2, (p2.y + p4.y)/2 - 10);
    endPoint = (currentEdge == UIRectEdgeLeft)?CGPointMake(0, frameHeight):CGPointMake(frameWidth, frameHeight);
    [currentPath moveToPoint:startPoint];
    [currentPath addLineToPoint:p1];
    [currentPath addQuadCurveToPoint:p3 controlPoint:p5];
    CGPoint pDelta = p;
    pDelta.x = (currentEdge == UIRectEdgeLeft)?p.x + 20:p.x - 20;
    if (currentEdge == UIRectEdgeLeft) {
        pDelta.x = (pDelta.x <= 20)?0:pDelta.x;
    } else {
        pDelta.x = (pDelta.x >= frameWidth - 20)?frameWidth:pDelta.x;
    }
    
    [currentPath addQuadCurveToPoint:p4 controlPoint:pDelta];
    [currentPath addQuadCurveToPoint:p2 controlPoint:p4];
    
    [currentPath addLineToPoint:endPoint];
    [currentPath closePath];
    [shapeLayer setPath:currentPath.CGPath];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = durationOfChangePosition;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.fillMode = kCAFillModeBoth;
    animation.fromValue = (id) previousPath.CGPath;
    animation.toValue = (id) currentPath.CGPath;
    [shapeLayer addAnimation:animation forKey:nil];
    previousPath = currentPath;
    [shapeLayer removeFromSuperlayer];
    [view.layer addSublayer:shapeLayer];
    BOOL reachFullScreen = (currentEdge == UIRectEdgeLeft && p1.x >= frameWidth) ||
                            (currentEdge == UIRectEdgeRight && p1.x <= 0);
    if(reachFullScreen) {
        numberOfFullScreen++;
        flowingPoint++;
//        panGestureRecognizer.enabled = NO;
        [screenShotImageView removeFromSuperview];
        screenShotImageView = nil;
        [barBottomImageView removeFromSuperview];
        barBottomImageView = nil;
        
        shapeLayer.fillColor = [self.currentTabColor colorWithAlphaComponent:0.95].CGColor;
        [self.delegate flowingFullScreen:self edge:currentEdge];
        [self performSelector:@selector(fadeFlowingAtPosition) withObject:self afterDelay:0.3];
        NSLog(@"numberOfFullScreen = %d, numberOfBegin = %d",numberOfFullScreen, numberOfBegin);
    } else {
//        panGestureRecognizer.enabled = YES;
        shapeLayer.fillColor = [self.currentTabColor colorWithAlphaComponent:1].CGColor;
    }
    
}

-(UIColor *)currentTabColor {
    return (currentEdge==UIRectEdgeLeft)?self.previousTabColor:self.nextTabColor;
}
- (void) fadeFlowingAtPosition {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeShapeLayerAndSmileIcon) object:nil];
    NSLog(@"fade");
    UIColor *currentColor = [UIColor colorWithCGColor:shapeLayer.fillColor];
    CABasicAnimation *strokeAnim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    strokeAnim.toValue           = (id) [currentColor colorWithAlphaComponent:0.0f].CGColor;
    strokeAnim.duration          = 0.5;
    strokeAnim.repeatCount       = 0;
    strokeAnim.autoreverses      = YES;
    [shapeLayer addAnimation:strokeAnim forKey:nil];
    [self performSelector:@selector(removeShapeLayerAndSmileIcon) withObject:self afterDelay:0.4];
}

- (CGFloat) getP1xFromPx:(CGFloat)px {
    CGFloat result;
    CGFloat deltaX1 = 0.05;
    CGFloat deltaX2 = 0.7;
    CGFloat X1, X2,Y1,Y2;
    if (currentEdge == UIRectEdgeLeft) {
        X1 = frameWidth*deltaX2;
        Y1 = deltaX1*frameWidth;
        X2 = frameWidth;
        Y2 = frameWidth;
    } else {
        X2 = frameWidth*(1 - deltaX2);
        Y2 = (1 - deltaX1)*frameWidth;
        X1 = 0;
        Y1 = 0;
    }
    result = (px - X1)*(Y2 - Y1)/(X2 - X1) + Y1;
    //exception
    if (currentEdge == UIRectEdgeLeft) {
        if (px > (1 - deltaX1)*frameWidth) {
            result = frameWidth;
        }
        if (result < Y1) {
            result = 0;
        }
    } else {
        if (px < deltaX1*frameWidth) {
            result = 0;
        }
        if (result > Y2) {
            result = frameWidth;
        }
    }
    return result;
}

- (YValues)getYFromXInpolyLine:(CGFloat)xValue WithEdge:(UIRectEdge)edge atPosition:(CGPoint)position{
    YValues yValues;
    if (edge == UIRectEdgeLeft) {
        if (xValue <= position.x) {
            yValues.y1 = xValue*(position.y/position.x);
            yValues.y2 = (xValue - position.x)*(position.y - frameHeight)/position.x + position.y;
        }
    } else {
        if (xValue >= position.x) {
            yValues.y1 = (xValue - position.x)*position.y/(position.x - frameWidth) + position.y;
            yValues.y2 = (xValue - position.x)*(frameHeight - position.y)/(frameWidth - position.x) + position.y;
        }
    }
    return yValues;
}

- (CGFloat)getYMiddleLine:(CGFloat)xValue WithEdge:(UIRectEdge)edge atPosition:(CGPoint)position{
    CGFloat yValue;
    if (edge == UIRectEdgeLeft) {
        if (xValue <= position.x) {
            yValue = (xValue - position.x)*(position.y - 0.5*frameHeight)/position.x + position.y;
        }
    } else {
        if (xValue >= position.x) {
            yValue = (xValue - position.x)*(0.5*frameHeight-position.y)/(frameWidth - position.x) + position.y;
        }
    }
    return yValue;
}

- (void)makeScreenShotImage {
    UIView *view1 = self.currentVC.view;
    UIView *view2;
    if (currentEdge == UIRectEdgeLeft) {
        view2 = self.previousTabVC?self.previousTabVC.view:[[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    } else {
        view2 = self.nextTabVC?self.nextTabVC.view:[[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    }
//    view2.backgroundColor = self.endViewColor;
    [screenShotImageView removeFromSuperview];
    screenShotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2*frameWidth, view1.height)];
    screenShotImageView.backgroundColor = [UIColor clearColor];
    screenShotImageView.hidden = YES;
    [CATransaction setDisableActions:YES];
    shapeLayer.hidden = YES;
    UIImage *image2 = [view2 takeSnapshot];
    UIImage *image1 = [view1 takeSnapshot];
    shapeLayer.hidden = NO;
    [CATransaction setDisableActions:NO];
    screenShotImageView.image = [self imageByCombiningImage:image1 withImage:image2];
    [self.currentVC.view addSubview:screenShotImageView];    
    [self.currentVC.view bringSubviewToFront:barBottomImageView];
}

- (UIImage*)imageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage {
    UIImage *image = nil;
    
    CGSize newImageSize;
    newImageSize = CGSizeMake(firstImage.size.width + secondImage.size.width, firstImage.size.height);
    UIGraphicsBeginImageContextWithOptions(newImageSize, currentView.opaque, 0.0);
    if (currentEdge == UIRectEdgeRight) {
        [firstImage drawAtPoint:CGPointMake(0,0)];
        [secondImage drawAtPoint:CGPointMake(firstImage.size.width,0)];
        barBottomImageView.x = 0;
    } else {
        [firstImage drawAtPoint:CGPointMake(secondImage.size.width,0)];
        [secondImage drawAtPoint:CGPointMake(0,0)];
        barBottomImageView.x = firstImage.size.width;
    }
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)makeBottomTabScreenShotImage {
    [barBottomImageView removeFromSuperview];
    barBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-200, -200, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
    barBottomImageView.hidden = YES;
    NSLog(@"take bottom");
    barBottomImageView.image = [self.bottomView takeSnapshot];
    barBottomImageView.backgroundColor = [UIColor whiteColor];
    [self.currentVC.view addSubview:barBottomImageView];
    [self.currentVC.view bringSubviewToFront:barBottomImageView];
    barBottomImageView.x = 0;
    barBottomImageView.y = frameHeight - barBottomImageView.height;
    barBottomImageView.hidden = NO;
}

- (void) moveScreenShotToPosition:(CGPoint)position timeInterval:(CGFloat)timeInterval{
    CGPoint screenShotPosition = position;
    screenShotPosition.y = screenShotImageView.center.y;
    CGPoint bottomBarShotPosition = position;
    bottomBarShotPosition.x = position.x;
    bottomBarShotPosition.y = barBottomImageView.center.y;
    if (currentEdge == UIRectEdgeLeft) {
        screenShotPosition.x = position.x - frameWidth/2;
    } else {
        screenShotPosition.x = position.x + frameWidth/2;
    }
    [UIView animateWithDuration:timeInterval animations:^{
       screenShotImageView.center = screenShotPosition;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)shrinkBottomBarAtPosition:(CGPoint) position {
    if (barBottomImageView) {
        CGFloat scale;
        if (position.x <= 5 || position.x >= frameWidth-5) {
            scale = 1.00;
        } else {
            scale = 0.1*position.x/frameWidth;
        }
        
        if (currentEdge == UIRectEdgeLeft) {
            barBottomImageView.width = [[UIScreen mainScreen] bounds].size.width*(1-scale);
            barBottomImageView.x = frameWidth - barBottomImageView.width;
        } else if (currentEdge == UIRectEdgeRight) {
            barBottomImageView.width = (scale == 1)?barBottomImageView.width:[[UIScreen mainScreen] bounds].size.width/(1-scale);
            barBottomImageView.x = 0;
        }
        self.bottomView.frame = barBottomImageView.frame;
    }    
}

@end
