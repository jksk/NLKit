//
//  UIColor+NLKit.m
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

#import "UIColor+NLKit.h"
#import "NLMath.h"

@implementation UIColor (NLKit)

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f];
}

+ (UIColor *)colorWithRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b
{
	return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f];
}

+ (UIColor *)randomColor
{
	return [UIColor colorWithRed:NLRandom.rfloat(0.f, 1.f) green:NLRandom.rfloat(0.f, 1.f) blue:NLRandom.rfloat(0.f, 1.f) alpha:1.f];
}

- (UIColor *)complementaryColor
{
	CGFloat r = 1.f - [self red];
	CGFloat g = 1.f - [self green];
	CGFloat b = 1.f - [self blue];
	CGFloat a = [self alpha];
	
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (CGFloat)red
{
	CGFloat red;
	
	if ([self getRed:&red green:NULL blue:NULL alpha:NULL])
		return red;
	
	return -1.f;
}

- (CGFloat)green
{
	CGFloat green;
	
	if ([self getRed:NULL green:&green blue:NULL alpha:NULL])
		return green;
	
	return -1.f;
}

- (CGFloat)blue
{
	CGFloat blue;
	
	if ([self getRed:NULL green:NULL blue:&blue alpha:NULL])
		return blue;
	
	return -1.f;
}

- (CGFloat)hue
{
	CGFloat hue;
	
	if ([self getHue:&hue saturation:NULL brightness:NULL alpha:NULL])
		return hue;
	
	return -1.f;
}

- (CGFloat)saturation
{
	CGFloat sat;
	
	if ([self getHue:NULL saturation:&sat brightness:NULL alpha:NULL])
		return sat;
	
	return -1.f;
}

- (CGFloat)brightness
{
	CGFloat brt;
	
	if ([self getHue:NULL saturation:NULL brightness:&brt alpha:NULL])
		return brt;
	
	return -1.f;
}

- (CGFloat)white
{
	CGFloat white;
	
	if ([self getWhite:&white alpha:NULL])
		return white;
	
	return -1.f;
}

- (CGFloat)alpha
{
	return CGColorGetAlpha([self CGColor]);
}

@end
