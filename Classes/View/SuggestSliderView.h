//
// Created by Egor Eremeev on 28/02/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SuggestionSliderDelegate.h"


@interface SuggestSliderView : UIView

@property(weak, nonatomic) id <SuggestionSliderDelegate> delegate;

- (void)reloadWithSuggestions:(NSArray *)suggestions;

@end
