//
//  SquaresStringStore.h
//  SquaresString
//
//  Created by Bobby Jap on 1/24/15.
//  Copyright (c) 2015 Bobby Jap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquaresStringStore : NSObject

- (id)initWithEnd:(int)theEnd;
- (id)initWithStart:(int)theStart andEnd:(int)theEnd; // Designated initializer

- (NSArray *)findASolution;

@end