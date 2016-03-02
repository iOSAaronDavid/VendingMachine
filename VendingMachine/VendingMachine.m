//
//  VendingMachine.m
//  VendingMachine
//
//  Created by Aaron Erickson on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import "VendingMachine.h"

@implementation VendingMachine

-(BOOL)coinInsertedAndAccepted:(int)coin
{
    if (coin == OTHER_COIN)
    {
        self.returnPreviousCoin = YES;
        return NO;
    }
    
    if (coin == NICKEL)
    {
        self.nickels++;
        self.nickelsInInventory++;
        self.change += 0.05;
    }
    else if (coin == DIME)
    {
        self.dimes++;
        self.dimesInInventory++;
        self.change += 0.10;
    }
    else if (coin == QUARTER)
    {
        self.quarters++;
        self.quartersInInventory++;
        self.change += 0.25;
    }
    else
    {
        return NO;
    }
    
    return YES;
}

-(Purchase *)purchaseProductSuccessfully:(NSString *)productName
{
    Purchase *purchase = [[Purchase alloc] init];
    
    if ([self.productInventory objectForKey:productName] != nil)
    {
        Product *selectedProduct = [self.productInventory objectForKey:productName];
        purchase = [self validatePurchase:selectedProduct];
    }
    else
    {
        purchase.success = NO;
        purchase.reasonForFailure = SYSTEM_ERROR;
    }
    
    return purchase;
}

-(Purchase *)validatePurchase:(Product *)selectedProduct
{
    Purchase *purchase = [[Purchase alloc] init];
    
    if (selectedProduct.quantity == 0)
    {
        purchase.success = NO;
        purchase.reasonForFailure = SOLD_OUT;
        purchase.changeReturn = 0;
        return purchase;
    }
    
    if (selectedProduct.price <= self.change)
    {
        double possibleChangeReturn = self.change - selectedProduct.price;
        
        if (possibleChangeReturn != 0)
        {
            purchase = [self getCoinsToReturn:possibleChangeReturn withPurchase:purchase];
        }
        
        purchase.changeReturn = self.change - selectedProduct.price;
        purchase.success = YES;
        purchase.reasonForFailure = -1;
    }
    else
    {
        purchase.success = NO;
        purchase.reasonForFailure = NOT_ENOUGH_CHANGE;
        purchase.changeReturn = 0;
    }
    
    return purchase;
}

-(Purchase *)getCoinsToReturn:(double)possibleChangeReturn withPurchase:(Purchase *)purchase
{
    double totalAvailbleChange = self.quartersInInventory * 0.25 + self.dimesInInventory * 0.10 + self.nickelsInInventory * 0.05;
    if (totalAvailbleChange >= possibleChangeReturn)
    {
        double changeTotal = 0;
        
        int quartersAvailable = self.quartersInInventory;
        int dimesAvailable = self.dimesInInventory;
        int nickelsAvailable = self.nickelsInInventory;
        
        
        while (self.quartersInInventory > 0)
        {
            changeTotal += 0.25;
            
            if (changeTotal > possibleChangeReturn)
            {
                changeTotal -= 0.25;
                break;
            }
            
            quartersAvailable--;
            purchase.quartersToReturn++;
        }
        
        while (self.dimesInInventory > 0)
        {
            changeTotal += 0.10;
            
            if (changeTotal > possibleChangeReturn)
            {
                changeTotal -= 0.05;
                break;
            }
            
            dimesAvailable--;
            purchase.dimesToReturn++;
        }
        
        while (self.nickelsInInventory > 0)
        {
            changeTotal += 0.05;
            
            if (changeTotal > possibleChangeReturn)
            {
                changeTotal -= 0.05;
                break;
            }
            
            nickelsAvailable--;
            purchase.nickelsToReturn++;
        }
        
        if (changeTotal == possibleChangeReturn)
        {
            purchase.success = YES;
            return purchase;
        }
    }
    
    purchase.success = NO;
    purchase.reasonForFailure = EXACT_CHANGE_ONLY;
    purchase.changeReturn = 0;
    
    return purchase;
}

@end
