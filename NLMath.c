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
	return (int)round(((double)arc4random() / ARC4RANDOM_MAX) * (high - low) + low);
}

const struct NLRandomStruct NLRandom = {
	.rdouble	= a4double,
	.rfloat		= a4float,
	.rint		= a4int,
};

////////////////////////////////////////////////////////////////////////////////////////////////
//	floating point comparisons
////////////////////////////////////////////////////////////////////////////////////////////////

static bool equald(double x, double y, double e)
{
	return fabs(x - y) < e * DBL_EPSILON * (fabs(x) + fabs(y));
}

static bool equalld(long double x, long double y, long double e)
{
	return fabsl(x - y) < e * LDBL_EPSILON * (fabsl(x) + fabsl(y));
}

static bool equalf(float x, float y, float e)
{
	return fabsf(x - y) < e * FLT_EPSILON * (fabsf(x) + fabsf(y));
}

static bool	equal0d(double x, double e)
{
	return fabs(x) < DBL_EPSILON * e;
}

static bool equal0ld(long double x, long double e)
{
	return fabsl(x) < LDBL_EPSILON * e;
}

static bool equal0f(float x, float e)
{
	return fabsf(x) < FLT_EPSILON * e;
}

const struct NLCompareStruct NLCompare = {
	.eqdouble		= equald,
	.eqlongdouble	= equalld,
	.eqfloat		= equalf,
	.eq0double		= equal0d,
	.eq0longdouble	= equal0ld,
	.eq0float		= equal0f
};
