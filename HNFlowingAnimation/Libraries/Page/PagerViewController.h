//
//  ViewController.h
//  PageViewController
//
//  Created by Tom Fewster on 11/01/2012.
//

@import UIKit;

@interface PagerViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (void)changePage:(int)page1;

- (void)previousPage;
- (void)nextPage;

@end
