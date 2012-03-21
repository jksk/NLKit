//
//  NLMacrosTests.m
//  NLKit
//
//  Created by Jesper Skrufve on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NLMacrosTests.h"
#import "NLMacros.h"

@implementation NLMacrosTests

- (void)testMIN3
{
	NSAssert(MIN3(10, 1, 2) == 1, @"");
	NSAssert(MIN3(7, -3, 2) == -3, @"");
	NSAssert(MIN3(2, 1, 0) == 0, @"");
	NSAssert(MIN3(3.3, 1.0, 2.22) == 1.0, @"");
}

- (void)testMAX3
{
	NSAssert(MAX3(10, 1, 2) == 10, @"");
	NSAssert(MAX3(7, -3, 2) == 7, @"");
	NSAssert(MAX3(2, 1, 0) == 2, @"");
	NSAssert(MAX3(3.3, 1.0, 2.22) == 3.3, @"");
}

- (void)testMID
{
	NSAssert(MID(1, 2, 10) == 2, @"");
	NSAssert(MID(-3, 2, 7) == 2, @"");
	NSAssert(MID(0, 1, 2) == 1, @"");
	NSAssert(MID(1.0, 2.22, 3.3) == 2.22, @"");
}

@end
