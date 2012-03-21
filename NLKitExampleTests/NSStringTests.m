//
//  NSStringTests.m
//  NLKit
//
//  Created by Jesper Skrufve on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSStringTests.h"
#import "NSString+NLKit.h"

@implementation NSStringTests

- (void)testIsInteger
{
	NSAssert([@"1" isInteger], @"");
	NSAssert(![@"1.1" isInteger], @"");
	NSAssert(![@"abc" isInteger], @"");
}

@end
