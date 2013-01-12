//
//  NLAutoCompleteTextField.m
//  Traveller
//
//  Created by Jesper on 12/7/12.
//  Copyright (c) 2012 Neology. All rights reserved.
//

#import "NLAutoCompleteTextField.h"

struct NLTextFieldDelegateFlags {
	BOOL shouldBeginEditing;
	BOOL didBeginEditing;
	BOOL shouldEndEditing;
	BOOL didEndEditing;
	BOOL shouldChangeCharacters;
	BOOL shouldClear;
	BOOL shouldReturn;
};

@interface NLAutoCompleteTextField ()

@property (weak, nonatomic)	id<UITextFieldDelegate>	textFieldDelegate;

- (void)searchAutocompletion;

@end

#pragma mark -

@implementation NLAutoCompleteTextField
{
	struct NLTextFieldDelegateFlags _delegateFlags;
}

@dynamic
selectedRange;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		
		[self setDelegate:self];
		[self setAutocorrectionType:UITextAutocorrectionTypeNo];
		[self setAutocompleteEnabled:YES];
	}
	
	return self;
}

#pragma mark - Public

- (void)autocomplete
{
	[self setSelectedRange:NSMakeRange([[self text] length], 0)];
}

#pragma mark - Helpers

- (void)searchAutocompletion
{
	NSString* text = [self text];
	
	for (NSString* string in [self autocompletionStrings])
		if ([string hasPrefix:text]) {
			
			NSUInteger length = [text length];
			
			[self setText:string];
			[self setSelectedRange:NSMakeRange(length, [string length] - length)];
			
			break;
		}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (_delegateFlags.shouldBeginEditing)
		return [_textFieldDelegate textFieldShouldBeginEditing:textField];
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (_delegateFlags.didBeginEditing)
		[_textFieldDelegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	if (_delegateFlags.shouldEndEditing)
		return [_textFieldDelegate textFieldShouldEndEditing:textField];
	
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (_delegateFlags.didEndEditing)
		[_textFieldDelegate textFieldDidEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL should = _delegateFlags.shouldChangeCharacters ? [_textFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string] : YES;

	if ([self isAutocompleteEnabled] && [[self autocompletionStrings] count]) {
		
		if ([string isEqualToString:@""]) {
			
			NSRange selectedRange	= [self selectedRange];
			NSString* text			= [textField text];
			NSString* selectedText	= [text substringWithRange:selectedRange];
			
			if ([text isEqualToString:selectedText])
				[self setText:@""];
			else
				[self setText:[text substringWithRange:NSMakeRange(0, selectedRange.location - 1)]];
			
			should = NO;
		}
		
		[self performSelector:@selector(searchAutocompletion) withObject:nil afterDelay:0.f];
	}
	
	return should;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	if (_delegateFlags.shouldClear)
		return [_textFieldDelegate textFieldShouldClear:textField];
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (_delegateFlags.shouldReturn)
		return [_textFieldDelegate textFieldShouldReturn:textField];
	
	return YES;
}

#pragma mark - Properties

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
	[super setDelegate:self];
	
	if (delegate != self) {
		
		_delegateFlags.shouldBeginEditing		= [delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)];
		_delegateFlags.didBeginEditing			= [delegate respondsToSelector:@selector(textFieldDidBeginEditing:)];
		_delegateFlags.shouldEndEditing			= [delegate respondsToSelector:@selector(textFieldShouldEndEditing:)];
		_delegateFlags.didEndEditing			= [delegate respondsToSelector:@selector(textFieldDidEndEditing:)];
		_delegateFlags.shouldChangeCharacters	= [delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)];
		_delegateFlags.shouldClear				= [delegate respondsToSelector:@selector(textFieldShouldClear:)];
		_delegateFlags.shouldReturn				= [delegate respondsToSelector:@selector(textFieldShouldReturn:)];
		_textFieldDelegate						= delegate;
	}
	else {
		
		_delegateFlags.shouldBeginEditing		= NO;
		_delegateFlags.didBeginEditing			= NO;
		_delegateFlags.shouldEndEditing			= NO;
		_delegateFlags.didEndEditing			= NO;
		_delegateFlags.shouldChangeCharacters	= NO;
		_delegateFlags.shouldClear				= NO;
		_delegateFlags.shouldReturn				= NO;
		_textFieldDelegate						= nil;
	}
}

- (void)setAutocorrectionType:(UITextAutocorrectionType)autocorrectionType
{
	[super setAutocorrectionType:UITextAutocorrectionTypeNo];
}

- (void)setSelectedRange:(NSRange)selectedRange
{
	UITextPosition* start	= [self positionFromPosition:[self beginningOfDocument] offset:selectedRange.location];
	UITextPosition* end		= [self positionFromPosition:start offset:selectedRange.length];
	UITextRange* range		= [self textRangeFromPosition:start toPosition:end];
	
	[self setSelectedTextRange:range];
}

- (NSRange)selectedRange
{
	UITextRange* range = [self selectedTextRange];
	
	if (!range)
		return NSMakeRange(NSNotFound, 0);
	
	NSUInteger location	= [self offsetFromPosition:[self beginningOfDocument] toPosition:[range start]];
	NSUInteger length	= [self offsetFromPosition:[range start] toPosition:[range end]];
	
	return NSMakeRange(location, length);
}

@end
