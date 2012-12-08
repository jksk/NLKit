//
//  NLFetchedResultsCollectionViewController.m
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

#import "NLFetchedResultsCollectionViewController.h"

@interface NLFetchedResultsCollectionViewController ()

@property (strong, nonatomic) NSMutableArray*	sectionChanges;
@property (strong, nonatomic) NSMutableArray*	objectChanges;

@end

@implementation NLFetchedResultsCollectionViewController

#pragma mark - Lifecycle

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
	if (self = [super initWithCollectionViewLayout:layout]) {
		
	}
	
	return self;
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	NSFetchedResultsController* frc = [self fetchedResultsController];
	
	if (frc) {
		
		if (![frc delegate])
			[frc setDelegate:self];
		
		NSError* error = nil;
		
		if (![frc performFetch:&error]) {
#ifdef DEBUG
			[NSException raise:@"NSFetchedResultsController fetch error" format:@"%@", error];
#endif
		}
	}
	
	[super viewWillAppear:animated];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return MAX([[[self fetchedResultsController] sections] count], 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	id<NSFetchedResultsSectionInfo> info = [[self fetchedResultsController] sections][section];
	
	return [info numberOfObjects];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	UICollectionView* collectionView = [self collectionView];
	
	[collectionView performBatchUpdates:^{
		
		for (NSArray* item in _sectionChanges) {
			
			NSFetchedResultsChangeType type = [item[0] unsignedIntegerValue];
			
			switch (type) {
				case NSFetchedResultsChangeInsert:
					
					[collectionView insertSections:item[1]];
					
					break;
				case NSFetchedResultsChangeDelete:
					
					[collectionView deleteSections:item[1]];
					
					break;
			}
		}
		
		for (NSArray* item in _objectChanges) {
			
			NSFetchedResultsChangeType type = [item[0] unsignedIntegerValue];
			
			switch (type) {
				case NSFetchedResultsChangeInsert:
					
					[collectionView insertItemsAtIndexPaths:@[item[1]]];
					
					break;
				case NSFetchedResultsChangeDelete:
					
					[collectionView deleteItemsAtIndexPaths:@[item[1]]];
					
					break;
				case NSFetchedResultsChangeMove: {
					
					NSArray* paths = item[1];
					[collectionView moveItemAtIndexPath:paths[0] toIndexPath:paths[1]];
					
					break;
				}
			}
		}
		
		[self setSectionChanges:nil];
		[self setObjectChanges:nil];
		
	} completion:^(BOOL finished) {
		
	}];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
	[[self sectionChanges] addObject:@[@(type), [NSIndexSet indexSetWithIndex:sectionIndex]]];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
	switch (type) {
		case NSFetchedResultsChangeInsert:
			
			[[self objectChanges] addObject:@[@(type), newIndexPath]];
			
			break;
			
		case NSFetchedResultsChangeDelete:
			
			[[self objectChanges] addObject:@[@(type), indexPath]];
			
			break;
			
		case NSFetchedResultsChangeMove:
			
			[[self objectChanges] addObject:@[@(type), @[indexPath, newIndexPath]]];
			
			break;
			
		case NSFetchedResultsChangeUpdate: {
			
			id cell = [[self collectionView] cellForItemAtIndexPath:indexPath];
			
			if (cell)
				[self configureCell:cell atIndexPath:indexPath];
			
			break;
		}
	}
}

#pragma mark - Properties

- (NSMutableArray *)sectionChanges
{
	if (_sectionChanges)
		return _sectionChanges;
	
	_sectionChanges = [NSMutableArray array];
	
	return _sectionChanges;
}

- (NSMutableArray *)objectChanges
{
	if (_objectChanges)
		return _objectChanges;
	
	_objectChanges = [NSMutableArray array];
	
	return _objectChanges;
}

@end
