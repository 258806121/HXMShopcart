//
//  ViewController.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "ViewController.h"

// VC
#import "HXMShopcartController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 加入购物车

 @param sender sender
 */
- (IBAction)pushToShopcart:(id)sender
{
    HXMShopcartController *vc = [[HXMShopcartController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
