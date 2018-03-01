//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SuggestionsGetterDelegate

- (void)didGetSuggestions:(NSArray<NSString *> *)suggestions;

@end

@interface SuggestionProvider : NSObject

- (instancetype)initWithDelegate:(id <SuggestionsGetterDelegate>)delegate;

- (void)requestSuggestionsForAddress:(NSString *)address;

- (void)requestSuggestionsForAddress:(NSString *)address inCity:(NSString *)cityName;

@property(weak, nonatomic) id <SuggestionsGetterDelegate> delegate;

@end