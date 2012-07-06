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

#define KEYBOARD_ANIMATION_DURATION	0.3f

@interface NLViewController ()

- (void)addKeyboardObservers;
- (void)removeKeyboardObservers;

@end

#pragma mark -
@implementation NLViewController

@synthesize
adjustViewWhenKeyboardDisplayed	= adjustViewWhenKeyboardDisplayed_;

#pragma mark - Lifecycle

- (id)init
{
	if (!(self = [super init])) return nil;
	
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
	
	if (adjustViewWhenKeyboardDisplayed_)
		[self addKeyboardObservers];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ||
			UIInterfaceOrientationIsPortrait(toInterfaceOrientation));
}

#pragma mark - Public

- (CGRect)defaultViewFrame
{
	CGRect frame = [[UIScreen mainScreen] bounds];
	
	frame.size.height -= [[UIApplication sharedApplication] isStatusBarHidden] ? 0.f : 20.f;
	frame.size.height -= CGRectGetHeight([[[self tabBarController] tabBar] frame]);
	
	if ([self navigationController] && ![[self navigationController] isNavigationBarHidden]) 
		frame.size.height -= CGRectGetHeight([[[self navigationController] navigationBar] frame]);
	
	return frame;
}

#pragma mark - Events

- (void)keyboardWillShow_:(NSNotification *)note
{
	[UIView
	 animateWithDuration:KEYBOARD_ANIMATION_DURATION
	 animations:^{
		 
		 CGRect frame = [[self view] frame];
		 frame.size.height -= IPHONE_KEYBOARD_HEIGHT;
		 [[self view] setFrame:frame];
	 }];
}

- (void)keyboardWillHide_:(NSNotification *)note
{
	[UIView
	 animateWithDuration:KEYBOARD_ANIMATION_DURATION
	 animations:^{
		 
		 CGRect frame = [[self view] frame];
		 frame.size.height += IPHONE_KEYBOARD_HEIGHT;
		 [[self view] setFrame:frame];
	 }];
}

#pragma mark - Helpers

- (void)addKeyboardObservers
{
	NSNotificationCenter* nf = [NSNotificationCenter defaultCenter];
	[nf addObserver:self selector:@selector(keyboardWillShow_:) name:UIKeyboardWillShowNotification object:nil];
	[nf addObserver:self selector:@selector(keyboardWillHide_:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObservers
{
	NSNotificationCenter* nf = [NSNotificationCenter defaultCenter];
	[nf removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[nf removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Property Accessors

- (void)setAdjustViewWhenKeyboardDisplayed:(BOOL)adjustViewWhenKeyboardDisplayed
{
	adjustViewWhenKeyboardDisplayed_ = adjustViewWhenKeyboardDisplayed;
	
	if (adjustViewWhenKeyboardDisplayed && [self isViewLoaded])
		[self addKeyboardObservers];
	else if (!adjustViewWhenKeyboardDisplayed)
		[self removeKeyboardObservers];
}

@end
