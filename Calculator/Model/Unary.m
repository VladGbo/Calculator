//
//  UnaryOperation.m
//  Calculator
//
//  Created by r2d2 on 10/8/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import "Unary.h"
#define RADIANS(degrees) (degrees * M_PI / 180)

typedef double(^unaryOperation)(double value);

@interface Unary()

@property (nonatomic, assign) double operand;

-(double) calculateFactorial: (double) value;

-(NSDictionary*) unaryOperation;

@end

@implementation Unary

-(double) performUnaryOperation: (NSString*) mathSymbol {
    unaryOperation res = [self unaryOperation] [mathSymbol];
    return res(self.operand);
}

-(NSDictionary*) unaryOperation{
    return @{
             @"sin":^(double value){
                 return sin(RADIANS(value));
             },
             @"cos":^(double value){
                 return cos(RADIANS(value));
             },
             @"tan":^(double value){
                 return tan(RADIANS(value));
             },
             @"√":^(double value){
                 if (value < 0){
                     self.isError = YES;
                 }
                 return sqrt(value);
             },
             @"x!":^(double value){
                 if (value < 0){
                     self.isError = YES;
                 }
                 return [self calculateFactorial:value];
             },
             @"log₂":^(double value){
                 if (value < 1){
                     self.isError = YES;
                 }
                 return log2(value);
             },
             @"x²":^(double value){
                 return pow(value, 2);
             }
             };
}

-(void) appendOperand:(double) value{
    self.operand = value;
}

-(double) calculateFactorial: (double) value{
    if (value == 0){
        return 1;
    } else {
        int sum = 1;
        int intVal = (int) value;
        for (int i = 1; i <= intVal; i++){
            sum *= i;
        }
        return (double) sum;
    }
}
- (NSMutableArray*) previouslyOperation{
    NSMutableArray* res = [NSMutableArray new];
    [res addObject:self.symbol];
    [res addObject:@(self.operand).stringValue];
    return res;
}

- (void) resetAll{
    self.isError = NO;
    self.symbol = @"";
    self.operand = 0;
}

@end
