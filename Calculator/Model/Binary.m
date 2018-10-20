//
//  BinaryOeration.m
//  Calculator
//
//  Created by r2d2 on 10/3/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import "Binary.h"

typedef double(^binaryOperation)(double a, double b);

@interface Binary()
@property(assign, nonatomic) double secondOperand;
@property (assign, nonatomic) double firstOperand;


-(NSDictionary*) binaryOperation;


@end

@implementation Binary

-(double) performBinaryOperation: (NSString*) mathSymbol{
    if (self.firstOperand && self.secondOperand){
        binaryOperation res = [self binaryOperation] [mathSymbol];
        return res(self.firstOperand, self.secondOperand);
    } else if (!self.firstOperand && self.secondOperand){
        binaryOperation res = [self binaryOperation] [mathSymbol];
        return res(0, self.secondOperand);
    } else {
        self.isError = YES;
        return 0;
    }
}

-(NSDictionary*) binaryOperation{
    return @{
             @"+":^(double a, double b){
                 return a + b;
             },
             @"−":^(double a, double b){
                     return a - b;
             },
             @"×":^(double a, double b){
                     return a * b;
             },
             @"÷":^(double a, double b){
                 if (b == 0){
                     self.isError = YES;
                 }
                     return a / b;
             },
             @"˄":^(double a, double b){
                 return pow(a, b);
             }
             };
}


-(void) appendOperand:(double) value{
    if(!self.trigerForOperands){
        self.firstOperand = value;
        _trigerForOperands = YES;
    } else {
        self.secondOperand = value;
    }
}

- (NSMutableArray*) previouslyOperation{
    NSMutableArray* res = [NSMutableArray new];
    [res addObject:@(self.firstOperand).stringValue];
    [res addObject:self.symbol];
    [res addObject:@(self.secondOperand).stringValue];
    return res;
}

- (void) resetAll{
    self.symbol = @"";
    self.isError = NO;
    self.trigerForOperands = NO;
    self.firstOperand = 0;
    self.secondOperand = 0;
}
@end
