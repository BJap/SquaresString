//
//  SquaresStringStore.m
//  SquaresString
//
//  Created by Bobby Jap on 1/24/15.
//  Copyright (c) 2015 Bobby Jap. All rights reserved.
//

#import "SquaresStringStore.h"

@interface SquaresStringStore ()
{
    int start;
    int end;
    int numberCount;
    int depthCount;
    NSMutableArray *numbers;
    NSMutableArray *stringEndpoints;
    NSMutableSet *usedNumbers;
}

@end

@implementation SquaresStringStore

- (id)init
{
    return [self initWithStart:1 andEnd:15];
}

- (id)initWithEnd:(int)theEnd
{
    return [self initWithStart:1 andEnd:theEnd];
}


- (id)initWithStart:(int)theStart andEnd:(int)theEnd
{
    self = [super init];
    
    if (self)
    {
        start = theStart;
        end = theEnd;
        numberCount = end - start + 1; // The quantity of numbers between and including 'start' and 'end'
        depthCount = 0; // This keeps track of how many numbers deep the traversal goes
        numbers = [[NSMutableArray alloc] init]; // 2D array representing each number, and the numbers it can be placed beside
        stringEndpoints = [[NSMutableArray alloc] init]; // This contains endpoints for a possible solution and greatly improves efficiency
        usedNumbers = [[NSMutableSet alloc] init]; // This keeps track of the numbers used to prevent reuse for each traversal attempt
    }
    
    return self;
}

- (NSArray *)findASolution
{
    NSArray *solution = [[NSArray alloc] init];
    
    // Covers cases in which there must be a proper range and proper parameter entry
    if (start < end && start > 0)
    {
        [self generateReferenceTable];
        
        // The graph must be complete or it is assumed there is no solution
        if (numbers.count == numberCount)
        {
            if (stringEndpoints.count > 0)
            {   // Optimized way to find a solution if possible
                
                int startingNumber = [stringEndpoints[0] intValue];
                solution = [self traverseNumber:startingNumber];
            }
            else
            {   // Brute force way to find a solution
                
                for (int i = start; i <= end; i++)
                {
                    solution = [self traverseNumber:i];
                    
                    if (solution.count > 0) break;
                }
            }
        }
    }
    
    return solution;
}

- (void)generateReferenceTable
{
    NSUInteger startingPerfectRoot = MAX(2, ceil(sqrt(start))); // Minimum starting perfect root must be '2' but to be efficient could be the next perfect root after 'start' square root
    
    for (int i = start; i <= end; i++)
    {
        NSMutableArray *connectedVerticies = [[NSMutableArray alloc] init];
        NSUInteger startingRoot = startingPerfectRoot;
        
        // Find the numbers that can be added to the current number and equal a perfect square
        while (pow(startingRoot, 2) <= end + (end - 1))
        {
            int difference = (int) pow(startingRoot, 2) - i;
            
            if (difference == 0) // The current number is greater than the starting root and the starting root can be removed as a comparison
            {
                startingPerfectRoot++;
            }
            else if (difference >= start && difference <= end) // Only numbers in the give range can be used
            {
                // Numbers cannot be reused (i.e. 8 + 8)
                if (i != difference) [connectedVerticies addObject:[NSNumber numberWithInt:difference]];
            }
            else // There's no point to check the rest of the perfect squares after this one so move to the next number
            {
                break;
            }
            
            startingRoot++;
        }
        
        if (connectedVerticies.count == 1) [stringEndpoints addObject:[NSNumber numberWithInt:i]];
        if (stringEndpoints.count > 2) break; // There are no solutions if there are more than two numbers that can only be placed next to one possible other number
        if (connectedVerticies.count == 0) break; // There are no solutions if even just one number has no numbers it can be placed beside
        
        [numbers addObject:connectedVerticies];
    }
}

- (NSArray *)traverseNumber:(int)number
{
    NSMutableArray *solutionChain = [[NSMutableArray alloc] init];
    NSNumber *convertedNumber = [NSNumber numberWithInt:number];
    
    depthCount++;
    
    
    if (depthCount == numberCount)
    {   // Solution is found no more need for recursion
        
        [solutionChain addObject:convertedNumber];
    }
    else
    {   // Continue traversing as far as possible for every choice until a solution is found
        
        int arraySlot = number - start;
        NSArray *connectedNumbers = numbers[arraySlot];
        
        [usedNumbers addObject:convertedNumber];
        
        // Exhaust all options of numbers that could be next to this one
        for (int i = 0; i < connectedNumbers.count; i++)
        {
            NSNumber *proposedNumber = connectedNumbers[i];
            
            if (![usedNumbers member:proposedNumber])
            {   // The proposed next number in the traversal hasn't been used yet
                
                int nextNumber = [proposedNumber intValue];
                NSArray *traversedChain = [self traverseNumber:nextNumber];
                
                if (traversedChain.count > 0)
                {   // This proposed number produced a solution
                    
                    [solutionChain addObject:[NSNumber numberWithInt:number]];
                    [solutionChain addObjectsFromArray:traversedChain];
                    
                    break;
                }
            }
        }
        
        [usedNumbers removeObject:convertedNumber];
    }
    
    depthCount--;
    
    return solutionChain;
}

@end
