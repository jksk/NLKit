//
//  NLDotActivityIndicatorView.m
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

#import "NLDotActivityIndicatorView.h"

@implementation NLDotActivityIndicatorView

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		
		[self setIndicatorWidth:5.f];
	}
	
	return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGFloat width	 = CGRectGetWidth([self bounds]) - [self indicatorWidth] * 2;
	CGFloat height	 = CGRectGetHeight([self bounds]) - [self indicatorWidth] * 2;
	CGRect bounds	 = {[self indicatorWidth], [self indicatorWidth], width, height};
	
	CGContextSetStrokeColorWithColor(ctx, [[self indicatorColor] CGColor]);
	CGContextSetLineWidth			(ctx, 1.f);
	CGContextStrokeEllipseInRect	(ctx, bounds);
}

#pragma mark - Property Accessors

- (void)setIndicatorWidth:(CGFloat)indicatorWidth
{
	[super setIndicatorWidth:indicatorWidth];
	[super setIndicatorLength:1.f]; 
}

- (void)setIndicatorLength:(CGFloat)indicatorLength
{
}

@end
