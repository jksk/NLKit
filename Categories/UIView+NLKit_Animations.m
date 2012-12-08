//
//  UIView+NLKit_Animations.m
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
#import "UIView+NLKit_Animations.h"
#import "NLMacros.h"

@implementation UIView (NLKit_Animations)

- (void)performAnimatedBlock:(void (^)(void))block duration:(CGFloat)duration
{
	if (duration > 0.f)
		[UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:block completion:NULL];
	else
		block();
}

- (void)setAlpha:(CGFloat)alpha animationDuration:(CGFloat)duration
{
	[self performAnimatedBlock:^{ [self setAlpha:alpha]; } duration:duration];
}

- (void)rotateToAngle:(CGFloat)angle animationDuration:(CGFloat)duration
{
	[self performAnimatedBlock:^{
		
		[self setTransform:CGAffineTransformMakeRotation(_radians(angle))];
	
	} duration:duration];
}

- (void)moveToPoint:(CGPoint)center animationDuration:(CGFloat)duration
{
	[self performAnimatedBlock:^{
		
		[self setCenter:center];
	
	} duration:duration];
}

- (void)spinWithVelocity:(CGFloat)velocity forInterval:(NSTimeInterval)interval
{
	CALayer* layer					= [self layer];
	CATransform3D originalTransform	= [layer transform];
	CATransform3D spinTransform		= CATransform3DMakeRotation(_radians(180.f), 0.f, 0.f, 1.f);
	CAKeyframeAnimation* animation	= [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	
	[animation setDuration:velocity];
	[animation setCalculationMode:@"cubicPaced"];
	[animation setRepeatCount:interval];
	[animation setValues:@[[NSValue valueWithCATransform3D:spinTransform],[NSValue valueWithCATransform3D:originalTransform]]];
	
	[layer addAnimation:animation forKey:@"spinAnimation"];
}

@end
