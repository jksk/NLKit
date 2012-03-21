//
//  NLEmbossedLabel.h
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

/**
 Created by Marcel Ruegenberg on 18.03.11.
 Allows generic drawing of inner shadows.
 Based on http://stackoverflow.com/questions/3231690/inner-shadow-in-uilabel
 @param rect A rectangle, as in the drawRect: method of UIView
 @param shadowSize The size of the inner shadow
 @param drawJustShapeBlock A block that draws the shape itself, without setting colors
 @param drawColoredShapeBlock A block the draws the shape the way it should appear with the shadow
 */

#import <UIKit/UIKit.h>

@interface NLEmbossedLabel : UILabel

@property (strong, nonatomic) UIColor*	darkTextColor;
@property (strong, nonatomic) UIColor*	lightTextColor;

@end
