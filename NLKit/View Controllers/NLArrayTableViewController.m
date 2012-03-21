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

@implementation NLArrayTableViewController
{
	BOOL	nestedArrays_;
}

@synthesize
tableData	= tableData_;

#pragma mark - Lifecycle

- (id)initWithTableViewStyle:(UITableViewStyle)style
{
	if (!(self = [super initWithTableViewStyle:style])) return nil;
	
	return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (![[self tableData] count])
		return 0;
	
	nestedArrays_ = [[[self tableData] objectAtIndex:0] isKindOfClass:[NSArray class]];
	return nestedArrays_ ? [[self tableData] count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return nestedArrays_ ? [[[self tableData] objectAtIndex:section] count] : [[self tableData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NLTableViewCell* cell = [NLTableViewCell cellForTableView:tableView cellInit:nil];
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(NLTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	id obj = (nestedArrays_ ?
			  [[[self tableData] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] :
			  [[self tableData] objectAtIndex:[indexPath row]]);
	
	NSString* text;
	
	if ([obj isKindOfClass:[NSString class]])
		text = obj;
	else if ([obj respondsToSelector:@selector(stringValue)])
		text = [obj stringValue];
	else
		text = [obj description];
	
	[[cell textLabel] setText:text];
}

@end
