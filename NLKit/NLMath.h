//
//  NLMath.h
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

#import "NLMacros.h"
#import <stdbool.h>

extern const struct NLRandomStruct // returns random between low and high
{
	double	(*rdouble)(double low, double high);
	float	(*rfloat)(float low, float high);
	int		(*rint)(int low, int high);
} NLRandom;

extern const struct NLCompareStruct // returns boolean if x equals y (or x equals 0)
{
	bool	(*eqdouble)(double x, double y, double error);
	bool	(*eqlongdouble)(long double x, long double y, long double error);
	bool	(*eqfloat)(float x, float y, float error);
	bool	(*eq0double)(double x, double error);
	bool	(*eq0longdouble)(long double x, long double error);
	bool	(*eq0float)(float x, float error);
} NLCompare;
