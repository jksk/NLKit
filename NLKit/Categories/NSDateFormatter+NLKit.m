//
//  NSDateFormatter+NLKit.m
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

#import "NSDateFormatter+NLKit.h"

@implementation NSDateFormatter (NLKit)

- (NSDate *)dateFromISO8601String:(NSString *)string
{
	if (![string length])
		return nil;
	
	if ([string hasSuffix:@"Z"])
		string = [string stringByReplacingCharactersInRange:NSMakeRange([string length]-1, 1) withString:@"-0000"];
	
	[self setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	[self setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
	
	return [self dateFromString:string];
}

@end
