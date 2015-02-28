//
//  BasicView.m
//  TEQuickPageViewController
//
//  Created by Tom Elliott on 27/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import "BasicView.h"

@implementation BasicView

- (IBAction)doneButton:(id)sender {
    [self performSegueWithIdentifier:@"done" sender:self];
}

@end
