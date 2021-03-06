//
//  NLViewController.m
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

#import "NLViewController.h"
#import "NLMacros.h"
#import "UIViewController+NLKit.h"

@implementation NLViewController

#pragma mark - Lifecycle

- (id)init
{
	if (self = [super init]) {
		
	}
	
	return self;
}

- (void)dealloc
{
	[self removeKeyboardObservers];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	
	if (![self isViewLoaded])
		[self removeKeyboardObservers];
}

#pragma mark - View lifecycle

- (void)loadView
{
	UIView* view = [[UIView alloc] initWithFrame:[self defaultViewFrame]];
	[view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	
	[self setView:view];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (_adjustViewWhenKeyboardDisplayed)
		[self addKeyboardObservers];
}

- (NSUInteger)supportedInterfaceOrientations
{
	NSUInteger orientations = UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
		orientations |= UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
	
	return orientations;
}

#pragma mark - Property Accessors

- (void)setAdjustViewWhenKeyboardDisplayed:(BOOL)adjustViewWhenKeyboardDisplayed
{
	_adjustViewWhenKeyboardDisplayed = adjustViewWhenKeyboardDisplayed;
	
	if (adjustViewWhenKeyboardDisplayed && [self isViewLoaded])
		[self addKeyboardObservers];
	else if (!adjustViewWhenKeyboardDisplayed)
		[self removeKeyboardObservers];
}

@end
