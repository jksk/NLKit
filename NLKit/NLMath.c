//
//  NLMath.c
//
//  Created by Jesper Skrufve <jesper@neolo.gy>
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//  

#import "NLMath.h"
#import <stdio.h>
#import <stdlib.h>
#import <math.h>
#import <float.h>

////////////////////////////////////////////////////////////////////////////////////////////////
//	arc4random wrappers
////////////////////////////////////////////////////////////////////////////////////////////////
static double a4double(double low, double high)
{
	return ((double)arc4random() / (double)ARC4RANDOM_MAX) * (high - low) + low;
}

static float a4float(float low, float high)
{
	return ((float)arc4random() / (float)ARC4RANDOM_MAX) * (high - low) + low;
}

static int a4int(int low, int high)
{
	return (arc4random() / ARC4RANDOM_MAX) * (high - low) + low;
}

const struct NLRandomStruct NLRandom = {
	.rdouble	= a4double,
	.rfloat		= a4float,
	.rint		= a4int,
};

////////////////////////////////////////////////////////////////////////////////////////////////
//	floating point comparisons
////////////////////////////////////////////////////////////////////////////////////////////////
static bool equald(double x, double y)
{
	return fabs((x) - (y)) < DBL_EPSILON;
}

static bool equalld(long double x, long double y)
{
	return fabsl((x) - (y)) < LDBL_EPSILON;
}

static bool equalf(float x, float y)
{
	return fabsf((x) - (y)) < FLT_EPSILON;
}

static bool	equal0d(double x)
{
	return fabs(x) < DBL_EPSILON;
}

static bool	equal0ld(long double x)
{
	return fabsl(x) < LDBL_EPSILON;
}

static bool	equal0f(float x)
{
	return fabsf(x) < FLT_EPSILON;
}

const struct NLCompareStruct NLCompare = {
	.eqdouble		= equald,
	.eqlongdouble	= equalld,
	.eqfloat		= equalf,
	.eq0double		= equal0d,
	.eq0longdouble	= equal0ld,
	.eq0float		= equal0f
};

////////////////////////////////////////////////////////////////////////////////////////////////
//	floating point rounding
////////////////////////////////////////////////////////////////////////////////////////////////
static float dproundf(float x, int n)
{
	if (n < 0) return x;
	if (n < 1) return roundf(x);
	
	int y = (int)floorf(powf(10.f, (float)n));
	return floorf(x * y + 0.5f) / y;
}

static double dproundd(double x, int n)
{
	if (n < 0) return x;
	if (n < 1) return round(x);
	
	int y = (int)floorf(powf(10.f, (float)n));
	return floor(x * y + 0.5) / y;
}

static long double dprounddl(long double x, int n)
{
	if (n < 0) return x;
	if (n < 1) return roundl(x);
	
	int y = (int)floorl(powf(10.f, (float)n));
	return floorl(x * y + 0.5) / y;
}

const struct NLRoundStruct NLRound = {
	.rfloat			= dproundf,
	.rdouble		= dproundd,
	.rlongdouble	= dprounddl
};
