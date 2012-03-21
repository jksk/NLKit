//
//  NSUserDefaults+NLKit.m
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

#import "NSUserDefaults+NLKit.h"

@implementation NSUserDefaults (NLKit)

+ (BOOL)synchronize
{
	return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

+ (void)setDouble:(double)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
}

+ (void)setFloat:(float)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (void)setLong:(long)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLong:value] forKey:key];
}

+ (void)setLongLong:(long long)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:value] forKey:key];
}

+ (void)setNilValueForKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setNilValueForKey:key];
}

+ (void)setObject:(id)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setURL:url forKey:key];
}

+ (BOOL)boolForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (double)doubleForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (float)floatForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (NSInteger)integerForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (long)longForKey:(NSString *)key
{
	return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longValue];
}

+ (long long)longLongForKey:(NSString *)key
{
	return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longLongValue];
}

+ (id)objectForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSURL *)URLForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] URLForKey:key];
}

#pragma mark -

+ (void)setCGRect:(CGRect)rect forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGRect(rect) forKey:key];
}

+ (void)setCGSize:(CGSize)size forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGSize(size) forKey:key];
}

+ (void)setCGPoint:(CGPoint)point forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(point) forKey:key];
}

+ (void)setNSRange:(NSRange)range forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromRange(range) forKey:key];
}

+ (CGRect)rectForKey:(NSString *)key
{
	return CGRectFromString([self objectForKey:key]);
}

+ (CGSize)sizeForKey:(NSString *)key
{
	return CGSizeFromString([NSUserDefaults objectForKey:key]);
}

+ (CGPoint)pointForKey:(NSString *)key
{
	return CGPointFromString([NSUserDefaults objectForKey:key]);
}

+ (NSRange)rangeForKey:(NSString *)key
{
	return NSRangeFromString([NSUserDefaults objectForKey:key]);
}

@end
