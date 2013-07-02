//
//  NSArray+NLKit.m
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

#import "NSArray+NLKit.h"
#import "NLMath.h"

@implementation NSArray (NLKit)

- (NSUInteger)numberOfObjectsPassingTest:(BOOL (^)(id obj))predicate
{
	__block NSUInteger count = 0;
	
	for (id obj in self)
		if (predicate(obj))
			count++;
	
	return count;
}

- (id)objectPassingTest:(BOOL (^)(id))predicate
{
	for (id object in self) {
		if (predicate(object))
			return object;
	}
	
	return nil;
}

- (id)randomObject
{
	NSUInteger count = [self count];
	
	if (!count)
		return nil;
	
	return self[NLRandom.rint(0, count-1)];
}

- (NSString *)stringWithSeparator:(NSString *)separator
{
	NSMutableString* string = [NSMutableString string];
	
	for (id obj in self) {
		
		if ([string length])
			[string appendString:separator];
		
		if ([obj isKindOfClass:[NSString class]])
			[string appendString:obj];
		else if ([obj respondsToSelector:@selector(stringValue)])
			[string appendString:[obj stringValue]];
		else
			[string appendString:[obj description]];
	}
	
	return [NSString stringWithString:string];
}

- (NSArray *)mapToArray:(id (^)(id))block
{
	NSMutableArray* array = [NSMutableArray array];
	
	for (id obj in self) {
		
		id mapped = block(obj);
		
		if (mapped)
			[array addObject:mapped];
	}
	
	return [NSArray	arrayWithArray:array];
}

- (NSMutableArray *)mapToMutableArray:(id (^)(id))block
{
	NSMutableArray* array = [NSMutableArray array];
	
	for (id obj in self) {
		
		id mapped = block(obj);
		
		if (mapped)
			[array addObject:mapped];
	}
	
	return array;
}

- (NSSet *)mapToSet:(id (^)(id))block
{
	NSMutableSet* set = [NSMutableSet set];
	
	for (id obj in self) {
		
		id mapped = block(obj);
		
		if (mapped)
			[set addObject:mapped];
	}
	
	return [NSSet setWithSet:set];
}

- (NSMutableSet *)mapToMutableSet:(id (^)(id))block
{
	NSMutableSet* set = [NSMutableSet set];
	
	for (id obj in self) {
		
		id mapped = block(obj);
		
		if (mapped)
			[set addObject:mapped];
	}
	
	return set;
}

- (NSSet *)set
{
	return [NSSet setWithArray:self];
}

- (NSMutableSet *)mutableSet
{
	return [NSMutableSet setWithArray:self];
}

- (NSOrderedSet *)orderedSet
{
	return [NSOrderedSet orderedSetWithArray:self];
}

- (NSMutableOrderedSet *)mutableOrderedSet
{
	return [NSMutableOrderedSet orderedSetWithArray:self];
}

- (NSArray *)subarrayFromIndex:(NSUInteger)index
{
	return [self subarrayWithRange:NSMakeRange(index, [self count] - index)];
}

- (NSArray *)subarrayToIndex:(NSUInteger)index
{
	return [self subarrayWithRange:NSMakeRange(0, index + 1)];
}

@end
