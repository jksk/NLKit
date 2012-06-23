//
//  NLFetchedResultsTableViewController.m
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

#import "NLFetchedResultsTableViewController.h"
#import "NLMacros.h"

@implementation NLFetchedResultsTableViewController

@synthesize
fetchedResultsController	= fetchedResultsController_,
tableViewUpdateAnimation	= tableViewUpdateAnimation_;

#pragma mark - Lifecycle

- (id)initWithTableViewStyle:(UITableViewStyle)style
{
	if (!(self = [super initWithTableViewStyle:style])) return nil;
	
	[self setTableViewUpdateAnimation:UITableViewRowAnimationNone];
	
	return self;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	NSError* error = nil;
	if (fetchedResultsController_ && ![fetchedResultsController_ performFetch:&error]) {
#ifdef DEBUG
		[NSException raise:@"NSFetchedResultsController fetch error" format:@"%@", error];
#endif
	}
	
	[super viewWillAppear:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	id<NSFetchedResultsSectionInfo> info = [[fetchedResultsController_ sections] objectAtIndex:section];
	return [info numberOfObjects];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	[[self tableView] beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[[self tableView] endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
	switch (type) {
			
		case NSFetchedResultsChangeInsert:
			[[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
							withRowAnimation:tableViewUpdateAnimation_];
			break;
			
		case NSFetchedResultsChangeDelete:
			[[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
							withRowAnimation:tableViewUpdateAnimation_];
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
	switch (type) {
		case NSFetchedResultsChangeInsert:
			[[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
									withRowAnimation:tableViewUpdateAnimation_];
			break;
			
		case NSFetchedResultsChangeDelete:
			[[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
									withRowAnimation:tableViewUpdateAnimation_];
			break;
			
		case NSFetchedResultsChangeMove:
			[[self tableView] moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
			break;
			
		case NSFetchedResultsChangeUpdate: {
			
			id obj = [[self tableView] cellForRowAtIndexPath:indexPath];
			NLTableViewCell* cell = _cast(NLTableViewCell, obj);
			if (cell)
				[self configureCell:cell atIndexPath:indexPath];
			
			break;
		}
	}
}

@end
