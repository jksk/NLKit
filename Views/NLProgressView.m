//
//  NLProgressView.m
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
#import "NLProgressView.h"
#import "NLActivityIndicatorView.h"
#import "NLMacros.h"
#import "UIWindow+NLKit.h"
#import "UIColor+NLKit.h"
#import "UIView+NLKit.h"

@interface ProgressView_ : UIView
@end

#pragma mark -
@implementation ProgressView_

- (id)init
{
	if (!(self = [super initWithFrame:CGRectZero])) return nil;
	
	[self setBackgroundColor:[UIColor clearColor]];
	return self;
}

@end

#pragma mark -
@interface ProgressSuccess_ : ProgressView_
@end

#pragma mark -
@implementation ProgressSuccess_

- (void)drawRect:(CGRect)rect
{
	static CGFloat lineWidth = 6.f;
	CGFloat width			 = CGRectGetWidth([self bounds]) - lineWidth*2;
	CGFloat height			 = CGRectGetHeight([self bounds]) - lineWidth*2;
	CGRect frame			 = {lineWidth, lineWidth, width, height};
	CGContextRef ctx		 = UIGraphicsGetCurrentContext();
	
	CGContextClearRect				(ctx, rect);
	CGContextMoveToPoint			(ctx, CGRectGetMinX(frame), CGRectGetMaxY(frame) - 10.f);
	CGContextAddLineToPoint			(ctx, CGRectGetMidX(frame), CGRectGetMaxY(frame));
	CGContextAddLineToPoint			(ctx, CGRectGetMaxX(frame), CGRectGetMinY(frame));
	CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
	CGContextSetLineCap				(ctx, kCGLineCapRound);
	CGContextSetLineWidth			(ctx, lineWidth);
	CGContextStrokePath				(ctx);
}

@end

#pragma mark -
@interface ProgressFailure_ : ProgressView_
@end

#pragma mark -
@implementation ProgressFailure_

- (void)drawRect:(CGRect)rect
{
	static CGFloat lineWidth = 6.f;
	CGFloat width			 = CGRectGetWidth([self bounds]) - lineWidth*2;
	CGFloat height			 = CGRectGetHeight([self bounds]) - lineWidth*2;
	CGRect frame			 = {lineWidth, lineWidth, width, height};
	CGContextRef ctx		 = UIGraphicsGetCurrentContext();
	
	CGContextClearRect				(ctx, rect);
	CGContextMoveToPoint			(ctx, CGRectGetMinX(frame), CGRectGetMinY(frame));
	CGContextAddLineToPoint			(ctx, CGRectGetMaxX(frame), CGRectGetMaxY(frame));
	CGContextMoveToPoint			(ctx, CGRectGetMaxX(frame), CGRectGetMinY(frame));
	CGContextAddLineToPoint			(ctx, CGRectGetMinX(frame), CGRectGetMaxY(frame));
	CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
	CGContextSetLineCap				(ctx, kCGLineCapRound);
	CGContextSetLineWidth			(ctx, lineWidth);
	CGContextStrokePath				(ctx);
}

@end

#pragma mark -
@interface ProgressPie_ : ProgressView_
@end

#pragma mark -
@implementation ProgressPie_

- (void)drawRect:(CGRect)rect
{
	static CGFloat inset = 3.f;
	CGFloat progress	 = [(NLProgressView *)[self superview] progress];
	CGFloat width		 = CGRectGetWidth([self bounds]) - inset*2;
	CGFloat height		 = CGRectGetHeight([self bounds]) - inset*2;
	CGRect frame		 = {inset, inset, width, height};
	CGContextRef ctx	 = UIGraphicsGetCurrentContext();
	CGFloat x			 = CGRectGetMidX(frame);
	CGFloat y			 = CGRectGetMidY(frame);
	CGFloat radius		 = CGRectGetWidth(frame) / 2;
	
	CGContextClearRect				(ctx, rect);
	CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
	CGContextSetFillColorWithColor	(ctx, [[UIColor whiteColor] CGColor]);
	CGContextSetLineWidth			(ctx, inset);
	CGContextStrokeEllipseInRect	(ctx, frame);
	
	CGContextBeginPath				(ctx);
	CGContextMoveToPoint			(ctx, x, y);
	CGContextAddLineToPoint			(ctx, x, 0.f);
	CGContextAddArc					(ctx, x, y, radius, _radians(270.0), _radians(270.0 + (360.0 * progress)), 0);
	CGContextAddLineToPoint			(ctx, x, y);
	CGContextFillPath				(ctx);
}

