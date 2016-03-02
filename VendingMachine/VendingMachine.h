//
//  VendingMachine.h
//  VendingMachine
//
//  Created by Aaron Erickson on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Purchase.h"

#define NICKEL 0
#define DIME 1
#define QUARTER 2
#define OTHER_COIN 3

@interface VendingMachine : NSObject
@property (nonatomic, strong) NSDictionary *productInventory;

@property (nonatomic) int nickelsInInventory;
@property (nonatomic) int dimesInInventory;
@property (nonatomic) int quartersInInventory;

@property (nonatomic) int nickels;
@property (nonatomic) int dimes;
@property (nonatomic) int quarters;
@property (nonatomic) double change;
@property (nonatomic) BOOL returnPreviousCoin;

-(BOOL)coinInsertedAndAccepted:(int)coin;
-(Purchase *)purchaseProductSuccessfully:(NSString *)productName;

@end
