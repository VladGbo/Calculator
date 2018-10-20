//
//  HistoryViewController.m
//  Calculator
//
//  Created by r2d2 on 10/4/18.
//  Copyright © 2018 r2d2. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *displayHistory;

-(NSString*) prepareHistory:(NSArray*) history;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    NSArray* ar = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyOperations"];
    
    self.displayHistory.text = [self prepareHistory:ar];
}

-(NSString*) prepareHistory:(NSArray*) history{
    NSMutableString* useForBildStr = [NSMutableString new];
    
    for (NSString* i in history){
        [useForBildStr appendString:i];
        [useForBildStr appendString:@"\n"];
        [useForBildStr appendString:@"\n"];
    }
    
    NSString* result = useForBildStr;
    return result;
}


@end
