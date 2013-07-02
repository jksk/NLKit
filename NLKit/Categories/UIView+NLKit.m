//
//  UIView+NLKit.m
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

#import <QuartzCore/QuartzCore.h>
#import "UIView+NLKit.h"

@implementation UIView (NLKit)

- (UIImage *)snapshot
{
	UIGraphicsBeginImageContextWithOptions([self bounds].size, NO, 0.f);
	
	[[self layer] renderInContext:UIGraphicsGetCurrentContext()];
	UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}

- (void)roundCorners:(UIRectCorner)corners withRadius:(CGFloat)radius
{
	CAShapeLayer* mask = [CAShapeLayer layer];
	UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:[self bounds] byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
	
	[mask setPath:[path CGPath]];
	[[self layer] setMask:mask];
}

- (id)subviewWithClassname:(NSString *)classname
{
	for (UIView* view in [self subviews]) {
		
		if ([classname isEqualToString:NSStringFromClass([view class])])
			return view;
		
		UIView* subview = [view subviewWithClassname:classname];
		
		if (subview)
			return subview;
	}
	
	return nil;
}

- (void)addSubviewAndPreservePosition:(UIView *)view
{
	CGPoint center = [self convertPoint:[view center] fromView:[view superview]];
	
	[view setCenter:center];
	[self addSubview:view];
}

#pragma mark - Bounds

@dynamic
width,
height;

- (void)setWidth:(CGFloat)width
{
	CGRect bounds		= [self bounds];
	bounds.size.width	= width;
	
	[self setBounds:bounds];
}

- (CGFloat)width
{
	return CGRectGetWidth([self bounds]);
}

- (void)setHeight:(CGFloat)height
{
	CGRect bounds		= [self bounds];
	bounds.size.height	= height;
	
	[self setBounds:bounds];
}

- (CGFloat)height
{
	return CGRectGetHeight([self bounds]);
}

@end
