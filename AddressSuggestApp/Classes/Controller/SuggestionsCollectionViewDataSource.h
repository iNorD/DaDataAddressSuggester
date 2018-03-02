//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SuggestionsCollectionViewDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithSuggestions:(NSArray<NSString *> *)suggestions;

- (void)updateSuggestions:(NSArray<NSString *> *)suggestions;
@end