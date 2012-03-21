//
//  NLMathTests.m
//  NLKit
//
//  Created by Jesper Skrufve on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NLMathTests.h"
#import "NLMath.h"

@implementation NLMathTests
{
	int randomTestCount_;
}

- (void)setUp
{
	[super setUp];
	
	randomTestCount_ = 10000;
}

- (void)testRandomInt
{
	static int high = 3000;
	static int low = 2000;
	
	for (int i = 0; i < randomTestCount_; i++) {
		
		int n = NLRandom.rint(low, high);
		NSAssert(n >= low && n <= high, @"%i should be lower than %i and higher than %i", n, high, low);
	}
}

- (void)testRandomFloat
{
	static float high = 3000;
	static float low = 2000;
	
	for (int i = 0; i < randomTestCount_; i++) {
		
		float n = NLRandom.rfloat(low, high);
		NSAssert(n >= low && n <= high, @"%f should be lower than %f and higher than %f", n, high, low);
	}
}

- (void)testRandomDouble
{
	static double high = 3000;
	static double low = 2000;
	
	for (int i = 0; i < randomTestCount_; i++) {
		
		double n = NLRandom.rdouble(low, high);
		NSAssert(n >= low && n <= high, @"%f should be lower than %f and higher than %f", n, high, low);
	}
}

- (void)testCompare
{
	NSAssert(NLCompare.eq0float(0.f), @"");
	NSAssert(NLCompare.eq0double(0.0), @"");
	NSAssert(NLCompare.eq0longdouble(0.0), @"");
	NSAssert(NLCompare.eqfloat(7.7f, 7.7f), @"");
	NSAssert(NLCompare.eqdouble(7.7, 7.7), @"");
	NSAssert(NLCompare.eqlongdouble(7.7, 7.7), @"");
	
	NSAssert(!NLCompare.eq0float(7.7f), @"");
	NSAssert(!NLCompare.eq0double(7.7), @"");
	NSAssert(!NLCompare.eq0longdouble(7.7), @"");
	NSAssert(!NLCompare.eqfloat(3.3f, 7.7f), @"");
	NSAssert(!NLCompare.eqdouble(3.3, 7.7), @"");
	NSAssert(!NLCompare.eqlongdouble(3.3, 7.7), @"");
}

- (void)testRoundFloat
{
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 0), 1.f), @"0 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 1), 1.1f), @"1 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 2), 1.12f), @"2 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 3), 1.123f), @"3 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 4), 1.1235f), @"4 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 5), 1.12346f), @"5 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 6), 1.123457f), @"6 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 7), 1.1234568f), @"7 digits failed");
	NSAssert(NLCompare.eqfloat(NLRound.rfloat(1.123456789f, 8), 1.12345679f), @"8 digits failed");
}

- (void)testRoundDouble
{
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 0), 1.0), @"0 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 1), 1.1), @"1 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 2), 1.12), @"2 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 3), 1.123), @"3 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 4), 1.1235), @"4 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 5), 1.12346), @"5 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 6), 1.123457), @"6 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 7), 1.1234568), @"7 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 8), 1.12345679), @"8 digits failed");
	NSAssert(NLCompare.eqdouble(NLRound.rdouble(1.123456789, 9), 1.123456789), @"9 digits failed");
}

- (void)testRoundLongDouble
{
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 0), 1.0l), @"0 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 1), 1.1l), @"1 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 2), 1.12l), @"2 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 3), 1.123l), @"3 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 4), 1.1235l), @"4 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 5), 1.12346l), @"5 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 6), 1.123457l), @"6 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 7), 1.1234568l), @"7 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 8), 1.12345679l), @"8 digits failed");
	NSAssert(NLCompare.eqlongdouble(NLRound.rlongdouble(1.123456789l, 9), 1.123456789l), @"9 digits failed");
}

@end
