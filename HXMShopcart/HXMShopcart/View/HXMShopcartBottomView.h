//
//  HXMShopcartBottomView.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 全选block*/
typedef void(^ShopcartBottomViewAllSelectedBlock)(BOOL isSelected);
/** 结算block*/
typedef void(^ShopcartBottomViewSettledBlock)(void);
/** 删除block*/
typedef void(^ShopcartBottomViewDeletedBlock)(void);

@interface HXMShopcartBottomView : UIView

/** 全选block*/
@property (nonatomic, copy) ShopcartBottomViewAllSelectedBlock shopcartBottomViewAllSelectedBlock;
/** 结算block*/
@property (nonatomic, copy) ShopcartBottomViewSettledBlock shopcartBottomViewSettledBlock;
/** 删除block*/
@property (nonatomic, copy) ShopcartBottomViewDeletedBlock shopcartBottomViewDeletedBlock;

/**
 根据 总价钱,总数,是否全选,配置bottomView
 
 @param totalPrice 总价钱
 @param totalCount 总数
 @param isAllSelected 是否全选
 */
- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected;

/**
 改变bottomView的状态
 
 @param status status
 */
- (void)changeShopcartBottomViewWithStatus:(BOOL)status;

@end
