//
//  Product.h
//  VendingMachine
//
//  Created by Aaron Erickson on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int quantity;
@property (nonatomic) double price;

+(NSDictionary *)refillProducts;

@end
