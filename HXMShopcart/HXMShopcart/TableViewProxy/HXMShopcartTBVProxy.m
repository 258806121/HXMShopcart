 //
//  HXMShopcartTBVProxy.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartTBVProxy.h"

@implementation HXMShopcartTBVProxy

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HXMShopcartShopModel *shopModel = self.dataArray[section];
    NSArray *goodsArray = shopModel.goods;
    return goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXMShopcartTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMShopcartTBVCell"];
    HXMShopcartShopModel *shopModel = self.dataArray[indexPath.section];
    NSArray *goodsArray = shopModel.goods;
    
    if (goodsArray.count > indexPath.row) {
        cell.model = goodsArray[indexPath.row];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    // 商品选择
    cell.shopcartCellSelectedBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyGoodsSelectedBlock) {
            weakSelf.shopcartProxyGoodsSelectedBlock(isSelected, indexPath);
        }
    };
    
    // 商品数量编辑
    cell.shopcartCellCountEditBlock = ^(NSInteger count){
        if (weakSelf.shopcartProxyChangeCountBlock) {
            weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
    
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HXMShopcartHeaderView *shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HXMShopcartHeaderView"];
    if (self.dataArray.count > section) {
        HXMShopcartShopModel *shopModel = self.dataArray[section];
        
        // 配置头视图的 名字 和 选择按钮的状态
        [shopcartHeaderView configureShopcartHeaderViewWithShopName:shopModel.shopName shopSelect:shopModel.isSelected];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    // 点击section的全选按钮的block
    shopcartHeaderView.shopcartHeaderViewBtnAllSeclectedBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyShopSelectedBlock) {
            weakSelf.shopcartProxyShopSelectedBlock(isSelected, section);
        }
    };
    
    // 点击店铺的block
    shopcartHeaderView.shopcartBtnShopSelectedBlock = ^{
        HXMShopcartShopModel *shopModel = weakSelf.dataArray[section];
        
        if (weakSelf.shopcartProxyShopDetailSelectedBlock) {
            weakSelf.shopcartProxyShopDetailSelectedBlock(shopModel);
        }
    };
    return shopcartHeaderView;
}

/**
 section高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

/**
 tableView编辑
 
 @param tableView tableView
 @param indexPath indexPath
 @return action数组
 */
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyDeletedBlock) {
            self.shopcartProxyDeletedBlock(indexPath);
        }
    }];
    
    return @[deleteAction];
}

@end
