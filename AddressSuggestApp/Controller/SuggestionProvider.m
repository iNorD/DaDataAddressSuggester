//
// Created by Egor Eremeev on 01/03/2018.
// Copyright (c) 2018 pushapp. All rights reserved.
//

#import "SuggestionProvider.h"

@interface SuggestionProvider ()

@end

@implementation SuggestionProvider {

    NSString *_cityName;

}

- (instancetype)initWithDelegate:(id <SuggestionsGetterDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}


- (void)requestSuggestionsForAddress:(NSString *)address {

    if(_cityName!=nil) {
        address = [NSString stringWithFormat:@"%@ %@", _cityName, address];
    }

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address"]];

    [urlRequest setHTTPMethod:@"POST"];

    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"Token 8b612c9ec1a992b3b27a0779e23a2fd8a1630d80" forHTTPHeaderField:@"Authorization"];



    //Set Request body
    NSDictionary *bodyDict = @{ @"query": address, @"count": @"10" };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:bodyDict options:0 error:nil];
    [urlRequest setHTTPBody:postData];



    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error,%@", [error localizedDescription]);
        }
        else {

            NSMutableArray<NSString*> *returnSuggestions = [NSMutableArray new];

            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];

            if(!jsonError)
            {
                if([json[@"suggestions"] isKindOfClass:[NSArray class]]) {

                    NSArray * suggestions = json[@"suggestions"];

                    for (NSDictionary * suggestionDict in suggestions) {

                        NSString * suggestion = [suggestionDict valueForKey:@"value"];
                        [returnSuggestions addObject:suggestion];

                    }


                }
            }


            [self.delegate didGetSuggestions:returnSuggestions];

        }
    }];

}

- (void)requestSuggestionsForAddress:(NSString *)address inCity:(NSString *)cityName {

    _cityName = cityName;
    [self requestSuggestionsForAddress:address];

}


@end