//
//  TEQuickPageViewControllerTests.m
//  TEQuickPageViewControllerTests
//
//  Created by Tom Elliott on 14/02/2015.
//  Copyright (c) 2015 The Other Tom Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TEQuickPageViewController.h"

@interface TEQuickPageViewControllerTests : XCTestCase

@property (nonatomic) NSBundle* bundle;

@end

@implementation TEQuickPageViewControllerTests

- (void)setUp {
    [super setUp];

    self.bundle = [NSBundle bundleForClass:[self class]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Test Definitions

/**
 * Test a 4 page layout with wraparound
 */
- (void)testItBuildsA4PageLayoutWithWraparound {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Test4PageWithWraparound" bundle:self.bundle];
    
    // Get the initial view controller for the example storyboard, should set up the board
    TEQuickPageViewController *vc = [sb instantiateInitialViewController];
    [vc viewDidLoad];
    
    [self controllerHandlesWraparound:vc withTotalPages:4 andRIPrefix:@"View"];
}

/**
 * Test a 4 page layout with no wraparound
 */
- (void)testItBuildsA4PageLayoutNoWraparound {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Test4PageNoWraparound" bundle:self.bundle];
    
    // Get the initial view controller for the example storyboard, should set up the board
    TEQuickPageViewController *vc = [sb instantiateInitialViewController];
    [vc viewDidLoad];
    
    [self controllerHandlesNoWraparound:vc withTotalPages:4 andRIPrefix:@"View"];
}

/**
 * Test multiple 2 page layouts
 */
- (void)testItHandlesMultiple2PageLayouts {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"TestMultiple2Page" bundle:self.bundle];
    
    // Get the initial view controller for the example storyboard, should set up the board
    TEQuickPageViewController *vc1 = [sb instantiateInitialViewController];
    TEQuickPageViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"Set2"];
    [vc1 viewDidLoad];
    [vc2 viewDidLoad];
    
    [self controllerHandlesNoWraparound:vc1 withTotalPages:2 andRIPrefix:@"Set1-"];
    [self controllerHandlesNoWraparound:vc2 withTotalPages:2 andRIPrefix:@"Set2-"];
}

#pragma mark Test Utility Methods

- (void)controllerHandlesNoWraparound:(TEQuickPageViewController*) vc withTotalPages:(int)totalPages andRIPrefix:(NSString*) riPrefix {
    // Check that we have 4 pages
    XCTAssert(totalPages == [vc presentationCountForPageViewController:vc], @"Unexpected number of pages: %ld", (long)[vc presentationCountForPageViewController:vc]);
    
    NSMutableArray* pages = [NSMutableArray arrayWithCapacity:totalPages];
    
    // Pull the first page
    UIViewController* currentPage = [vc viewControllerAtIndex:0];
    XCTAssert(currentPage != nil, @"Expected a first page!");
    
    XCTAssert(nil == [vc pageViewController:vc viewControllerBeforeViewController:currentPage],@"Expected a null page before beginning of sequence.");
    
    [pages addObject:currentPage];
    for(int i = 0; i < totalPages; i++){
        NSString* expected = [NSString stringWithFormat:@"%@%d",riPrefix,i];
        XCTAssert([currentPage.restorationIdentifier isEqualToString:expected],@"Received unexpected identifier for view %d: %@", i, currentPage.restorationIdentifier);
        
        currentPage = [vc pageViewController:vc viewControllerAfterViewController:currentPage];
    }
    
    XCTAssert(nil == currentPage,@"Expected a null page after end of sequence.");
}

- (void)controllerHandlesWraparound:(TEQuickPageViewController*) vc withTotalPages:(int)totalPages andRIPrefix:(NSString*) riPrefix {
    // Check that we have 4 pages
    XCTAssert(totalPages == [vc presentationCountForPageViewController:vc], @"Unexpected number of pages.");
    
    // Pull the first page
    UIViewController* currentPage = [vc viewControllerAtIndex:0];
    XCTAssert(currentPage != nil, @"Expected a first page!");
    
    // Make three forward passes over the page sequence
    
    for(int i = 0; i < totalPages * 3; i++){
        int position = i%totalPages;
        NSString* expected = [NSString stringWithFormat:@"%@%d",riPrefix,position];
        XCTAssert([currentPage.restorationIdentifier isEqualToString:expected],@"Received unexpected identifier for view %d: %@, expected %@", i, currentPage.restorationIdentifier, expected);
        currentPage = [vc pageViewController:vc viewControllerAfterViewController:currentPage];
    }
    
    // Make three reverse passes over the page sequence
    
    currentPage = [vc viewControllerAtIndex:0];
    
    for(int i = 0; i < totalPages * 3; i++){
        int position = totalPages - (i%totalPages);
        if(position == totalPages){
            position = 0;
        }
        NSString* expected = [NSString stringWithFormat:@"%@%d",riPrefix,position];
        XCTAssert([currentPage.restorationIdentifier isEqualToString:expected],@"Received unexpected identifier for view %d: %@, expected %@", i, currentPage.restorationIdentifier, expected);
        currentPage = [vc pageViewController:vc viewControllerBeforeViewController:currentPage];
    }
}


@end
