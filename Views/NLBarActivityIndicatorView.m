//
//  NLBarActivityIndicatorView.m
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

#import "NLBarActivityIndicatorView.h"
#import "NLActivityIndicatorView.h"
#import "NLMacros.h"

@implementation NLBarActivityIndicatorView

@dynamic
animating,
indicatorColor,
indicatorWidth,
indicatorStep,
indicatorLength;

#pragma mark - Lifecycle

- (id)init
{
	CGRect frame = {0.f, 0.f, 20.f, 20.f};
	NLActivityIndicatorView* indicator = [[NLActivityIndicatorView alloc] initWithFrame:frame];
	
	if (self = [super initWithCustomView:indicator]) {
		
	}
	
	return self;
}

#pragma mark - Property Accessors

- (void)setAnimating:(BOOL)animating
{
	[(NLActivityIndicatorView *)[self customView] setAnimating:animating];
}

- (BOOL)isAnimating
{
	return [(NLActivityIndicatorView *)[self customView] isAnimating];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
	[(NLActivityIndicatorView *)[self customView] setIndicatorColor:indicatorColor];
}

- (UIColor *)indicatorColor
{
	return [(NLActivityIndicatorView *)[self customView] indicatorColor];
}

- (void)setIndicatorWidth:(CGFloat)indicatorWidth
{
	[(NLActivityIndicatorView *)[self customView] setIndicatorWidth:indicatorWidth];
}

- (CGFloat)indicatorWidth
{
	return [(NLActivityIndicatorView *)[self customView] indicatorWidth];
}

- (void)setIndicatorStep:(CGFloat)indicatorStep
{
	[(NLActivityIndicatorView *)[self customView] setIndicatorStep:indicatorStep];
}

- (CGFloat)indicatorStep
{
	return [(NLActivityIndicatorView *)[self customView] indicatorStep];
}

- (void)setIndicatorLength:(CGFloat)indicatorLength
{
	[(NLActivityIndicatorView *)[self customView] setIndicatorLength:indicatorLength];
}

- (CGFloat)indicatorLength
{
	return [(NLActivityIndicatorView *)[self customView] indicatorLength];
}

@end
