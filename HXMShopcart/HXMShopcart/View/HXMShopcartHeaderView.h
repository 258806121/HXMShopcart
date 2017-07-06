//
//  HXMShopcartHeaderView.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartHeaderViewBtnAllSeclectedBlock)(BOOL isSelected);
typedef void(^ShopcartBtnShopSelectedBlock)();

@interface HXMShopcartHeaderView : UITableViewHeaderFooterView

/** 头视图的全选按钮block*/
@property (nonatomic, copy) ShopcartHeaderViewBtnAllSeclectedBlock shopcartHeaderViewBtnAllSeclectedBlock;
/** 店铺按钮block*/
@property (nonatomic, copy) ShopcartBtnShopSelectedBlock shopcartBtnShopSelectedBlock;

/**
 配置头视图 (店铺名字,店铺的选择状态)
 
 @param shopName 店铺名字
 @param shopSelect 店铺的选择状态
 */
- (void)configureShopcartHeaderViewWithShopName:(NSString *)shopName
                                     shopSelect:(BOOL)shopSelect;

@end
