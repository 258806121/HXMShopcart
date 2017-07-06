//
//  HXMShopcartTBVProxy.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HXMShopcartShopModel;

/**
 选中商品
 
 @param isSelected 是否选中
 @param indexPath indexPath
 */
typedef void(^ShopcartProxyGoodsSelectedBlock)(BOOL isSelected, NSIndexPath *indexPath);

/**
 选中店铺
 
 @param isSelected 是否选中
 @param section section
 */
typedef void(^ShopcartProxyShopSelectedBlock)(BOOL isSelected, NSInteger section);

/**
 更改数量
 
 @param count 数量
 @param indexPath indexPath
 */
typedef void(^ShopcartProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath);

/**
 左滑删除商品
 
 @param indexPath indexPath
 */
typedef void(^ShopcartProxyDeletedBlock)(NSIndexPath *indexPath);

/**
 点击店铺跳转到店铺地址
 
 @param model model
 */
typedef void(^ShopcartProxyShopDetailSelectedBlock)(HXMShopcartShopModel *model);

@interface HXMShopcartTBVProxy : NSObject<
UITableViewDelegate,
UITableViewDataSource>

/**< 购物车数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 商品选择 */
@property (nonatomic, copy) ShopcartProxyGoodsSelectedBlock shopcartProxyGoodsSelectedBlock;
/** 店铺选择 */
@property (nonatomic, copy) ShopcartProxyShopSelectedBlock shopcartProxyShopSelectedBlock;
/** 改变数量 */
@property (nonatomic, copy) ShopcartProxyChangeCountBlock shopcartProxyChangeCountBlock;
/** 左滑删除商品 */
@property (nonatomic, copy) ShopcartProxyDeletedBlock shopcartProxyDeletedBlock;
/** 点击店铺跳转到店铺地址 */
@property (nonatomic, copy) ShopcartProxyShopDetailSelectedBlock shopcartProxyShopDetailSelectedBlock;

@end
