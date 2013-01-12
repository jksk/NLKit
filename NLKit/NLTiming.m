//
//  NLTiming.m
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

#import <mach/mach_time.h>
#import "NLTiming.h"
#import "NLMacros.h"

static uint64_t UNUSED_VARIABLE _nltlog_time = 0;

static double machTimeInterval(uint64_t start, uint64_t end)
{
	mach_timebase_info_data_t info;
	
	if (mach_timebase_info(&info) != KERN_SUCCESS)
		return -1.f;
	
	uint64_t interval = (end - start) * info.numer / info.denom;
	return (double)interval / NSEC_PER_SEC;
}

double tlogBlock(void (^block)(void))
{
	uint64_t start =  mach_absolute_time();
	block();
	uint64_t end = mach_absolute_time();
	
	return machTimeInterval(start, end);
}

void tlogReset(void)
{
	_nltlog_time = mach_absolute_time();
	dlog(@"tlogReset");
}

void tlog(void)
{
	flog(machTimeInterval(_nltlog_time, mach_absolute_time()));
	_nltlog_time = mach_absolute_time();
}
