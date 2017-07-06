//
//  HXMShopcartGoodsModel.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXMShopcartGoodsModel : NSObject

/** 添加日期*/
@property (nonatomic, copy) NSString *addDate;
/** 店铺id*/
@property (nonatomic, copy) NSString *shopId;
/** 店铺名*/
@property (nonatomic, copy) NSString *shopName;
/** 店铺图片URL*/
@property (nonatomic, copy) NSString *shopPicUrl;
/** 购物车id*/
@property (nonatomic, copy) NSString *cartId;
/** 原价钱*/
@property (nonatomic, assign) NSInteger originPrice;
/** 商品颜色*/
@property (nonatomic, copy) NSString *goodsColor;
/** 商品id*/
@property (nonatomic, copy) NSString *goodsId;
/** 名字*/
@property (nonatomic, copy) NSString *goodsName;
/** 商品数量*/
@property (nonatomic, assign) NSInteger goodsNum;
/** 商品图片url*/
@property (nonatomic, copy) NSString *goodsPicUrl;
/** 价钱*/
@property (nonatomic, assign) NSInteger goodsPrice;
/** 库存*/
@property (nonatomic, assign) NSInteger goodsStocks;
/** 商品样式*/
@property (nonatomic, copy) NSString *goodsStyle;
/** 商品类型*/
@property (nonatomic, copy) NSString *goodsType;
/** 尺码*/
@property (nonatomic, copy) NSString *goodsSize;

// ********** 自定义 **********
/** 记录相应row是否选中（自定义)*/
@property(nonatomic, assign) BOOL isSelected;

@end
