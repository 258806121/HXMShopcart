//
//  HXMShopcartShopModel.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartShopModel.h"

@implementation HXMShopcartShopModel

+ (NSDictionary *)objectClassInArray {
    return @{@"goods":[HXMShopcartGoodsModel class]};
}

@end
