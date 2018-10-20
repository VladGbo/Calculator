//
//  BinaryOeration.h
//  Calculator
//
//  Created by r2d2 on 10/3/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Binary : NSObject
@property (assign, nonatomic) NSString* symbol;
@property (assign, nonatomic) BOOL isError;
@property (assign, nonatomic) BOOL trigerForOperands;


- (NSMutableArray*) previouslyOperation;
- (void) appendOperand:(double) value;
- (double) performBinaryOperation: (NSString*) mathSymbol;
- (void) resetAll;
@end

NS_ASSUME_NONNULL_END
