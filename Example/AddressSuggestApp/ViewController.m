//
//  ViewController.m
//  AddressSuggestApp
//
//  Created by Egor Eremeev on 28/02/2018.
//  Copyright © 2018 pushapp. All rights reserved.
//

#import "ViewController.h"
#import "AddressSuggestTextField.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet AddressSuggestTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.textField setCity:@"Санкт-Петербург"];
    [self.textField setDaDataAPIKey:@"8b612c9ec1a992b3b27a0779e23a2fd8a1630d80"];

}


@end
