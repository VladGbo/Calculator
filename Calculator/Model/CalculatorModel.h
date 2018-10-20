//
//  CalculatorModel.h
//  Calculator
//
//  Created by r2d2 on 9/26/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorModel : NSObject

//@property (nonatomic, assign) double firstOperand;
//@property (nonatomic,assign) double secondOperand;

@property (nonatomic,assign) double currentOperand;
@property (nonatomic, assign) double result;
@property (nonatomic, assign) BOOL trigerChoiceOperands;
@property (nonatomic, assign,readonly) NSString* madeOperation;
@property (nonatomic, assign) BOOL isError;
@property (nonatomic, assign) BOOL isBothOperands;


- (void) performOperation: (NSString*) mathSymbol;
- (void) resetAll;

@end

NS_ASSUME_NONNULL_END
