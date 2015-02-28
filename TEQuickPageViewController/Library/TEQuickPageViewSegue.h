//
//  TEQuickPageViewSegue.h
//  TEQuickPageViewController
//
//  Created by Tom Elliott on 27/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

// Notification indicating that a segue has been performed as part of the current sequence
#define TEQuickPageViewSegueNotification @"com.theothertomelliott.TEQuickPageView.SeguePerformed"

// Notification indicating that a sequence of page views has completed (i.e.: we've run out of segues)
#define TEQuickPageViewSequenceComplete @"com.theothertomelliott.TEQuickPageView.SequenceComplete"

@interface TEQuickPageViewSegue : UIStoryboardSegue

+ (TEQuickPageViewSegue*) segueFromNotification:(NSNotification*) notification;

- (void) performNextSegueWithIdentifier:(NSString*) identifier;

@end
