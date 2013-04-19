//
//  NSOperationQueue+NLKit.h
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

#import "NSOperationQueue+NLKit.h"

@implementation NSOperationQueue (NLKit2)

+ (instancetype)sharedQueue
{
	static NSOperationQueue* instance	= nil;
	static dispatch_once_t token		= 0;

	dispatch_once(&token, ^{

		instance = [[self alloc] init];
		[instance setMaxConcurrentOperationCount:4];
	});

	return instance;
}

- (void)addFIFOOperation:(NSOperation *)fifoOperation
{
	[self addOperation:fifoOperation];
}

- (void)addLIFOOperation:(NSOperation *)lifoOperation
{
	BOOL suspended		= [self isSuspended];
	NSArray* operations = [self operations];

	[self setSuspended:YES];

	for (NSOperation* operation in operations) {

		if (![operation isExecuting]) {

			[operation addDependency:lifoOperation];
			break;
		}
	}

	[self addOperation:lifoOperation];
	[self setSuspended:suspended];
}

@end

