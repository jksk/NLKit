//
//  NSString+NLKit.m
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

#import <QuartzCore/QuartzCore.h>
#import "NSString+NLKit.h"

@implementation NSString (NLKit)

- (BOOL)isInteger
{
	return [self isEqualToString:[NSString stringWithFormat:@"%i", [self integerValue]]];
}

- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)set
{
	NSUInteger length		= [self length];
	NSMutableString* string	= [NSMutableString stringWithCapacity:length];
	
	for (int i = 0; i < length; i++) {
		
		unichar c = [self characterAtIndex:i];
		
		if (![set characterIsMember:c])
			[string appendFormat:@"%C", c];
	}
	
	return [NSString stringWithString:string];
}

- (NSString *)reverseString
{
	NSUInteger length		= [self length];
	NSMutableString* string	= [NSMutableString stringWithCapacity:length];
	
	for (NSInteger i = length-1; i > -1; i--)
		[string appendString:[self substringWithRange:NSMakeRange(i, 1)]];
	
	return [NSString stringWithString:string];
}

- (NSString *)URLEncodedString
{
	return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes
		(NULL, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@";/?:@&=+$,", kCFStringEncodingUTF8);
}

- (NSString *)URLDecodedString
{
	return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding
		(NULL, (__bridge CFStringRef)self, NULL, kCFStringEncodingUTF8);
}

@end
