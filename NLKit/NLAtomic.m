//
//  NLAtomic.c
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

#import <libkern/OSAtomic.h>
#import "NLAtomic.h"

static int32_t _inc32(int32_t counter)
{
	return OSAtomicIncrement32(&counter);
}

static int64_t _inc64(int64_t counter)
{
	return OSAtomicIncrement64(&counter);
}

static int32_t _add32(int32_t counter, int32_t add)
{
	return OSAtomicAdd32(add, &counter);
}

static int64_t _add64(int64_t counter, int64_t add)
{
	return OSAtomicAdd64(add, &counter);
}

const struct NLAtomicStruct NLAtomic =
{
	.inc32	= _inc32,
	.inc64	= _inc64,
	.add32	= _add32,
	.add64	= _add64
};
