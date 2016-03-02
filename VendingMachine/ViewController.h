//
//  ViewController.h
//  VendingMachine
//
//  Created by Aaron Erickson on 3/1/16.
//  Copyright © 2016 tgm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VendingMachine.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) VendingMachine *vendingMachine;

@property (nonatomic, strong) UILabel *label;

@end

