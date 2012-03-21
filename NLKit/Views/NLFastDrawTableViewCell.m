//
//  NLFastDrawTableViewCell.m
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

#import "NLFastDrawTableViewCell.h"

@interface NLFastDrawContentView : UIView

- (id)initWithFrame:(CGRect)frame isHighlighted:(BOOL)highlighted;

@end

#pragma mark -
@implementation NLFastDrawContentView
{
	BOOL	highlighted_;
}

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame isHighlighted:(BOOL)highlighted
{
	if (!(self = [super initWithFrame:frame])) return nil;
	
	[self setContentMode:UIViewContentModeRedraw];
	[self setOpaque:YES];
	
	highlighted_ = highlighted;
	
	return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	[(NLFastDrawTableViewCell *)[self superview] drawContentInRect:rect highlighted:highlighted_];
}

@end

#pragma mark -
@interface NLFastDrawTableViewCell ()

@property (strong, nonatomic) NLFastDrawContentView*	fastContentView;
@property (strong, nonatomic) NLFastDrawContentView*	fastSelectedContentView;

@end

#pragma mark -
@implementation NLFastDrawTableViewCell

@synthesize
fastContentView			= contentView_,
fastSelectedContentView	= selectedContentView_;

#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size
{
	if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size])) return nil;
	
	[self setBackgroundView:[self fastContentView]];
	[self setSelectedBackgroundView:[self fastSelectedContentView]];
	
	return self;
}

#pragma mark - Public

- (void)drawContentInRect:(CGRect)rect highlighted:(BOOL)highlighted
{
}

#pragma mark - Drawing

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[contentView_ setNeedsDisplay];
	
	if ([self isSelected] || [self isHighlighted])
		[selectedContentView_ setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)rect
{
	[super setNeedsDisplayInRect:rect];
	[contentView_ setNeedsDisplayInRect:rect];
	
	if ([self isSelected] || [self isHighlighted])
		[selectedContentView_ setNeedsDisplayInRect:rect];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	UIView* view = [self contentView];
	
	[view setHidden:YES];
	[view removeFromSuperview];
}

#pragma mark - Property Accessors

- (void)setSelected:(BOOL)selected
{
	[self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	if (selected && ![self isSelected])
		[selectedContentView_ setNeedsDisplay];
	
	if (!selected && [self isSelected])
		[contentView_ setNeedsDisplay];
	
	[super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted
{
	[self setHighlighted:highlighted animated:NO];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	if (highlighted && ![self isHighlighted])
		[selectedContentView_ setNeedsDisplay];
	
	if (!highlighted && [self isHighlighted])
		[contentView_ setNeedsDisplay];
	
	[super setHighlighted:highlighted animated:animated];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	
	CGRect bounds = [self bounds];
	
	[contentView_ setBounds:bounds];
	[selectedContentView_ setBounds:bounds];
}

- (NLFastDrawContentView *)fastContentView
{
	if (contentView_) return contentView_;
	
	contentView_ = [[NLFastDrawContentView alloc] initWithFrame:CGRectZero isHighlighted:NO];
	
	return contentView_;
}

- (NLFastDrawContentView *)fastSelectedContentView
{
	if (selectedContentView_) return selectedContentView_;
	
	selectedContentView_ = [[NLFastDrawContentView alloc] initWithFrame:CGRectZero isHighlighted:YES];
	
	return selectedContentView_;
}

@end
