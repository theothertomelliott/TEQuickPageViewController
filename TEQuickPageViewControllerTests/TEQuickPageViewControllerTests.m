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

@end

@implementation TEQuickPageViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * Test a 4 page layout with wraparound
 */
- (void)testItBuildsA4PageLayoutWithWraparound {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Test4PageWithWraparound" bundle:bundle];
    
    // Get the initial view controller for the example storyboard, should set up the board
    TEQuickPageViewController *vc = [sb instantiateInitialViewController];
    [vc viewDidLoad];
    
    int TOTAL_PAGES = 4;
    
    // Check that we have 4 pages
    XCTAssert(TOTAL_PAGES == [vc presentationCountForPageViewController:vc], @"Expected 4 pages.");
    
    // Pull the first page
    UIViewController* currentPage = [vc viewControllerAtIndex:0];
    XCTAssert(currentPage != nil, @"Expected a first page!");

    // Make three forward passes over the page sequence
    
    for(int i = 0; i < TOTAL_PAGES * 3; i++){
        int position = i%TOTAL_PAGES;
       NSString* expected = [NSString stringWithFormat:@"View%d",position];
        XCTAssert([currentPage.restorationIdentifier isEqualToString:expected],@"Received unexpected identifier for view %d: %@, expected %@", i, currentPage.restorationIdentifier, expected);
        currentPage = [vc pageViewController:vc viewControllerAfterViewController:currentPage];
    }
    
    // Make three reverse passes over the page sequence
    
    currentPage = [vc viewControllerAtIndex:0];
    
    for(int i = 0; i < TOTAL_PAGES * 3; i++){
        int position = TOTAL_PAGES - (i%TOTAL_PAGES);
        if(position == TOTAL_PAGES){
            position = 0;
        }
        NSString* expected = [NSString stringWithFormat:@"View%d",position];
        XCTAssert([currentPage.restorationIdentifier isEqualToString:expected],@"Received unexpected identifier for view %d: %@, expected %@", i, currentPage.restorationIdentifier, expected);
        currentPage = [vc pageViewController:vc viewControllerBeforeViewController:currentPage];
    }
    
}

/**
 * Test a 4 page layout with no wraparound
 */
- (void)testItBuildsA4PageLayoutNoWraparound {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Test4PageNoWraparound" bundle:bundle];
    
    // Get the initial view controller for the example storyboard, should set up the board
    TEQuickPageViewController *vc = [sb instantiateInitialViewController];
    [vc viewDidLoad];
    
    // Check that we have 4 pages
    XCTAssert(4 == [vc presentationCountForPageViewController:vc], @"Expected 4 pages.");
    
    NSMutableArray* pages = [NSMutableArray arrayWithCapacity:4];
    
    // Pull the first page
    UIViewController* currentPage = [vc viewControllerAtIndex:0];
    UIViewController* nextPage = [vc pageViewController:vc viewControllerAfterViewController:currentPage];
    XCTAssert(currentPage != nil, @"Expected a first page!");
    
    [pages addObject:currentPage];
    while(nextPage != nil){
        currentPage = nextPage;
        [pages addObject:currentPage];
        nextPage = [vc pageViewController:vc viewControllerAfterViewController:currentPage];
    }
    
    XCTAssert([pages count] == [vc presentationCountForPageViewController:vc],@"Expected to retrieve the advertised number of pages.");
    
    for (int i = 0; i < [pages count]; i++){
        UIViewController* cur = [pages objectAtIndex:i];
        NSString* expected = [NSString stringWithFormat:@"View%d",i];
        
        XCTAssert([cur.restorationIdentifier isEqualToString:expected],@"Received unexpected identifier for view %d: %@", i, cur.restorationIdentifier);
    }
    
}

@end
