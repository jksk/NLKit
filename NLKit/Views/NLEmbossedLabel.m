//
//  NLEmbossedLabel.m
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

#import "NLEmbossedLabel.h"

static UIImage* blackSquare_(CGSize size)
{
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	
	[[UIColor blackColor] setFill];
	CGRect rect = {0.f, 0.f, size};
	CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
	UIImage* blackSquare = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	return blackSquare;
}

static CGImageRef createMask_(CGSize size, void (^shapeBlock)(void))
{
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	shapeBlock();
	CGImageRef shape = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	UIGraphicsEndImageContext();  
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(shape),
										CGImageGetHeight(shape),
										CGImageGetBitsPerComponent(shape),
										CGImageGetBitsPerPixel(shape),
										CGImageGetBytesPerRow(shape),
										CGImageGetDataProvider(shape), NULL, false);
	return mask;
}

#pragma mark -
@implementation NLEmbossedLabel

@synthesize
darkTextColor	= darkTextColor_,
lightTextColor	= lightTextColor_;

#pragma mark - Lifecycle

- (id)init
{
	if (!(self = [super init])) return nil;
	
	[self setTextColor:[UIColor grayColor]];
	[self setDarkTextColor:[UIColor blackColor]];
	[self setLightTextColor:[UIColor whiteColor]];
	
	return self;
}

//implement text colors

#pragma mark - Drawing

- (void)drawTextInRect:(CGRect)rect
{
	CGRect bounds = [self bounds];
	NSString* text = [self text];
	UIFont* font = [self font];
	UITextAlignment alignment = [self textAlignment];
	UILineBreakMode lineBreak = [self lineBreakMode];
	
	CGSize textSize = [text sizeWithFont:font constrainedToSize:bounds.size lineBreakMode:lineBreak];
	bounds.origin.y = (CGRectGetHeight(bounds) - textSize.height) / 2;
	
	CGRect higherBounds = {CGRectGetMinX(bounds), CGRectGetMinY(bounds)-1.f, bounds.size};
	CGRect middleBounds = {CGRectGetMinX(bounds), CGRectGetMinY(bounds)-0.5f, bounds.size};
	
	CGImageRef mask = createMask_(rect.size, ^{
		
		[[UIColor blackColor] setFill];
		CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
		
		[[UIColor whiteColor] setFill];
		[text drawInRect:bounds withFont:font lineBreakMode:lineBreak alignment:alignment];
		[text drawInRect:higherBounds withFont:font lineBreakMode:lineBreak alignment:alignment];
	});
	
	CGImageRef cutoutRef = CGImageCreateWithMask([blackSquare_(rect.size) CGImage], mask);
	UIImage* cutout = [UIImage imageWithCGImage:cutoutRef
										  scale:[[UIScreen mainScreen] scale]
									orientation:UIImageOrientationUp];
	CGImageRelease(mask);
	CGImageRelease(cutoutRef);
	
	CGImageRef shadedMask = createMask_(rect.size, ^{
		
		[[UIColor whiteColor] setFill];
		CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
		
		CGColorRef color = [[[UIColor blackColor] colorWithAlphaComponent:0.5f] CGColor];
		CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(0.f, 1.f), 1.f, color);
		
		[cutout drawAtPoint:CGPointZero];
	});
	
	// negative image
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.f);
	
	[[UIColor blackColor] setFill];
	[text drawInRect:higherBounds withFont:font lineBreakMode:lineBreak alignment:alignment];
	UIImage* negative = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	CGImageRef innerShadowRef = CGImageCreateWithMask([negative CGImage], shadedMask);
	UIImage* innerShadow = [UIImage imageWithCGImage:innerShadowRef
											   scale:[[UIScreen mainScreen] scale]
										 orientation:UIImageOrientationUp];
	CGImageRelease(shadedMask);
	CGImageRelease(innerShadowRef);
	
	[[UIColor whiteColor] setFill];
	[text drawInRect:middleBounds withFont:font lineBreakMode:lineBreak alignment:alignment];
	
	[[UIColor colorWithWhite:0.5f alpha:1.f] setFill];
	[text drawInRect:higherBounds withFont:font lineBreakMode:lineBreak alignment:alignment];
	
	[innerShadow drawAtPoint:CGPointZero];
}

@end
