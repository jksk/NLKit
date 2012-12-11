//
//  NLCollectionViewController.m
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

#import "NLCollectionViewController.h"

@interface NLCollectionViewController ()

@property (strong, nonatomic) UICollectionViewLayout*	collectionViewLayout;
@property (strong, nonatomic) NSMutableArray*			sectionChanges;
@property (strong, nonatomic) NSMutableArray*			objectChanges;

@end

@implementation NLCollectionViewController

#pragma mark - Lifecycle

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
	if (self = [super init]) {
		
		[self setCollectionViewLayout:layout];
	}
	
	return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[self view] addSubview:[self collectionView]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Properties

- (UICollectionView *)collectionView
{
	if (_collectionView)
		return _collectionView;
	
	UICollectionViewLayout* layout = _collectionViewLayout;
	
	if (!layout) {
		
		layout = [[UICollectionViewFlowLayout alloc] init];
		
		[(UICollectionViewFlowLayout *)layout setItemSize:CGSizeMake(100.f, 120.f)];
		[(UICollectionViewFlowLayout *)layout setMinimumInteritemSpacing:5.f];
		[(UICollectionViewFlowLayout *)layout setMinimumLineSpacing:5.f];
		[(UICollectionViewFlowLayout *)layout setSectionInset:UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f)];
	}
	
	_collectionView	= [[UICollectionView alloc] initWithFrame:[[self view] bounds] collectionViewLayout:layout];
	
	[_collectionView setDelegate:self];
	[_collectionView setDataSource:self];
	[_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	[_collectionView setBackgroundColor:[UIColor whiteColor]];
	
	return _collectionView;
}

@end
