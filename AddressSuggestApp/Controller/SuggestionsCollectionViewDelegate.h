//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SuggestionSliderDelegate.h"

@interface SuggestionsCollectionViewDelegate : NSObject <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(weak, nonatomic) id <SuggestionSliderDelegate> delegate;

- (instancetype)initWithSuggestions:(NSArray<NSString *> *)suggestions delegate:(id <SuggestionSliderDelegate>)delegate;

- (void)updateSuggestions:(NSArray<NSString *> *)suggestions;
@end