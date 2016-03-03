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
    [self purchaseProductFromVendingMachine];
}

- (void)insertCoinsIntoVendingMachine
{
    VendingMachine *vendingMachine = [[VendingMachine alloc] init];
    if (![vendingMachine coinInsertedAndAccepted:NICKEL])
        NSLog(@"Vending machine does not accept nickels");
    if (vendingMachine.change != 0.05)
        NSLog(@"Nickel did not add $0.05 to change");
    if (vendingMachine.nickels != 1)
        NSLog(@"Nickel did not stay in the machine");
    if (vendingMachine.nickelsInInventory != 1)
        NSLog(@"Nickel did not store in inventory");
    
    vendingMachine = nil;
    vendingMachine = [[VendingMachine alloc] init];
    
    if (![vendingMachine coinInsertedAndAccepted:DIME])
        NSLog(@"Vending machine does not accept dimes");
    if (vendingMachine.change != 0.10)
        NSLog(@"Dime did not add $0.10 to change");
    if (vendingMachine.dimes != 1)
        NSLog(@"Dime did not stay in the machine");
    if (vendingMachine.dimesInInventory != 1)
        NSLog(@"Dime did not store in inventory");
    
    vendingMachine = nil;
    vendingMachine = [[VendingMachine alloc] init];
    
    if (![vendingMachine coinInsertedAndAccepted:QUARTER])
        NSLog(@"Vending machine does not accept quarters");
    if (vendingMachine.change != 0.25)
        NSLog(@"Quarter did not add $0.25 to change");
    if (vendingMachine.quarters != 1)
        NSLog(@"Quarter did not stay in the machine");
    if (vendingMachine.quartersInInventory != 1)
        NSLog(@"Quarters did not store in inventory");
    
    vendingMachine = nil;
    vendingMachine = [[VendingMachine alloc] init];
    
    if ([vendingMachine coinInsertedAndAccepted:OTHER_COIN])
        NSLog(@"Vending machine accepts other coins");
    [self verifyTheVendingMachineIgnoredInvalidCoins:vendingMachine];
    
    vendingMachine = nil;
    vendingMachine = [[VendingMachine alloc] init];
    
    if ([vendingMachine coinInsertedAndAccepted:453])
        NSLog(@"Vending machine accepts invalid data");
    [self verifyTheVendingMachineIgnoredInvalidCoins:vendingMachine];
}

- (void)verifyTheVendingMachineIgnoredInvalidCoins:(VendingMachine *)vendingMachine
{
    if (vendingMachine.change > 0)
        NSLog(@"Invalid coin has been added to vending machine change amount.");
    
    if (vendingMachine.quarters > 0 || vendingMachine.quartersInInventory > 0 || vendingMachine.dimes > 0 || vendingMachine.dimesInInventory > 0 || vendingMachine.nickelsInInventory > 0 || vendingMachine.nickels > 0)
        NSLog(@"Invalid coin accepted in the machine");
}

- (void)purchaseProductFromVendingMachine
{
    VendingMachine *vendingMachine = [[VendingMachine alloc] init];
    
    Purchase *purchase = [vendingMachine purchaseProductSuccessfully:@"Product That Does Not Exist"];
    
    if (purchase.success)
        NSLog(@"Invalid product purchased");
    if (purchase.reasonForFailure != SYSTEM_ERROR)
        NSLog(@"Invalid reason for purchase failure");
    
    purchase = nil;
    
    vendingMachine = [VendingMachine refillVendingMachineForTesting:vendingMachine];
    
    for (int i = 0; i < vendingMachine.productInventory.allKeys.count; i++)
    {
        purchase = [[Purchase alloc] init];
        
        Product *product = [vendingMachine.productInventory objectForKey:vendingMachine.productInventory.allKeys[i]];
        purchase = [vendingMachine purchaseProductSuccessfully:product.name];
        
        if (!purchase.success)
            NSLog(@"%@", [NSString stringWithFormat:@"Not able to purchase %@.", product.name]);
        
        purchase = nil;
    }
}





@end
