//
//  NSMutableArray+NLKit.m
//  PhotoPuzzle
//
//  Created by Jesper on 1/5/13.
//  Copyright (c) 2013 Neology. All rights reserved.
//

#import "NSMutableArray+NLKit.h"
#import "../../NLMath.h"

@implementation NSMutableArray (NLKit)

- (void)randomize
{
	for (NSInteger i = [self count]-1; i > 1; i--)
		[self exchangeObjectAtIndex:i withObjectAtIndex:NLRandom.rint(0, i)];
}

@end
