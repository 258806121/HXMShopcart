//
//  HXMShopcartCountView.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCountViewEditBlock)(NSInteger count);

@interface HXMShopcartCountView : UIView

/** 数量编辑block*/
@property (nonatomic, copy) ShopcartCountViewEditBlock shopcartCountViewEditBlock;

/**
 根据商品数 与 库存数 判断,可以购买的数量
 
 @param goodsCount 商品数
 @param goodsStock 库存数
 */
- (void)configureShopcartCountViewWithGoodsCount:(NSInteger)goodsCount
                                      goodsStock:(NSInteger)goodsStock;

@end
