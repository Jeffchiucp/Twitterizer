//
//  ViewController.m
//  Twitterizer
//
//  Created by ALIREZA TABRIZI on 3/16/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounts;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ontwitterizeButtonPushed:(UIButton *)sender {
    NSString *userInputText = self.textView.text;
    NSUInteger length = userInputText.length;
   // NSLog(@"%lu", length);
    NSMutableString *vowelsRemoved = [NSMutableString new];
    NSCharacterSet *vowel = [NSCharacterSet characterSetWithCharactersInString:@"aeiouAEIOU"];
    for (int i = 0; i < length-1; i++) {
        if (![vowel characterIsMember:[userInputText characterAtIndex:i]]) {
            [vowelsRemoved appendString: [NSString stringWithFormat: @"%c",[userInputText characterAtIndex:i]]];
        }
    }
    self.textView.text = vowelsRemoved;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSString *userInputText = self.textView.text;
    NSUInteger length = userInputText.length;
    self.characterCounts.text = [NSString stringWithFormat:@"%lu", length];
}


@end
