//
//  NLProgressView.h
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

#import <UIKit/UIKit.h>

@class
NLProgressView;

#pragma mark -
@protocol NLProgressViewDelegate <NSObject>

- (void)progressView:(NLProgressView *)progressView visible:(BOOL)visible;

@end

#pragma mark -
enum {
	NLProgressViewTypeSuccess,
	NLProgressViewTypeFailure,
	NLProgressViewTypeOngoing,
	NLProgressViewTypePie,
	NLProgressViewTypeBar
};

typedef NSUInteger NLProgressViewType;

#pragma mark -
@interface NLProgressView : UIView

@property (weak, nonatomic)						id<NLProgressViewDelegate>	delegate;
@property (assign, nonatomic, getter=isVisible)	BOOL						visible				UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic)					CGFloat						animationDuration	UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic)					CGFloat						hideDelay			UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic)					CGFloat						progress;

@property (strong, nonatomic)					NSString*					text;
@property (strong, nonatomic)					NSString*					detailText;
@property (assign, nonatomic)					NLProgressViewType			type;

+ (id)progressView;

- (void)setSuccessTextAndHide:(NSString *)text;
- (void)setFailureTextAndHide:(NSString *)text;

@end
