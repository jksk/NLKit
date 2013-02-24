//
//  NSNumber+NLKit.m
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

#import "NSNumber+NLKit.h"
#import "NLMath.h"

@implementation NSNumber (NLKit)

+ (NSNumber *)randomZeroToOne
{
	return [NSNumber numberWithDouble:NLRandom.rdouble(0.0, 1.0)];
}

+ (NSNumber *)sumNumbers:(id<NSFastEnumeration>)numbers
{
	double sum = 0.;

	for (NSNumber* number in numbers)
		sum += [number doubleValue];

	return @(sum);
}

+ (NSNumber *)averageNumbers:(id<NSFastEnumeration>)numbers
{
	double sum			= 0.;
	NSUInteger count	= 0;

	for (NSNumber* number in numbers) {

		count++;
		sum += [number doubleValue];
	}

	return @(sum / count);
}

@end
