//
//  HXMShopcartShopModel.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <Foundation/Foundation.h>

// model
#import "HXMShopcartGoodsModel.h"

@interface HXMShopcartShopModel : NSObject

/** 店铺地址*/
@property (nonatomic, copy) NSString *shopURL;
/** 店铺id*/
@property (nonatomic, copy) NSString *shopId;
/** 店铺名字*/
@property (nonatomic, copy) NSString *shopName;
/** 商品数组*/
@property (nonatomic, strong) NSMutableArray<HXMShopcartGoodsModel *> *goods;

// **********  自定义  **********

/** 记录相应section是否全选*/
@property (nonatomic, assign) BOOL isSelected;
/** 结算时筛选出选中的商品*/
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end
