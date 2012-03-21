//
//  NSDateFormatterTests.m
//  NLKit
//
//  Created by Jesper Skrufve on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDateFormatterTests.h"
#import "NSDateFormatter+NLKit.h"

@implementation NSDateFormatterTests

- (void)testISO8601Date
{
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	
	NSDate* date = [df dateFromISO8601String:@"2010-11-28T20:30:49Z"];
	
	NSAssert(!!date, @"");
}

@end
