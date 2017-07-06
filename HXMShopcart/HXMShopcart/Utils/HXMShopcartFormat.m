//
//  HXMShopcartFormat.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/6.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartFormat.h"

@interface HXMShopcartFormat ()

/**< 购物车数据源 (店铺的model数组)*/
@property (nonatomic, strong) NSMutableArray *arrShopModels;

@end

@implementation HXMShopcartFormat

#pragma mark - NetWorkingList

/**
 获取购物车的数据列表
 */
- (void)getShopcartGoodsList
{
    // 本地请求
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopcart.plist" ofType:nil];
    NSMutableArray *arrData = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.arrShopModels = [HXMShopcartShopModel mj_objectArrayWithKeyValuesArray:arrData];
    
    // 成功之后的回调
    [self.delegate shopcartFormatGetShopcartListDidSuccessWithArray:self.arrShopModels];
}

/**
 选中商品
 
 @param indexPath indexPath
 @param isSelected 是否选中
 */
- (void)selectGoodsAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected
{
    HXMShopcartShopModel *shopModel = self.arrShopModels[indexPath.section];
    HXMShopcartGoodsModel *goodsModel = shopModel.goods[indexPath.row];
   
    goodsModel.isSelected = isSelected;
    
    BOOL isShopSelected = YES;
    
    for (HXMShopcartGoodsModel *aGoodsModel in shopModel.goods) {
        if (aGoodsModel.isSelected == NO) {
            isShopSelected = NO;
        }
    }
    
    shopModel.isSelected = isShopSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice]
                                           totalCount:[self accountTotalCount]
                                        isAllSelected:[self isAllSelected]];
}

/**
 选中品牌
 
 @param section section
 @param isSelected 是否选中
 */
- (void)selectShopAtSection:(NSInteger)section isSelected:(BOOL)isSelected
{
    HXMShopcartShopModel *shopModel = self.arrShopModels[section];
    
    shopModel.isSelected = isSelected;
    
    for (HXMShopcartGoodsModel *aGoodsModel in shopModel.goods) {
        aGoodsModel.isSelected = shopModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice]
                                           totalCount:[self accountTotalCount]
                                        isAllSelected:[self isAllSelected]];
}

/**
 更改购物车中商品数量
 
 @param indexPath indexPath
 @param count 数量
 */
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    HXMShopcartShopModel *shopModel = self.arrShopModels[indexPath.section];
   
    HXMShopcartGoodsModel *goodsModel = shopModel.goods[indexPath.row];
    
    if (count <= 0) {
        count = 1;
    } else if (count > goodsModel.goodsStocks) {
        count = goodsModel.goodsStocks;
    }
    
    //根据请求结果决定是否改变数据
    goodsModel.goodsNum = count;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice]
                                           totalCount:[self accountTotalCount]
                                        isAllSelected:[self isAllSelected]];
}

/**
 删除商品
 
 @param indexPath indexPath
 */
- (void)deleteGoodsAtIndexPath:(NSIndexPath *)indexPath
{
    HXMShopcartShopModel *shopModel = self.arrShopModels[indexPath.section];
    
    HXMShopcartGoodsModel *goodsModel = shopModel.goods[indexPath.row];
    
    //根据请求结果决定是否删除
    [shopModel.goods removeObject:goodsModel];
    if (shopModel.goods.count == 0) {
        [self.arrShopModels removeObject:shopModel];
    } else {
        if (!shopModel.isSelected) {
            BOOL isShopSelected = YES;
            for (HXMShopcartGoodsModel *aGoodsModel in shopModel.goods) {
                if (!aGoodsModel.isSelected) {
                    isShopSelected = NO;
                    break;
                }
            }
            
            if (isShopSelected) {
                shopModel.isSelected = YES;
            }
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice]
                                           totalCount:[self accountTotalCount]
                                        isAllSelected:[self isAllSelected]];
    
    if (self.arrShopModels.count == 0) {
        [self.delegate shopcartFormatHasDeletedAllGoods];
    }
}

- (void)beginToDeleteSelectedGoods
{
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        for (HXMShopcartGoodsModel *goodsModel in shopModel.goods) {
            if (goodsModel.isSelected) {
                [selectedArray addObject:goodsModel];
            }
        }
    }
    
    [self.delegate shopcartFormatWillDeleteSelectedGoods:selectedArray];
}

/**
 删除选中的一组商品
 
 @param selectedArray 选中的数组
 */
- (void)deleteSelectedGoods:(NSArray *)selectedArray
{
    //网络请求
    //根据请求结果决定是否批量删除
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        [shopModel.goods removeObjectsInArray:selectedArray];
        
        if (shopModel.goods.count == 0) {
            [emptyArray addObject:shopModel];
        }
    }
    
    if (emptyArray.count) {
        [self.arrShopModels removeObjectsInArray:emptyArray];
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice]
                                           totalCount:[self accountTotalCount]
                                        isAllSelected:[self isAllSelected]];
    
    if (self.arrShopModels.count == 0) {
        [self.delegate shopcartFormatHasDeletedAllGoods];
    }
}

/**
 全选
 
 @param isSelected 是否选中
 */
- (void)selectAllGoodsWithStatus:(BOOL)isSelected
{
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        shopModel.isSelected = isSelected;
        for (HXMShopcartGoodsModel *goodsModel in shopModel.goods) {
            goodsModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice]
                                           totalCount:[self accountTotalCount]
                                        isAllSelected:[self isAllSelected]];
}

/**
 结算选中的商品
 */
- (void)settleSelectedGoods
{
    NSMutableArray *settleArray = [[NSMutableArray alloc] init];
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        
        // 选中的商品数组
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (HXMShopcartGoodsModel *goodsModel in shopModel.goods) {
            if (goodsModel.isSelected) {
                [selectedArray addObject:goodsModel];
            }
        }
        
        shopModel.selectedArray = selectedArray;
        
        if (selectedArray.count) {
            [settleArray addObject:shopModel];
        }
    }
    
    [self.delegate shopcartFormatSettleForSelectedGoods:settleArray];
}

#pragma mark private methods

/**
 总价
 
 @return totalPrice
 */
- (float)accountTotalPrice
{
    float totalPrice = 0.f;
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        for (HXMShopcartGoodsModel *goodsModel in shopModel.goods) {
            if (goodsModel.isSelected) {
                totalPrice += goodsModel.goodsPrice * goodsModel.goodsNum;
            }
        }
    }
    
    return totalPrice;
}

/**
 总数量
 
 @return totalCount
 */
- (NSInteger)accountTotalCount
{
    NSInteger totalCount = 0;
    
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        for (HXMShopcartGoodsModel *goodsModel in shopModel.goods) {
            if (goodsModel.isSelected) {
                totalCount += goodsModel.goodsNum;
            }
        }
    }
    
    return totalCount;
}

/**
 是否全选
 
 @return isAllSelected
 */
- (BOOL)isAllSelected
{
    if (self.arrShopModels.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (HXMShopcartShopModel *shopModel in self.arrShopModels) {
        if (shopModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}

@end
