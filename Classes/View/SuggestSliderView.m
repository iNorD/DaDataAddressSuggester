//
// Created by Egor Eremeev on 28/02/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import "SuggestSliderView.h"
#import "SuggestionCollectionViewCell.h"
#import "Constants.h"
#import "SuggestionsCollectionViewDataSource.h"
#import "SuggestionsCollectionViewDelegate.h"

@interface SuggestSliderView ()

@end

@implementation SuggestSliderView {

    UICollectionView *_sliderCollectionView;
    SuggestionsCollectionViewDataSource * _suggestionsCollectionViewDataSource;
    SuggestionsCollectionViewDelegate * _suggestionsCollectionViewDelegate;

}


- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    [self customInit];

}



- (void)customInit {

    _suggestionsCollectionViewDataSource = [[SuggestionsCollectionViewDataSource alloc] initWithSuggestions:nil];
    _suggestionsCollectionViewDelegate = [[SuggestionsCollectionViewDelegate alloc] initWithSuggestions:nil delegate:self.delegate];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = kSuggestionsSpacing;
    layout.minimumLineSpacing = kSuggestionsSpacing;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];


    _sliderCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];

    [_sliderCollectionView setShowsHorizontalScrollIndicator:NO];

    [_sliderCollectionView setAllowsSelection:YES];

    [_sliderCollectionView setDataSource:_suggestionsCollectionViewDataSource];
    [_sliderCollectionView setDelegate:_suggestionsCollectionViewDelegate];

    [_sliderCollectionView registerClass:[SuggestionCollectionViewCell class] forCellWithReuseIdentifier:@"suggestionViewCell"];


    [self addSubview:_sliderCollectionView];

}

#pragma mark - Custom

- (void)reloadWithSuggestions:(NSArray *)suggestions {

    [_suggestionsCollectionViewDataSource updateSuggestions:suggestions];
    [_suggestionsCollectionViewDelegate updateSuggestions:suggestions];

    __weak typeof(self) selfWeak = self;
    dispatch_async(dispatch_get_main_queue(), ^ {
        __strong typeof(selfWeak) selfStrong = selfWeak;
        [selfStrong->_sliderCollectionView reloadData];
    });

}



@end