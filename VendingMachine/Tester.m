//
//  Tester.m
//  VendingMachine
//
//  Created by User on 3/2/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import "Tester.h"

@implementation Tester

- (void)runTestCases
{
    [self insertCoinsIntoVendingMachine];
}

- (void)insertCoinsIntoVendingMachine
{
    VendingMachine *vendingMachine = [[VendingMachine alloc] init];
    if (![vendingMachine coinInsertedAndAccepted:NICKEL])
        NSLog(@"Vending machine does not accept nickels");
    
    if (![vendingMachine coinInsertedAndAccepted:DIME])
        NSLog(@"Vending machine does not accept dimes");
    
    if (![vendingMachine coinInsertedAndAccepted:QUARTER])
        NSLog(@"Vending machine does not accept quarters");
    
    if ([vendingMachine coinInsertedAndAccepted:OTHER_COIN])
        NSLog(@"Vending machine accepts other coins");
    
    if ([vendingMachine coinInsertedAndAccepted:453])
        NSLog(@"Vending machine accepts invalid data");
}



@end
