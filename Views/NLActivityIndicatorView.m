//
//  NLActivityIndicatorView.m
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
#import "NLActivityIndicatorView.h"
#import "NLMacros.h"

@implementation NLActivityIndicatorView
{
	CGFloat		startAngle_;
	NSTimer*	drawTimer_;
}

@synthesize
animating		= animating_,
indicatorColor	= indicatorColor_,
indicatorWidth	= indicatorWidth_,
indicatorStep	= indicatorStep_,
indicatorLength	= indicatorLength_;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
	if (!(self = [super initWithFrame:frame])) return nil;
	
	// defaults
	[self setIndicatorColor:[UIColor whiteColor]];
	[self setBackgroundColor:[UIColor clearColor]];
	[self setIndicatorWidth:5.f];
	[self setIndicatorStep:10.f];
	[self setIndicatorLength:120.f];
	
	return self;
}

- (void)dealloc
{
	[drawTimer_ invalidate];
	drawTimer_ = nil;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(ctx, [[self backgroundColor] CGColor]);
	CGContextFillRect			  (ctx, rect);
	
	if (!animating_) return;
	
	CGFloat width  = CGRectGetWidth([self bounds]) - indicatorWidth_ * 2;
	CGFloat height = CGRectGetHeight([self bounds]) - indicatorWidth_ * 2;
	CGRect bounds  = {indicatorWidth_, indicatorWidth_, width, height};
	CGFloat x	   = CGRectGetMidX(bounds);
	CGFloat y	   = CGRectGetMidY(bounds);
	CGFloat radius = CGRectGetWidth(bounds) / 2;
	double start   = _radians(startAngle_);
	double end	   = _radians(startAngle_ + indicatorLength_);
	
	CGContextAddArc					(ctx, x, y, radius, start, end, 0);
	CGContextSetLineWidth			(ctx, indicatorWidth_);
	CGContextSetLineCap				(ctx, kCGLineCapRound);
	CGContextSetStrokeColorWithColor(ctx, [indicatorColor_ CGColor]);
	CGContextStrokePath				(ctx);
}

#pragma mark - Events

- (void)drawTimerFired:(NSTimer *)sender
{
	startAngle_ += indicatorStep_;
	
	if (startAngle_ > 360.f)
		startAngle_ = 0.f;
	
	[self setNeedsDisplay];
}

#pragma mark - Property Accessors

- (void)setAnimating:(BOOL)animating
{
	if (animating && !animating_) {
		
		drawTimer_ = [NSTimer
					  timerWithTimeInterval:0.05
					  target:self
					  selector:@selector(drawTimerFired:)
					  userInfo:nil
					  repeats:YES];
		
		[[NSRunLoop mainRunLoop] addTimer:drawTimer_ forMode:NSRunLoopCommonModes];
	}
	else if (!animating && animating_) {
		
		[drawTimer_ invalidate];
		drawTimer_ = nil;
		
		[self setNeedsDisplay];
	}
	
	animating_ = animating;
}

@end
