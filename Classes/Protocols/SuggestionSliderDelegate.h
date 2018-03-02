//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SuggestionSliderDelegate <NSObject>

- (void)didSelectSuggestion:(NSString *)suggestion;

@end