//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import "SuggestionsCollectionViewDelegate.h"
#import "Constants.h"
#import "SuggestionViewWithLabel.h"
#import "UIFont+SuggestionFont.h"


@interface SuggestionsCollectionViewDelegate ()

@end

@implementation SuggestionsCollectionViewDelegate {
    NSArray<NSString *> *_suggestions;
}

- (instancetype)initWithSuggestions:(NSArray<NSString *> *)suggestions delegate:(id <SuggestionSliderDelegate>)delegate {
    self = [super init];
    if (self) {
        _suggestions = suggestions;
        self.delegate = delegate;
    }

    return self;
}

- (void)updateSuggestions:(NSArray<NSString *> *)suggestions {
    _suggestions = suggestions;

}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell<SuggestionViewWithLabel> * highlightedItem = (UICollectionViewCell <SuggestionViewWithLabel> *) [collectionView cellForItemAtIndexPath:indexPath];
    [highlightedItem highlightSuggestionView];

}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell<SuggestionViewWithLabel> * highlightedItem = (UICollectionViewCell <SuggestionViewWithLabel> *) [collectionView cellForItemAtIndexPath:indexPath];
    [highlightedItem unhighlightSuggestionView:NO];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell<SuggestionViewWithLabel> * selectedItem = (UICollectionViewCell <SuggestionViewWithLabel> *) [collectionView cellForItemAtIndexPath:indexPath];
    [selectedItem performSelectionAnimation];

    NSString * suggestion = _suggestions[(NSUInteger) indexPath.row];

    if([self.delegate conformsToProtocol:@protocol(SuggestionSliderDelegate)]) {
        [self.delegate didSelectSuggestion:suggestion];
    }

}

#pragma mark - Collection View Delegate Flow Layout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake((kSuggestionsSliderViewHeight-kSuggestionItemHeight)/2, 5, (kSuggestionsSliderViewHeight-kSuggestionItemHeight)/2, 5);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *suggestion = _suggestions[(NSUInteger) indexPath.row];

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont suggestionFont]};
    CGFloat width = [[[NSAttributedString alloc] initWithString:suggestion attributes:attributes] size].width;

    CGSize mElementSize = CGSizeMake(width + 10, kSuggestionItemHeight);
    return mElementSize;
}


@end