//
//  TEQuickPageViewController.h
//  TEQuickPageViewController
//
//  Created by Tom Elliott on 14/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEQuickPageViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic) IBInspectable NSString* segueId;
@property (nonatomic) IBInspectable BOOL wrapAround;
@property (nonatomic) IBInspectable BOOL extendedPage;
@property (nonatomic) IBInspectable UIColor* indicatorTint;
@property (nonatomic) IBInspectable UIColor* indicatorCurrentPageTint;

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
