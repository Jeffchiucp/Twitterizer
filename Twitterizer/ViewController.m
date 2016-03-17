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
    
    self.textView.delegate = self;
    
    self.textView.text = @"";
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

-(void)textViewDidChange:(UITextView *)textView{
    NSString *userInputText = self.textView.text;
    NSUInteger length = userInputText.length;
    self.characterCounts.text = [NSString stringWithFormat:@"%lu", length];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //int limit = 140;
    if (self.textView.text.length + text.length>140){
        return NO;
    //return !([textView.text length]>=limit);
    }
    return YES;
}

int numHashtagButtonPresses = 0;

//add Hashtag
- (IBAction)onHashtaButtonPressed:(UIButton *)sender {
    numHashtagButtonPresses++;
    NSString *allText = self.textView.text;
    NSArray *wordsArray = [allText componentsSeparatedByString:@" "];
    
    NSMutableString *newText = [NSMutableString new];
    //NSString *newText2 = @"";
    
    for (int i = 0; i < wordsArray.count; i++) {
        NSString *word = wordsArray[i];
        if (i % 2 == numHashtagButtonPresses %2) {
            //even: do nothing
            word = [self addHastagToWord:word];
        }
        //version 1
        [newText appendString:word];
        [newText appendString:@" "];
    }
        //version 2
        //newText2 = [NSString stringWithFormat:@"%@%@ ", newText2, word];
        newText = [newText substringToIndex:(newText.length - 1)];
        self.textView.text = newText;
}

-(NSString *)reverseWord:(NSString *)oldWord{
    NSMutableString *newWord = [NSMutableString new];
    
    for (int i = 0; i < oldWord.length; i++) {
        char c = [oldWord characterAtIndex:oldWord.length-1-i];
        [newWord appendFormat:@"%c", c];
    }
    return newWord;
}

- (NSString *)addHastagToWord: (NSString *)word{
    if([word containsString:@"#"]){
        return word;
    } else {
    return [NSString stringWithFormat:@"#%@", word];
    }
}

- (IBAction)onReverseButtonPressed:(UIButton *)sender {
    NSString *oldText = self.textView.text;
    NSMutableString *newText = [NSMutableString new];
    
    NSArray *wordsArray = [oldText componentsSeparatedByString: @" "];
    for (int i = 0; i < wordsArray.count; i++) {
        NSString *word = wordsArray[i];
        // if contains hashtag, do not change
        // if no hashtag, reverse letters
        if (![word containsString:@"#"]) {
            word = [self reverseWord:word];
        }
        [newText appendString:word];
        [newText appendString:@" "];
    }
    // strip out trailing space
    newText = [newText substringToIndex:(newText.length - 1)];
    self.textView.text = newText;
}


//    [wordsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *word = (NSString *) obj;
//        if (index % 2 == 0) {
//            NSLog(@"")
//        }
//    }]


@end
