//
//  ViewController.m
//  Calculator
//
//  Created by r2d2 on 9/26/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorModel.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *customButtons;
@property (assign, nonatomic) NSString *firstNumber;
@property (assign, nonatomic) BOOL isMiddle;
@property(strong, nonatomic) CalculatorModel *myCalculator;
@property (weak, nonatomic) IBOutlet UILabel *resultDisplay;
@property(assign, nonatomic) NSString* symbol;
@property(strong, nonatomic) NSMutableArray* history;

- (void) updateCharacterInMiddle:(NSString *)btnTitle joinedNumb:(NSString **)joinedNumb;
- (BOOL) isEmptySpaceDisplay:(NSString*)textOnScreen andNewElem: (NSString* )newElement;
- (void) reset;
- (void) getCustomButton;
- (void) resetAll;

@end

@implementation ViewController
-(CalculatorModel*) myCalculator{
    if (!_myCalculator) {
        self.myCalculator = [CalculatorModel new];
    }
    return _myCalculator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getCustomButton];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"historyOperations"];
}



- (IBAction)btnWithNumber:(UIButton *)sender {
    NSString *btnTitle = sender.currentTitle;
    NSString* joinedNumb = @"";
    
    if (!self.firstNumber){
        self.firstNumber = @"";
    }
    if (!self.isMiddle){
        [self updateCharacterInMiddle:btnTitle joinedNumb:&joinedNumb];
    } else {
        if ([self isEmptySpaceDisplay:self.firstNumber andNewElem:btnTitle]){
            joinedNumb = [self.firstNumber stringByAppendingString:btnTitle];
            self.firstNumber = [NSString stringWithString:joinedNumb];
            NSLog(@"%@", btnTitle);
        } else {
            NSLog(@"%@", @"Not check");
        }
    }
    
    self.resultDisplay.text = self.firstNumber;
}

- (void)updateCharacterInMiddle:(NSString *)btnTitle joinedNumb:(NSString **)joinedNumb {
    if ([btnTitle  isEqual: @"."]){
        *joinedNumb = @"0.";
        self.isMiddle = YES;
    } else {
        *joinedNumb = btnTitle;
        self.isMiddle = YES;
    }
    self.firstNumber = *joinedNumb;
    
    [@[@(1), @(2)] enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToNumber:@1]) {
            *stop = YES;
        }
    }];
}

- (BOOL)isEmptySpaceDisplay:(NSString*)textOnScreen andNewElem: (NSString* )newElement {
    // test for 7 elements
    if (textOnScreen.length > 7) {
        return NO;
    }
    // test on dot
    if([newElement isEqualToString:@"."]){
        NSString *res;
        NSScanner *scanner = [NSScanner scannerWithString:textOnScreen];
        NSCharacterSet *searching = [NSCharacterSet characterSetWithCharactersInString:newElement];
        [scanner scanUpToCharactersFromSet:searching intoString:NULL];
        [scanner scanCharactersFromSet:searching intoString:&res];
        if(res){
            return NO;
        }
    }
    //test for first '0' in label
    if ([[textOnScreen substringFromIndex:0] isEqual: @"0"] && [newElement isEqual:@"0"]) {
        return NO;
    }
    return YES;
}


- (IBAction)performOperation:(UIButton *)sender {
    self.myCalculator.currentOperand = [self.resultDisplay.text doubleValue];
    
    if (!self.symbol){
        self.symbol = sender.currentTitle;
        [self.myCalculator performOperation:self.symbol];
    } else {
        [self.myCalculator performOperation:self.symbol];
        self.symbol = sender.currentTitle;
    }
    
    if(!self.history){
        self.history = [[NSMutableArray alloc] init];
    }
    
    if (!self.myCalculator.isError){
        NSString* res = self.myCalculator.madeOperation;
        [self.history addObject:res];
        [[NSUserDefaults standardUserDefaults] setObject:self.history forKey:@"historyOperations"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (self.myCalculator.isBothOperands && self.myCalculator.isError){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Something wrong! \n Try again!" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self resetAll];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    self.resultDisplay.text = @(self.myCalculator.result).stringValue;
    [self reset];
    self.myCalculator.isError = NO;
    NSLog(@"history %@", self.history);
}

- (IBAction)changeNegativePositive:(UIButton *)sender {
    if (self.firstNumber != nil && ![self.resultDisplay.text isEqual:@"0"] && ![self.firstNumber  isEqual: @"0"]){
        double res = [self.firstNumber doubleValue] *  -1;
        self.firstNumber = @(res).stringValue;
        self.resultDisplay.text = self.firstNumber;
    } else {
        self.resultDisplay.text = @"0";
    }
}

- (IBAction)btnResetMyCalc:(UIButton *)sender {
    [self resetAll];
    
}

- (IBAction)deleteLastNumber:(UISwipeGestureRecognizer *)sender {
    NSString* info = self.resultDisplay.text;
    if([info length] > 1){
        NSMutableString *s1 = [NSMutableString stringWithCapacity:info.length];
        [s1 appendString:info];
        [s1 deleteCharactersInRange:NSMakeRange(info.length - 1, 1)];
        info = [NSString stringWithFormat:@"%@", s1];
        self.firstNumber = [NSString stringWithFormat:@"%@", info];
        self.resultDisplay.text = self.firstNumber;
    } else {
        self.isMiddle = NO;
        self.firstNumber = nil;
        self.resultDisplay.text = @"0";
    }
}

-(void) reset{
    self.firstNumber = nil;
    self.isMiddle = nil;
    
}

-(void) getCustomButton{
    self.resultDisplay.layer.borderColor = [UIColor whiteColor].CGColor;
    self.resultDisplay.layer.borderWidth = 2.0f;
    self.resultDisplay.layer.cornerRadius = 10;
    self.resultDisplay.clipsToBounds = 10;
    
    for (UIButton *i in self.customButtons) {
        i.clipsToBounds = YES;
        i.layer.cornerRadius = 10;
        i.layer.borderColor = [UIColor whiteColor].CGColor;
        i.layer.borderWidth = 2.0f;
    }
}

- (void) resetAll{
    [self.myCalculator resetAll];
    [self reset];
    self.symbol = nil;
    self.resultDisplay.text = @"0";
}

@end
