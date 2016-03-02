//
//  Product.m
//  VendingMachine
//
//  Created by Aaron Erickson on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import "Product.h"

@implementation Product

+(NSDictionary *)refillProducts
{
    NSMutableDictionary *allProducts = [[NSMutableDictionary alloc] init];
    
    Product *product = [[Product alloc] init];
    product.name = @"Cola";
    product.quantity = 5;
    product.price = 1; // $1.00
    [allProducts setObject:product forKey:product.name];
    product = nil;
    
    product.name = @"Chips";
    product.quantity = 7;
    product.price = 0.5; // $0.50
    [allProducts setObject:product forKey:product.name];
    product = nil;
    
    product.name = @"Candy";
    product.quantity = 9;
    product.price = 0.65; // $0.65
    [allProducts setObject:product forKey:product.name];
    product = nil;
    
    NSDictionary *refilledProducts = [NSDictionary dictionaryWithDictionary:allProducts];
    return refilledProducts;
}

@end