@end

#pragma mark -
@interface ProgressBar_ : ProgressView_
@end

#pragma mark -
@implementation ProgressBar_

#pragma mark - Lifecycle

- (id)init
{
	if (!(self = [super init])) return nil;
	
	CALayer* layer = [self layer];
	
	[layer setCornerRadius:4.f];
	[layer setMasksToBounds:YES];
	[layer setBorderColor:[[UIColor whiteColor] CGColor]];
	[layer setBorderWidth:3.f];
	
	return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	static CGFloat inset = 3.f;
	CGFloat progress	 = [(NLProgressView *)[self superview] progress];
	CGFloat width		 = (CGRectGetWidth([self bounds]) - inset*2) * progress;
	CGFloat height		 = CGRectGetHeight([self bounds]) - inset*2;
	CGRect fillRect		 = {inset, inset, width, height};
	CGContextRef ctx	 = UIGraphicsGetCurrentContext();
	
	CGContextClearRect			  (ctx, rect);
	CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
	CGContextFillRect			  (ctx, fillRect);
}

@end

#pragma mark -
@interface NLProgressView ()

@property (strong, nonatomic) UILabel*					textLabel;
@property (strong, nonatomic) UILabel*					detailTextLabel;
@property (strong, nonatomic) NLActivityIndicatorView*	activityIndicator;
@property (strong, nonatomic) ProgressView_*			typeView;

- (void)setupGeometry;
- (void)removalCleanup;

- (void)show;
- (void)hide;

@end

#pragma mark -
@implementation NLProgressView

@synthesize
delegate			= delegate_,
visible				= visible_,
animationDuration	= animationDuration_,
hideDelay			= hideDelay_,
progress			= progress_,
type				= type_,
textLabel			= textLabel_,
detailTextLabel		= detailTextLabel_,
activityIndicator	= activityIndicator_,
typeView			= typeView_;

@dynamic
text,
detailText;

#pragma mark - Lifecycle

- (id)init
{
	if (!(self = [super initWithFrame:CGRectZero])) return nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(orientationDidChange:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
	
	[self setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin|
							   UIViewAutoresizingFlexibleBottomMargin|
							   UIViewAutoresizingFlexibleLeftMargin|
							   UIViewAutoresizingFlexibleRightMargin)];
	
	[self addSubview:[self textLabel]];
	[self addSubview:[self detailTextLabel]];
	
	[self setAnimationDuration:0.3f];
	[self setHideDelay:1.f];
	[self setType:NLProgressViewTypeOngoing];
	[self setAlpha:0.75f];
	
	[[self layer] setCornerRadius:10.f];
	
	return self;
}

+ (id)progressView
{
	id view = [[UIWindow mainWindow] subviewWithClassname:NSStringFromClass(self)];
	
	if (view)
		return view;
	
	return [[self alloc] init];
}

#pragma mark - Public

- (void)setSuccessTextAndHide:(NSString *)text
{
	[self setText:text];
	[self setType:NLProgressViewTypeSuccess];
	[self setVisible:NO];
}

- (void)setFailureTextAndHide:(NSString *)text
{
	[self setText:text];
	[self setType:NLProgressViewTypeFailure];
	[self setVisible:NO];
}

#pragma mark - Events

- (void)orientationDidChange:(NSNotification *)note
{
	if (![self superview]) return;
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	
	double degrees = 0.0;
	
	switch (orientation) {
		case UIInterfaceOrientationPortrait:
			degrees = 0.0;
			break;
		case UIInterfaceOrientationPortraitUpsideDown:
			degrees = 180.0;
			break;
		case UIInterfaceOrientationLandscapeLeft:
			degrees = -90.0;
			break;
		case UIInterfaceOrientationLandscapeRight:
			degrees = 90.0;
			break;
	}
	
	if (animationDuration_ > 0.f)
		[UIView
		 animateWithDuration:animationDuration_
		 delay:0.f
		 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState
		 animations:^{ [self setTransform:CGAffineTransformMakeRotation(_radians(degrees))]; }
		 completion:NULL];
	else
		[self setTransform:CGAffineTransformMakeRotation(_radians(degrees))];
}

