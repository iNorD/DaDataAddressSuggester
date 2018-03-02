//
// Created by Egor Eremeev on 28/02/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SuggestionViewWithLabel <NSObject>

- (void)setText:(NSString *)text;

- (void)performSelectionAnimation;

- (void)highlightSuggestionView;

- (void)unhighlightSuggestionView:(BOOL)animated;

@end