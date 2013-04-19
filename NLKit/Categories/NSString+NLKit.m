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
	return [self rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

- (NSArray *)componentsSeparatedAtEachCharacter
{
	NSUInteger length		= [self length];
	NSMutableArray* array	= [NSMutableArray arrayWithCapacity:length];

	[self enumerateSubstringsInRange:NSMakeRange(0, length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

		[array addObject:substring];
	}];

	return [NSArray arrayWithArray:array];
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

- (NSString *)firstLetterCapitalizedString
{
	if ([self length] < 2)
		return [self uppercaseString];

	NSString* first = [self substringToIndex:1];
	NSString* rest	= [self substringFromIndex:1];

	return [NSString stringWithFormat:@"%@%@", [first uppercaseString], rest];
}

- (NSString *)stringRepeated:(NSUInteger)repeatCount
{
	if (!repeatCount)
		return nil;

	if (repeatCount == 1)
		return self;

	NSMutableString* repeatedString = [NSMutableString string];

	for (NSUInteger i = 0; i < repeatCount; i++)
		[repeatedString appendString:self];

	return [NSString stringWithString:repeatedString];
}

- (NSString *)normalizedString
{
	return [[self decomposedStringWithCanonicalMapping] lowercaseString];
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

- (NSDictionary *)parametersFromURLString
{
	NSArray* pairs				= [self componentsSeparatedByString:@"&"];
	NSMutableDictionary* params	= [NSMutableDictionary dictionary];

	for (NSString* pair in pairs) {

		NSArray* item	= [pair componentsSeparatedByString:@"="];
		NSString* key	= [item count] > 0 ? item[0] : nil;
		NSString* value	= [item count] > 1 ? item[1] : nil;

		if ([key length] && [value length])
			[params setObject:[value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:key];
	}

	return [NSDictionary dictionaryWithDictionary:params];
}

- (NSString *)substringFromString:(NSString *)string
{
	return [self substringFromString:string searchFromEnd:NO];
}

- (NSString *)substringToString:(NSString *)string
{
	return [self substringToString:string searchFromEnd:NO];
}

- (NSString *)substringBetweenString:(NSString *)startString andString:(NSString *)endString
{
	return [self substringBetweenString:startString andString:endString searchFromEnd:NO];
}

- (NSString *)substringFromString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd
{
	return [self substringBetweenString:string andString:@"" searchFromEnd:searchFromEnd];
}

- (NSString *)substringToString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd
{
	return [self substringBetweenString:@"" andString:string searchFromEnd:searchFromEnd];
}

- (NSString *)substringBetweenString:(NSString *)startString andString:(NSString *)endString searchFromEnd:(BOOL)searchFromEnd
{
	NSUInteger len = [self length];

	if (!len)
		return self;

	NSStringCompareOptions options	= searchFromEnd ? NSBackwardsSearch : 0;
	NSRange start					= [self rangeOfString:startString options:options];

	if (!start.length)
		start = NSMakeRange(0, 0);

	NSUInteger startEnd	= start.location + start.length;
	NSRange end			= [self rangeOfString:endString options:options range:NSMakeRange(startEnd, len-startEnd)];

	if (!end.length)
		end = NSMakeRange(len, 0);

	NSRange range = NSMakeRange(startEnd, end.location-startEnd);

	return [self substringWithRange:range];
}

@end
