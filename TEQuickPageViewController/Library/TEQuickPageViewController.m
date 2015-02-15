//
//  TEQuickPageViewController.m
//  TEQuickPageViewController
//
//  Created by Tom Elliott on 14/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import "TEQuickPageViewController.h"

@interface TEQuickPageViewController ()

@end

@implementation TEQuickPageViewController
{
    // List of view controllers for the Pages
    NSArray *myViewControllers;
}

@synthesize wrapAround;
@synthesize pageIdentifierPrefix;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    
    
    NSMutableArray* viewControllers = [NSMutableArray array];
    NSMutableArray* startingViewControllers = [NSMutableArray array];
    
    /* Add controllers 0..n until the first failure */
    for(int i = 0; true; i++){
        @try {
            // Append to the VC list a VC with storyboard name matching this VC's prefix plus i
            UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@%d",pageIdentifierPrefix,i]];
            [viewControllers addObject:controller];
            
            // Populate the starting controllers as needed
            if(i == 0 || (i == 1 && self.spineLocation == UIPageViewControllerSpineLocationMid)){
                [startingViewControllers addObject:controller];
            }
        
        }
        @catch (NSException *exception) {
            // On the first failure, stop adding VCs
            break;
        }
        @finally {
        }

    }
    
    // Initialize view controllers with first controller
    myViewControllers = viewControllers;
    [self setViewControllers:startingViewControllers
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO completion:nil];
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
