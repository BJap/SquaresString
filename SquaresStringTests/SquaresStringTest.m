//
//  SquaresStringStoreTest.m
//  SquaresString
//
//  Created by Bobby Jap on 1/24/15.
//  Copyright (c) 2015 Bobby Jap. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "SquaresStringStore.h"

@interface SquaresStringTest : XCTestCase

@end

@implementation SquaresStringTest

/**“If we have a sequence of numbers 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,13, 14, 15 and we want this sequence to be in an order such that every number and the number next to it when added together form another number that is a perfect square. Perfect squares are numbers such as 4, 9, 16 etc which can be formed by squaring and integer.
 
    An example of a correct solution to the above problem is:
 
    8, 1, 15, 10, 6, 3, 13, 12, 4, 5, 11, 14, 2, 7, 9
 
    Write a program in pseudo­code or code which can find solutions to this problem.”*/

// Test the base case that is assigned
- (void)testAssignedInput
{
    SquaresStringStore *store = [[SquaresStringStore alloc] init];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[@8, @1, @15, @10, @6, @3, @13, @12, @4, @5, @11, @14, @2, @7, @9];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// An 'endpoint' is defined as a number that can only be placed next to one other valid number to equal a perfect square when summed together

// Test that another input that has a solution works and there is one guaranteed endpoint to work with, '18'
- (void)testThirtyInputOneEndpoint
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithEnd:30];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[@18, @7, @29, @20, @16, @9, @27, @22, @3, @13, @12, @4, @5, @11, @14, @2, @23, @26, @10, @6, @30, @19, @17, @8, @28, @21, @15, @1, @24, @25];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// Test the brute force method since there is no endpoint to start with
- (void)testBruteForceNoEndpoint
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithEnd:31];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[@1, @15, @10, @6, @30, @19, @17, @8, @28, @21, @4, @5, @31, @18, @7, @29, @20, @16, @9, @27, @22, @3, @13, @12, @24, @25, @11, @14, @2, @23, @26];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// Test that the algorithm works even when '1' is not used as the starting point to find a solution
- (void)testDifferentStart
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithStart:4 andEnd:5];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[@4, @5];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// Test a simple range that is known to have no solution
- (void)testSimpleNoSolution
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithEnd:4];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// Test that there is no solution from a range between the exact same number and itself
- (void)testSameNumbersNoSolution
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithStart:4 andEnd:4];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}


// Test that having the start larger than the end for a range is a bad set of parameters and produces no solution
- (void)testReversedNumbersNoSolution
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithStart:15 andEnd:1];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// Test that having a '0' as the beginning of a range is a bad parameter (must start with '1' or greater) and produces no solution
- (void)testZeroNumberNoSolution
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithStart:0 andEnd:15];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

// Test that having a negative number is a bad parameter and produces no solution
- (void)testNegativeNumberNoSolution
{
    SquaresStringStore *store = [[SquaresStringStore alloc] initWithStart:-15 andEnd:-1];
    NSArray *testArray = [store findASolution];
    NSArray *controlArray = @[];
    
    XCTAssertTrue([testArray isEqualToArray:controlArray], "Arrays not equal. Test Array = %@", testArray);
}

@end
