//
//  NLAutoCompleteTextField.h
//  Traveller
//
//  Created by Jesper on 12/7/12.
//  Copyright (c) 2012 Neology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLAutoCompleteTextField : UITextField
<UITextFieldDelegate>

@property (assign, nonatomic)								NSRange		selectedRange;
@property (assign, nonatomic, getter=isAutocompleteEnabled)	BOOL		autocompleteEnabled;
@property (strong, nonatomic)								NSArray*	autocompletionStrings;

- (void)autocomplete;

@end
