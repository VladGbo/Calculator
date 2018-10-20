//
//  UnaryOperation.h
//  Calculator
//
//  Created by r2d2 on 10/8/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Unary : NSObject
@property (nonatomic, assign) BOOL isError;
@property (nonatomic, assign) NSString* symbol;

- (double) performUnaryOperation: (NSString*) mathSymbol;
- (void) appendOperand:(double) value;
- (NSMutableArray*) previouslyOperation;
- (void) resetAll;

@end

NS_ASSUME_NONNULL_END
