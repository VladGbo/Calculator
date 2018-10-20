//
//  CalculatorModel.m
//  Calculator
//
//  Created by r2d2 on 9/26/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import "CalculatorModel.h"
#import "Binary.h"
#import "Unary.h"
#define RADIANS(degrees) (degrees * M_PI / 180)


typedef double (^UnaryOperations)(double value);
typedef double (^BinaryOperations)(double a, double b);
typedef enum: NSUInteger {
    UnaryOperation,
    BinaryOperation,
    OperationEquil,
    DefaultSituation
} Operation;


@interface CalculatorModel()
@property (strong, nonatomic) Unary* calculationUnaryOperation;
@property(strong, nonatomic) Binary* calculationBinaryOperation;


-(double) calculateFactorial: (double) value;
- (NSString*) createStrHistory: (NSArray*) operation and: (double) result;
- (void) getResult;
@end

@implementation CalculatorModel
-(Unary*) calculationUnaryOperation{
    if (!_calculationUnaryOperation){
        _calculationUnaryOperation = [Unary new];
    }
    return _calculationUnaryOperation;
}

-(Binary*) calculationBinaryOperation{
    if(!_calculationBinaryOperation){
        _calculationBinaryOperation = [Binary new];
    }
    return _calculationBinaryOperation;
}

- (Operation) TypeOfOperation: (NSString*) mathSymbol{
    NSArray *binaryOperators = @[@"+", @"−", @"×", @"÷", @"˄"];
    NSArray *unaryOperators = @[@"sin", @"cos", @"tan", @"√", @"x!", @"log₂", @"x²"];
    NSString *operatorEquil = @"=";
    if ([binaryOperators containsObject:mathSymbol]){
        return BinaryOperation;
    }
    if ([unaryOperators containsObject:mathSymbol]){
        return UnaryOperation;
    }
    if ([mathSymbol isEqualToString:operatorEquil]){
        return OperationEquil;
    }
    return DefaultSituation;
}

- (void) performOperation: (NSString*) mathSymbol{
    Operation op = [self TypeOfOperation:mathSymbol];
    switch (op) {
            
        case UnaryOperation:
            [self.calculationUnaryOperation appendOperand:self.currentOperand];
            self.result = [self.calculationUnaryOperation performUnaryOperation:mathSymbol];
            self.calculationUnaryOperation.symbol = mathSymbol;
            if (self.calculationUnaryOperation.isError){
                self.isError = self.calculationUnaryOperation.isError;
                self.calculationUnaryOperation.isError = NO;
            } else {
                _madeOperation = [self createStrHistory:[self.calculationUnaryOperation previouslyOperation] and:self.result];
            }
            break;
            
        case BinaryOperation:
            if (!self.calculationBinaryOperation.trigerForOperands){
                [self.calculationBinaryOperation appendOperand:self.currentOperand];
                self.isError = YES;
            } else {
                [self.calculationBinaryOperation appendOperand:self.currentOperand];
                self.isBothOperands = YES;
                self.result = [self.calculationBinaryOperation performBinaryOperation:mathSymbol];
                self.calculationBinaryOperation.symbol = mathSymbol; // это костыль
                if (self.calculationBinaryOperation.isError){
                    self.isError = self.calculationBinaryOperation.isError;
                    self.calculationBinaryOperation.isError = NO;
                } else {
                    _madeOperation = [self createStrHistory:[self.calculationBinaryOperation previouslyOperation] and:self.result];
                }
                [self getResult];
            }
            break;
            
        case OperationEquil:
            [self getResult];
            break;
            
        default:
            break;
    }
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

- (NSString*) createStrHistory: (NSArray*) operation and: (double) result{
    
    NSMutableString *convertOperation = [NSMutableString new];
    
    for (NSString* i in operation){
        [convertOperation appendString:i];
        [convertOperation appendString:@" "];
    }
    
    [convertOperation appendString:@"= "];
    [convertOperation appendString:@(self.result).stringValue];
    return convertOperation;
}

- (void) getResult{
    self.calculationBinaryOperation.trigerForOperands = NO;
    [self.calculationBinaryOperation appendOperand:self.result];
}

- (void) resetAll{
    [self.calculationUnaryOperation resetAll];
    [self.calculationBinaryOperation resetAll];
    self.currentOperand = 0;
    self.result = 0;
    self.trigerChoiceOperands = NO;
    self.isError = NO;
    self.isBothOperands = NO;
}

@end
