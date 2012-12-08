//
//  UITableView+NLKit.m
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

#import "UITableView+NLKit.h"

@implementation UITableView (NLKit)

- (void)reloadDataKeepSelection
{
	NSArray* indexPaths = nil;
	
	if ([self respondsToSelector:@selector(indexPathsForSelectedRows)])
		indexPaths = [self performSelector:@selector(indexPathsForSelectedRows)];
	else
		indexPaths = [NSArray arrayWithObject:[self indexPathForSelectedRow]];
	
	[self reloadData];
	[self selectRowsAtIndexPaths:indexPaths animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation
{
	[self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfSections])] withRowAnimation:animation];
}

- (void)selectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
	for (NSIndexPath* indexPath in indexPaths)
		[self selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
}

- (void)selectAllRowsAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
	for (NSUInteger i = 0; i < [self numberOfSections]; i++)
		for (NSUInteger j = 0; j < [self numberOfRowsInSection:i]; j++)
			[self selectRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i] animated:animated scrollPosition:scrollPosition];
}

- (CGSize)cellSize
{
	return [self cellSizeForIndexPath:nil];
}

- (CGSize)cellSizeForIndexPath:(NSIndexPath *)indexPath
{
	CGFloat modifier = [self style] == UITableViewStylePlain ? 0.f : 20.f;
	CGFloat height;
	
	if (indexPath && [[self delegate] respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
		height = [[self delegate] tableView:self heightForRowAtIndexPath:indexPath];
	else
		height = [self rowHeight];
	
	return CGSizeMake(CGRectGetWidth([self bounds]) - modifier, height);
}

@end