#pragma mark - Overrides

- (void)setAlpha:(CGFloat)alpha
{
	[self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
}

- (CGFloat)alpha
{
	return [[self backgroundColor] alpha];
}

- (void)setNeedsDisplay
{
	[super				setNeedsDisplay];
	[typeView_			setNeedsDisplay];
	[activityIndicator_ setNeedsDisplay];
}

#pragma mark - Helpers

- (void)setupGeometry
{
	static CGFloat kPadding				 = 20.f;
	static CGFloat kTypeHeight			 = 36.f;
	static CGFloat kTextLineHeight		 = 20.f;
	static CGFloat kDetailTextLineHeight = 14.f;
	static CGFloat kSelfWidth			 = 200.f;
	static int kTextLineLength			 = 16;
	static int kDetailTextLineLength	 = 24;
	CGFloat textHeight					 = 0.f;
	CGFloat detailTextHeight			 = 0.f;
	
	// textlabel height
	NSString* text = [textLabel_ text];
	
	if ([text length])
		textHeight = ((([text length] / kTextLineLength) * kTextLineHeight) + kTextLineHeight);
	
	// detailtextlabel height
	NSString* detailText = [detailTextLabel_ text];
	
	if ([detailText length])
		detailTextHeight = ((([detailText length] / kDetailTextLineLength) * kDetailTextLineHeight) +
							kDetailTextLineHeight);
	
	// self
	CGFloat selfHeight = (textHeight + detailTextHeight + kTypeHeight + kPadding*2 +
						  (textHeight ? kPadding : 0.f) + (detailTextHeight ? kPadding : 0.f));
	CGSize size = CGSizeMake(kSelfWidth, selfHeight);
	
	// type
	CGFloat typeY = (textHeight ? kPadding : 0.f) + textHeight + kPadding;
	CGRect typeFrame = CGRectMake((size.width - kTypeHeight)/2, typeY, kTypeHeight, kTypeHeight);
	
	switch (type_) {
			
		case NLProgressViewTypeOngoing:
			[activityIndicator_ setFrame:typeFrame];
			break;
			
		case NLProgressViewTypeSuccess:
		case NLProgressViewTypeFailure:
		case NLProgressViewTypePie:
			[typeView_ setFrame:typeFrame];
			break;
			
		case NLProgressViewTypeBar:
			[typeView_ setFrame:CGRectMake(kPadding*2, typeY+5.f, size.width - kPadding*4, kTypeHeight-10.f)];
			break;
	}
	
	// set frames
	[textLabel_		  setFrame:CGRectMake(kPadding, kPadding, size.width - kPadding*2, textHeight)];
	[detailTextLabel_ setFrame:CGRectMake(kPadding, (size.height - detailTextHeight - kPadding),
										  size.width - kPadding*2, detailTextHeight)];
	
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	CGRect frame = {(CGRectGetWidth(screenFrame) - size.width)/2, (CGRectGetHeight(screenFrame) - size.height)/2, size};
	[self setFrame:frame];
}

- (void)removalCleanup
{
	[[self superview] removeFromSuperview];
	visible_ = NO;
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[delegate_ progressView:self visible:NO];
}

- (void)show
{
	UIView* superview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	[superview setBackgroundColor:[UIColor clearColor]];
	[superview addSubview:self];
	
	if (animationDuration_ > 0.f) {
		
		[super setAlpha:0.f];
		[[UIWindow mainWindow] addSubview:superview];
		
		[UIView
		 animateWithDuration:animationDuration_
		 delay:0.f
		 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState
		 animations:^{ [super setAlpha:1.f]; }
		 completion:NULL];
	}
	else {
		
		[[UIWindow mainWindow] addSubview:superview];
	}
}

- (void)hide
{
	if (animationDuration_ > 0.f)
		[UIView
		 animateWithDuration:animationDuration_
		 delay:0.f
		 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState
		 animations:^{ [super setAlpha:0.f]; }
		 completion:^(BOOL finished) { [self removalCleanup]; }];
	else
		[self removalCleanup];
}

#pragma mark - Property Accessors

- (void)setVisible:(BOOL)visible
{
	if (visible) {
		
		[NLProgressView cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
		
		if (!visible_) {
			
			[self setupGeometry];
			[self show];
			
			visible_ = YES;
			[delegate_ progressView:self visible:YES];
		}
	}
	else if (!visible && visible_)
		[self performSelector:@selector(hide) withObject:nil afterDelay:[self hideDelay]];
}

- (void)setProgress:(CGFloat)progress
{
	progress_ = progress;
	
	if ([self isVisible])
		[self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
	[textLabel_ setText:text];
	
	if ([self isVisible])
		[self setupGeometry];
}

- (NSString *)text
{
	return [textLabel_ text];
}

- (void)setDetailText:(NSString *)detailText
{
	[detailTextLabel_ setText:detailText];
	
	if ([self isVisible])
		[self setupGeometry];
}

- (NSString *)detailText
{
	return [detailTextLabel_ text];
}

- (void)setType:(NLProgressViewType)type
{
	if (type == type_) return;
	
	[activityIndicator_ removeFromSuperview];
	[typeView_			removeFromSuperview];
	
	switch (type) {
		case NLProgressViewTypeOngoing:
			
			[self setTypeView:nil];
			[self addSubview:[self activityIndicator]];
			break;
			
		case NLProgressViewTypePie:
			
			[self setTypeView:[[ProgressPie_ alloc] init]];
			[self addSubview:[self typeView]];
			break;
			
		case NLProgressViewTypeBar:
			
			[self setTypeView:[[ProgressBar_ alloc] init]];
			[self addSubview:[self typeView]];
			break;
			
		case NLProgressViewTypeSuccess:
			
			[self setTypeView:[[ProgressSuccess_ alloc] init]];
			[self addSubview:[self typeView]];
			break;
			
		case NLProgressViewTypeFailure:
			
			[self setTypeView:[[ProgressFailure_ alloc] init]];
			[self addSubview:[self typeView]];
			break;
			
		default:
#ifdef DEBUG
			[NSException raise:@"NLProgressViewType is OOB" format:@"value is %i", type_];
#endif
			break;
	}
	
	type_ = type;
	
	if ([self isVisible]) [self setupGeometry];
}

- (UILabel *)textLabel
{
	if (textLabel_) return textLabel_;
	
	textLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
	
	[textLabel_ setBackgroundColor:[UIColor clearColor]];
	[textLabel_ setTextColor:[UIColor whiteColor]];
	[textLabel_ setTextAlignment:NSTextAlignmentCenter];
	[textLabel_ setFont:[UIFont boldSystemFontOfSize:18.f]];
	[textLabel_ setNumberOfLines:0];
	
	return textLabel_;
}

- (UILabel *)detailTextLabel
{
	if (detailTextLabel_) return detailTextLabel_;
	
	detailTextLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
	
	[detailTextLabel_ setBackgroundColor:[UIColor clearColor]];
	[detailTextLabel_ setTextColor:[UIColor whiteColor]];
	[detailTextLabel_ setTextAlignment:NSTextAlignmentCenter];
	[detailTextLabel_ setFont:[UIFont boldSystemFontOfSize:12.f]];
	[detailTextLabel_ setNumberOfLines:0];
	
	return detailTextLabel_;
}

- (NLActivityIndicatorView *)activityIndicator
{
	if (activityIndicator_) return activityIndicator_;
	
	activityIndicator_ = [[NLActivityIndicatorView alloc] initWithFrame:CGRectZero];
	
	[activityIndicator_ setIndicatorColor:[UIColor whiteColor]];
	[activityIndicator_ setBackgroundColor:[UIColor clearColor]];
	[activityIndicator_ setAnimating:YES];
	
	return activityIndicator_;
}

@end
