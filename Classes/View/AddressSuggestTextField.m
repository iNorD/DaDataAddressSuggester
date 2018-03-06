//
//  AddressSuggestTextField.m
//  AddressSuggestApp
//
//  Created by Egor Eremeev on 28/02/2018.
//  Copyright © 2018 pushapp. All rights reserved.
//

#import "AddressSuggestTextField.h"
#import "SuggestSliderView.h"
#import "Constants.h"
#import "SuggestionProvider.h"

@interface AddressSuggestTextField() <UITextFieldDelegate, SuggestionSliderDelegate, SuggestionsGetterDelegate>

@end

@implementation AddressSuggestTextField  {
    SuggestSliderView * _suggestSlideView;
    NSString *_cityName;
    SuggestionProvider * _suggestionProvider;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }

    return self;
}


- (void)dealloc {

    [self unregisterForKeyboardNotifications];

}


- (void)customInit {

    [self setClearButtonMode:UITextFieldViewModeWhileEditing];

    [self registerNotifications];
    _suggestionProvider = [[SuggestionProvider alloc] initWithDelegate:self];

}

- (void)setDaDataAPIKey:(NSString *)daDataAPIKey {

    [_suggestionProvider setDaDataAPIKey:daDataAPIKey];
}


- (void)setCity:(NSString *)cityName {

    _cityName = cityName;

}

- (void)registerNotifications {


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];


}


- (void)unregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



- (void)keyboardWillHide:(NSNotification *)notification {

    if(![self isFirstResponder]) {
        return;
    }

    [_suggestSlideView removeFromSuperview];
    _suggestSlideView = nil;

}

-(void)keyboardWillChangeFrame:(NSNotification *)notification {

    if(![self isFirstResponder]) {
        return;
    }

    CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    if (_suggestSlideView != nil && keyboardSize.height != 0) {

        CGRect screenRect = [[UIScreen mainScreen] bounds];

        CGRect suggestSlideViewFrame = CGRectMake(0, screenRect.size.height - keyboardSize.height - kSuggestionsSliderViewHeight, screenRect.size.width, kSuggestionsSliderViewHeight);

        [_suggestSlideView setFrame:suggestSlideViewFrame];

    }

}


- (void)keyboardWillShow:(NSNotification *)notification {

    if(![self isFirstResponder]) {
        return;
    }

    if(_suggestSlideView == nil) {

        CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

        UIView *textFieldSuperView = [UIApplication sharedApplication].keyWindow.subviews.firstObject;


        CGRect screenRect = [[UIScreen mainScreen] bounds];

        CGRect suggestSlideViewFrame = CGRectMake(0, screenRect.size.height - keyboardSize.height - kSuggestionsSliderViewHeight, screenRect.size.width, kSuggestionsSliderViewHeight);

        _suggestSlideView = [[SuggestSliderView alloc] initWithFrame:suggestSlideViewFrame];
        [_suggestSlideView setDelegate:self];


        [textFieldSuperView addSubview:_suggestSlideView];

        [_suggestionProvider requestSuggestionsForAddress:self.text inCity:_cityName];

        [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];


    }


}

-(void)textFieldDidChange {

    [_suggestionProvider requestSuggestionsForAddress:self.text inCity:_cityName];

}


- (void)didSelectSuggestion:(NSString *)suggestion {

    [self setText:[NSString stringWithFormat:@"%@ ", suggestion]];

    [_suggestionProvider requestSuggestionsForAddress:self.text inCity:_cityName];

}

#pragma mark - Suggestions Delegate

- (void)didGetSuggestions:(NSArray<NSString *> *)suggestions {

    [_suggestSlideView reloadWithSuggestions:suggestions];

}


@end
