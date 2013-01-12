//
//  UIImage+NLKit.m
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

#import "UIImage+NLKit.h"

@implementation UIImage (NLKit)

+ (UIImage *)imageWithColor:(UIColor *)color ofSize:(CGSize)size
{
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextAddRect(context, (CGRect){0.f, 0.f, size});
	CGContextFillPath(context);
	
	UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

- (UIImage *)imageResizedToSize:(CGSize)size
{
	UIGraphicsBeginImageContext(size);
	
	[self drawInRect:(CGRect){0.f, 0.f, size}];
	UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}

- (UIImage *)imageScaledToWidth:(CGFloat)width
{
	CGFloat scale = [self size].width / width;
	CGSize size = CGSizeMake([self size].width / scale, [self size].height / scale);
	return [self imageResizedToSize:size];
}

- (UIImage *)imageScaledToHeight:(CGFloat)height
{
	CGFloat scale = [self size].height / height;
	CGSize size = CGSizeMake([self size].width / scale, [self size].height / scale);
	return [self imageResizedToSize:size];
}

@end
