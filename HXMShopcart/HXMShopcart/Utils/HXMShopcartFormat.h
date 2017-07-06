//
//  HXMShopcartFormat.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/6.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HXMShopcartFormatDelegate <NSObject>

@required
/**
 请求购物车列表成功之后的回调方法，将装有Model的数组回调到控制器；控制器将其赋给TableView的代理类HXMShopcartTBVProxy并刷新TableView
 
 @param dataArray 数组
 */
- (void)shopcartFormatGetShopcartListDidSuccessWithArray:(NSMutableArray *)dataArray;

/**
  用户在操作了单选、多选、全选、删除这些会改变底部结算视图里边的全选按钮状态、商品总价和商品数的统一回调方法，这条API会将用户操作之后的结果，也就是是否全选、商品总价和和商品总数回调给HXMShopcartController， 控制器拿着这些数据调用底部结算视图BottomView的configure方法并刷新TableView，就完成了UI更新
 
 @param totalPrice 总价
 @param totalCount 总数
 @param isAllSelected 是否全选
 */
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected;

/**
 用户点击结算按钮的回调方法，这条API会将剔除了未选中ProductModel的模型数组回调给HXMShopcartController，但并不改变原数据源因为用户随时可能返回
 
 @param selectedGoods 选中的商品数组
 */
- (void)shopcartFormatSettleForSelectedGoods:(NSArray *)selectedGoods;

/**
 将要删除你选择的商品
 
 @param selectedGoods 选择的数组
 */
- (void)shopcartFormatWillDeleteSelectedGoods:(NSArray *)selectedGoods;

/**
 已全部删除
 */
- (void)shopcartFormatHasDeletedAllGoods;

@end

@interface HXMShopcartFormat : NSObject

/** 代理*/
@property (nonatomic,weak) id<HXMShopcartFormatDelegate>delegate;

/** 请求购物车数据源的方法*/
- (void)getShopcartGoodsList;

/**
 用户选中了某个产品或某个row的处理方法，因为这会改变底部结算视图所以一定会回调上文协议中的第二个方法
 
 @param indexPath indexPath
 @param isSelected 是否选中
 */
- (void)selectGoodsAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;

/**
 用户选中了某个店铺或某个section的处理方法
 
 @param section section
 @param isSelected isSelected
 */
- (void)selectShopAtSection:(NSInteger)section isSelected:(BOOL)isSelected;

/**
 用户改变了商品数量的处理方法
 
 @param indexPath indexPath
 @param count 数量
 */
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

/**
 用户删除操作的处理方法
 
 @param indexPath indexPath
 */
- (void)deleteGoodsAtIndexPath:(NSIndexPath *)indexPath;

/**
 删除选中的商品 (bottomView的删除方法)
 */
- (void)beginToDeleteSelectedGoods;

/**
 删除选中的商品
 
 @param selectedArray 数组
 */
- (void)deleteSelectedGoods:(NSArray *)selectedArray;

/**
 全选
 
 @param isSelected isSelected
 */
- (void)selectAllGoodsWithStatus:(BOOL)isSelected;

/**
 结算
 */
- (void)settleSelectedGoods;

@end
