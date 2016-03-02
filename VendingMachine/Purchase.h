//
//  Purchase.h
//  VendingMachine
//
//  Created by User on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOT_ENOUGH_CHANGE 0
#define SOLD_OUT 1
#define EXACT_CHANGE_ONLY 2
#define SYSTEM_ERROR 3

@interface Purchase : NSObject
@property (nonatomic) BOOL success;
@property (nonatomic) int reasonForFailure;
@property (nonatomic) double changeReturn;
@property (nonatomic) int quartersToReturn;
@property (nonatomic) int dimesToReturn;
@property (nonatomic) int nickelsToReturn;
@end
