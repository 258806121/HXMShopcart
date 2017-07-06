//
//  HXMShopcartTBVCell.h
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMShopcartGoodsModel.h"

typedef void(^ShopcartCellSelectedBlock)(BOOL isSelected);
typedef void(^ShopcartCellCountEditBlock)(NSInteger count);

@interface HXMShopcartTBVCell : UITableViewCell

/** 商品选择block*/
@property (nonatomic, copy) ShopcartCellSelectedBlock shopcartCellSelectedBlock;
/** 商品数量编辑block*/
@property (nonatomic, copy) ShopcartCellCountEditBlock shopcartCellCountEditBlock;
/** JVShopcartProductModel*/
@property (nonatomic,strong) HXMShopcartGoodsModel *model;

@end
