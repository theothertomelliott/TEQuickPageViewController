//
//  TEQuickPageViewSegue.m
//  TEQuickPageViewController
//
//  Created by Tom Elliott on 27/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import "TEQuickPageViewSegue.h"

#define TEQPVSNotificationParam_Segue @"segue"

@implementation TEQuickPageViewSegue

- (void) perform {
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:TEQuickPageViewSegueNotification object:self];
}

- (void) performNextSegueWithIdentifier:(NSString*) identifier {
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    @try {
        [[self destinationViewController] performSegueWithIdentifier:identifier sender:[self sourceViewController]];
    }
    @catch (NSException* ex){
        [notificationCenter postNotificationName:TEQuickPageViewSequenceComplete object:self];
    }
}

+ (TEQuickPageViewSegue*) segueFromNotification:(NSNotification*) notification {
    id sender = notification.object;
    
    if([sender isKindOfClass:[TEQuickPageViewSegue class]]){
        return (TEQuickPageViewSegue*) sender;
    }
    
    return nil;
}

@end
