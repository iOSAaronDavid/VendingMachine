//
//  ViewController.m
//  VendingMachine
//
//  Created by Aaron Erickson on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label = [[UILabel alloc] init];
    [self.label setFrame:CGRectMake(50, 50, 300, 100)];
    [self.view addSubview:self.label];
    self.label.text = @"INSERT COIN";
    
    self.vendingMachine.productInventory = [Product refillProducts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)didReceiveCoin:(int)coin
{
    if ([self.vendingMachine coinInsertedAndAccepted:coin])
    {
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        self.label.text = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:self.vendingMachine.change]];
        return @"Coin accepted";
    }
    else
    {
        [self returnCoin];
        return @"Coin returned";
    }
    
    return @"Error";
}

- (NSString *)coinReturnedPressed
{
    NSMutableString *coinReturnDisplayMessage = [[NSMutableString alloc] initWithString:@"Return "];
    
    if (self.vendingMachine.quarters > 0)
    {
        [coinReturnDisplayMessage appendString:[NSString stringWithFormat:@" %i quarters ", self.vendingMachine.quarters]];
        self.vendingMachine.quartersInInventory -= self.vendingMachine.quarters;
        self.vendingMachine.quarters = 0;
    }
    
    if (self.vendingMachine.dimes > 0)
    {
        [coinReturnDisplayMessage appendString:[NSString stringWithFormat:@" %i dimes ", self.vendingMachine.dimes]];
        self.vendingMachine.dimesInInventory -= self.vendingMachine.dimes;
        self.vendingMachine.dimes = 0;
    }
    
    if (self.vendingMachine.nickels > 0)
    {
        [coinReturnDisplayMessage appendString:[NSString stringWithFormat:@" %i nickels ", self.vendingMachine.nickels]];
        self.vendingMachine.nickelsInInventory -= self.vendingMachine.nickels;
        self.vendingMachine.nickels = 0;
    }
    
    self.vendingMachine.change = 0;
    
    NSLog(@"%@", coinReturnDisplayMessage);
    return coinReturnDisplayMessage;
}

- (NSString *)didSelectProduct:(NSString *)productName
{
    Purchase *purchase = [self.vendingMachine purchaseProductSuccessfully:productName];
    if (purchase.success)
    {
        self.label.text = @"THANK YOU";
        return @"Product dispensed";
    }
    else
    {
        if (purchase.reasonForFailure == SOLD_OUT)
        {
            self.label.text = @"SOLD OUT";
            return @"Product sold out";
        }
        else if (purchase.reasonForFailure == NOT_ENOUGH_CHANGE)
        {
            NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
            self.label.text = [NSString stringWithFormat:@"PRICE: %@", [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:self.vendingMachine.change]]];
            return @"Not enough change";
        }
        else if (purchase.reasonForFailure == EXACT_CHANGE_ONLY)
        {
            self.label.text = @"EXACT CHANGE ONLY";
            return @"Exact change only";
        }
    }
    return @"Error";
}

- (void)returnCoin
{
    NSLog(@"Coin returned");
}



@end
