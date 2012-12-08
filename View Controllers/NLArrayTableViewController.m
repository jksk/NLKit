//
//  NLArrayTableViewController.m
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

#import "NLArrayTableViewController.h"

@interface NLArrayTableViewController ()

@property (assign, nonatomic) BOOL	nestedArrays;

@end

@implementation NLArrayTableViewController

#pragma mark - Lifecycle

- (id)initWithTableViewStyle:(UITableViewStyle)style
{
	if (self = [super initWithTableViewStyle:style]) {
		
	}
	
	return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (![[self tableData] count])
		return 0;
	
	_nestedArrays = [[[self tableData] objectAtIndex:0] isKindOfClass:[NSArray class]];
	return _nestedArrays ? [[self tableData] count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _nestedArrays ? [[[self tableData] objectAtIndex:section] count] : [[self tableData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NLTableViewCell* cell = [NLTableViewCell cellForTableView:tableView cellInit:nil];
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(NLTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	id object;
	NSString* text;
	
	if (_nestedArrays)
		object = [[(NSArray *)[self tableData] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
	else
		object = [[self tableData] objectAtIndex:[indexPath row]];
	
	if ([object isKindOfClass:[NSString class]])
		text = object;
	else if ([object respondsToSelector:@selector(stringValue)])
		text = [object stringValue];
	else
		text = [object description];
	
	[[cell textLabel] setText:text];
}

@end
