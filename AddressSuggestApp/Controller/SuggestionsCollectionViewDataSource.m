//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import "SuggestionsCollectionViewDataSource.h"
#import "SuggestionViewWithLabel.h"

@interface SuggestionsCollectionViewDataSource ()

@end

@implementation SuggestionsCollectionViewDataSource {
    NSArray<NSString *> *_suggestions;
}

- (instancetype)initWithSuggestions:(NSArray<NSString *> *)suggestions {
    self = [super init];
    if (self) {
        _suggestions = suggestions;
    }

    return self;
}


- (void)updateSuggestions:(NSArray<NSString *> *)suggestions {
    _suggestions = suggestions;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _suggestions.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *suggestion = _suggestions[(NSUInteger) indexPath.row];

    UICollectionViewCell <SuggestionViewWithLabel> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"suggestionViewCell" forIndexPath:indexPath];
    [cell setText:suggestion];
    return cell;
}


@end