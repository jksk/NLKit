//
//  NLTableViewCell.m
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

#import "NLTableViewCell.h"
#import "NLMacros.h"
#import "UITableView+NLKit.h"

@interface NLTableViewCell ()

+ (id)cellWithSize:(CGSize)size forTableView:(UITableView *)tableView cellInit:(void (^)(id))block;

@end

#pragma mark -
@implementation NLTableViewCell

#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size
{
	if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
	
	[self setFrame:(CGRect){0.f, 0.f, size}];
	
	return self;
}

+ (id)cellForTableView:(UITableView *)tableView cellInit:(void (^)(id))block
{
	return [self cellWithSize:[tableView cellSize] forTableView:tableView cellInit:block];
}

+ (id)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath cellInit:(void (^)(id))block
{
	return [self cellWithSize:[tableView cellSizeForIndexPath:indexPath] forTableView:tableView cellInit:block];
}

#pragma mark - Helpers

+ (id)cellWithSize:(CGSize)size forTableView:(UITableView *)tableView cellInit:(void (^)(id))block
{
	NSString* reuseIdentifier = _str(@"%@_%.0f", NSStringFromClass([self class]), size.height);
	id cell					  = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	
	if (!cell) {
		
		cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier size:size];
		
		if (block)
			block(cell);
	}
	
	return cell;
}

@end
