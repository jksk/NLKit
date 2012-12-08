//
//  NLTableViewController.m
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

#import "NLTableViewController.h"

@interface NLTableViewController ()

@property (assign, nonatomic) UITableViewStyle	tableViewStyle;

@end

@implementation NLTableViewController

#pragma mark - Lifecycle

- (id)initWithTableViewStyle:(UITableViewStyle)style
{
	if (self = [super init]) {
		
		_tableViewStyle = style;
	}
	
	return self;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	
	if (![self isViewLoaded])
		[self setTableView:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[[self view] addSubview:[self tableView]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[_tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NLTableViewCell* cell = [NLTableViewCell cellForTableView:tableView cellInit:nil];
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(NLTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Property Accessors

- (UITableView *)tableView
{
	if (_tableView)
		return _tableView;
	
	_tableView = [[UITableView alloc] initWithFrame:[[self view] bounds] style:_tableViewStyle];
	
	[_tableView setDelegate:self];
	[_tableView setDataSource:self];
	[_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	
	return _tableView;
}

@end
