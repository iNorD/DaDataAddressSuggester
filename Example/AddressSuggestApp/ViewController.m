//
//  ViewController.m
//  AddressSuggestApp
//
//  Created by Egor Eremeev on 28/02/2018.
//  Copyright © 2018 pushapp. All rights reserved.
//

#import "ViewController.h"
#import "AddressSuggestTextField.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet AddressSuggestTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.textField setCity:@"Санкт-Петербург"];
    [self.textField setDaDataAPIKey:@""];

    [self.textField setDelegate:self];

}

- (IBAction)hideKeyboard:(id)sender {
    
    [_textField resignFirstResponder];
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];

    NSLog(@"searching: %@", searchStr);

    return YES;
}

@end
