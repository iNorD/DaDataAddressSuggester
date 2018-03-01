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
    SuggestSliderView * _suggestView;
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

- (void)customInit {

    [self setClearButtonMode:UITextFieldViewModeWhileEditing];

    [self setDelegate:self];
    [self addSuggestView];
    _suggestionProvider = [[SuggestionProvider alloc] initWithDelegate:self];


}

- (void)setCity:(NSString *)cityName {

    _cityName = cityName;

}

- (void)addSuggestView {


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];






}

- (void)keyboardWasShown:(NSNotification *)notification {

    [_suggestView removeFromSuperview];

    CGSize keyboardSize = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    _suggestView = [SuggestSliderView new];
    [_suggestView setDelegate:self];

    CGRect screenRect = [[UIScreen mainScreen] bounds];

    CGSize suggestViewSize = CGSizeMake(screenRect.size.width, kSuggestionsSliderViewHeight);
    [_suggestView setBackgroundColor:[UIColor grayColor]];

    [_suggestView setFrame:CGRectMake(0, screenRect.size.height-keyboardSize.height-suggestViewSize.height, suggestViewSize.width, suggestViewSize.height)];

    [[UIApplication sharedApplication].keyWindow addSubview:_suggestView];

    [_suggestionProvider requestSuggestionsForAddress:@"" inCity:_cityName];

}


#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];

    [_suggestionProvider requestSuggestionsForAddress:searchStr inCity:_cityName];

    return YES;
}


- (void)didSelectSuggestion:(NSString *)suggestion {

    [self setText:[NSString stringWithFormat:@"%@ ", suggestion]];

    [_suggestionProvider requestSuggestionsForAddress:suggestion inCity:_cityName];

}

#pragma mark - Suggestions Delegate

- (void)didGetSuggestions:(NSArray<NSString *> *)suggestions {

    [_suggestView reloadWithSuggestions:suggestions];

}


@end
