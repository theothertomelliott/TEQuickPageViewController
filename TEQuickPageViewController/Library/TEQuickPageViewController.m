//
//  TEQuickPageViewController.m
//  TEQuickPageViewController
//
//  Created by Tom Elliott on 14/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import "TEQuickPageViewController.h"
#import "TEQuickPageViewSegue.h"

@interface TEQuickPageViewController ()

@end

@implementation TEQuickPageViewController
{
    // List of view controllers for the Pages
    NSArray *myViewControllers;
}

@synthesize segueId;
@synthesize wrapAround;
@synthesize extendedPage;
@synthesize indicatorTint;
@synthesize indicatorCurrentPageTint;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block NSString* mySegueIdentifier = segueId;
    if(segueId == nil || segueId.length == 0){
        mySegueIdentifier = @"page";
    }

    self.delegate = self;
    self.dataSource = self;
    
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    
    NSMutableArray* viewControllers = [NSMutableArray array];
    NSMutableArray* startingViewControllers = [NSMutableArray array];
    
    id segueObserver = [notificationCenter addObserverForName:TEQuickPageViewSegueNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        TEQuickPageViewSegue* segue = [TEQuickPageViewSegue segueFromNotification:note];
        
        UIViewController* destinationVC = segue.destinationViewController;
        [viewControllers addObject:destinationVC];
        
        // Populate the starting controllers as needed
        if(viewControllers.count == 1 || (viewControllers.count == 2 && self.spineLocation == UIPageViewControllerSpineLocationMid)){
            [startingViewControllers addObject:destinationVC];
        }
        
        [segue performNextSegueWithIdentifier:mySegueIdentifier];
        
    }];

    id completionObserver = [notificationCenter addObserverForName:TEQuickPageViewSegueNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        // We've finished
    }];

    @try {
        // Begin execution of all the segues
        [self performSegueWithIdentifier:mySegueIdentifier sender:self];
    }
    @catch (NSException* ex){
        // TODO: Error out appropriately
        return;
    }
    
    [notificationCenter removeObserver:segueObserver];
    [notificationCenter removeObserver:completionObserver];
    
    // Initialize view controllers with first controller
    myViewControllers = viewControllers;
    [self setViewControllers:startingViewControllers
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO completion:nil];
}

- (void) viewWillAppear:(BOOL)animated {

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
    // target is iOS
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 90000
    // target is lower than iOS 9.0
    UIPageControl* pageControlAppearance = [UIPageControl appearanceWhenContainedIn:[TEQuickPageViewController class], nil];
#else
    // target is at least iOS 9.0
    UIPageControl* pageControlAppearance = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[TEQuickPageViewController class]]];
#endif
#endif
    [pageControlAppearance setPageIndicatorTintColor: indicatorTint];
    [pageControlAppearance setCurrentPageIndicatorTintColor: indicatorCurrentPageTint];
    [pageControlAppearance setBackgroundColor: [UIColor clearColor]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if(extendedPage){
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[NSClassFromString(@"_UIQueuingScrollView") class]]) {
                CGRect frame = view.frame;
                frame.size.height = view.superview.frame.size.height;
                view.frame = frame;
            }
        }
    }
}

- (NSData *)dataForView:(UIView *)view {
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver  *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:view forKey:@"view"];
    [archiver finishEncoding];
    
    return data;
}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    return myViewControllers[index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [myViewControllers indexOfObject:viewController];
    
    // wraparound off: When at first VC, there will be no previous VC
    if(!wrapAround && currentIndex == 0){
        return nil;
    }
    
    // Decrement index, using modulo for wraparound
    --currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    
    // Output selected VC
    return [myViewControllers objectAtIndex:currentIndex];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [myViewControllers indexOfObject:viewController];
    
    // wraparound off: When at final VC, there will be no subsequent VC
    if(!wrapAround && currentIndex == myViewControllers.count - 1){
        return nil;
    }
    
    // Increment index, using modulo for wraparound
    ++currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    
    // Output selected VC
    return [myViewControllers objectAtIndex:currentIndex];
}

-(NSInteger)presentationCountForPageViewController:
(UIPageViewController *)pageViewController
{
    return myViewControllers.count;
}

-(NSInteger)presentationIndexForPageViewController:
(UIPageViewController *)pageViewController
{
    return 0;
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

@end
