//
// Created by Egor Eremeev on 28/02/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import "SuggestionCollectionViewCell.h"
#import "UIFont+SuggestionFont.h"

@interface SuggestionCollectionViewCell ()

@end

@implementation SuggestionCollectionViewCell {
    UILabel *_suggestionLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self customInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }

    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [_suggestionLabel setText:@""];
    [self setBackgroundColor:[UIColor whiteColor]];
}


-(void)performSelectionAnimation {

    [self highlightSuggestionView];

    [self unhighlightSuggestionView:YES];

}

- (void)highlightSuggestionView {

    [self setBackgroundColor:[UIColor colorWithRed:236.0f/255.0f green:240.0f/255.0f blue:241.0f/255.0f alpha:1.f]];

}

- (void)unhighlightSuggestionView:(BOOL)animated {

    if(animated) {
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self setBackgroundColor:[UIColor whiteColor]];
            self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        } completion:nil];
    } else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }

}


- (void)customInit {

    [self setBackgroundColor:[UIColor whiteColor]];

    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.masksToBounds = YES;


    _suggestionLabel = [UILabel new];
    [_suggestionLabel setTextAlignment:NSTextAlignmentCenter];
    [_suggestionLabel setFont:[UIFont suggestionFont]];


    [self addSubview:_suggestionLabel];



    //Auto layout
    _suggestionLabel.translatesAutoresizingMaskIntoConstraints = NO;


    NSLayoutConstraint *leading = [NSLayoutConstraint
            constraintWithItem:_suggestionLabel
                     attribute:NSLayoutAttributeLeading
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeLeading
                    multiplier:1.0f
                      constant:0.f];

    NSLayoutConstraint *top = [NSLayoutConstraint
            constraintWithItem:_suggestionLabel
                     attribute:NSLayoutAttributeTop
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeTop
                    multiplier:1.0f
                      constant:0.f];


    NSLayoutConstraint *height = [NSLayoutConstraint
            constraintWithItem:_suggestionLabel
                     attribute:NSLayoutAttributeHeight
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeHeight
                    multiplier:1.0f
                      constant:0.f];

    NSLayoutConstraint *width = [NSLayoutConstraint
            constraintWithItem:_suggestionLabel
                     attribute:NSLayoutAttributeWidth
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeWidth
                    multiplier:1.0f
                      constant:0.f];


    //Add constraints to the Parent
    [self addConstraint:top];
    [self addConstraint:leading];
    [self addConstraint:height];
    [self addConstraint:width];


}


//+ (UIFont *)fontForSuggestion {
//    return [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
//}

#pragma mark - Suggestion With Label

- (void)setText:(NSString *)text {

    [_suggestionLabel setText:text];

}


@end