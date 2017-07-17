//
//  HXMShopcartController.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartController.h"

@interface HXMShopcartController ()<
HXMShopcartFormatDelegate,
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

/**< 购物车列表 */
@property (nonatomic, strong) UITableView *tableView;
/**< 购物车底部视图 */
@property (nonatomic, strong) HXMShopcartBottomView *shopcartBottomView;
/**< 负责购物车逻辑处理 */
@property (nonatomic, strong) HXMShopcartFormat *shopcartFormat;
/**< 编辑按钮 */
@property (nonatomic, strong) UIButton *btnEdited;
/**< 购物车数据源 */
@property (nonatomic, strong) NSMutableArray *arrShopModels;

@end

@implementation HXMShopcartController

#pragma makr - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDataAndUI];       // Data & UI
    [self getShopcartListData]; // get Data
}

#pragma mark - Data & UI

/**
 Data & UI
 */
- (void)initDataAndUI
{
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    // addSubview
    [self addSubview];
    // layout
    [self layoutSubview];
    
}

#pragma mark - getter
/**
 右上角编辑按钮
 */
- (UIButton *)btnEdited
{
    if (_btnEdited == nil) {
        _btnEdited = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnEdited.frame = CGRectMake(0, 0, 40, 40);
        [_btnEdited setTitle:@"编辑" forState:UIControlStateNormal];
        [_btnEdited setTitle:@"完成" forState:UIControlStateSelected];
        [_btnEdited setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _btnEdited.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnEdited addTarget:self action:@selector(btnEditedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEdited;
}

/**
 table
 */

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        // 注册cell
        [_tableView registerClass:[HXMShopcartTBVCell class] forCellReuseIdentifier:@"HXMShopcartTBVCell"];
        // 注册头视图
        [_tableView registerClass:[HXMShopcartHeaderView class] forHeaderFooterViewReuseIdentifier:@"HXMShopcartHeaderView"];
        
        // 代理人
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        // 行高
        _tableView.rowHeight = 140;
        _tableView.sectionFooterHeight = 10;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _tableView;
}

/**
 HXMShopcartFormat
 */
- (HXMShopcartFormat *)shopcartFormat
{
    if (_shopcartFormat == nil) {
        _shopcartFormat = [[HXMShopcartFormat alloc] init];
        _shopcartFormat.delegate = self;
    }
    return _shopcartFormat;
}

/**
 购物车底部视图
 */
- (HXMShopcartBottomView *)shopcartBottomView
{
    if (_shopcartBottomView == nil) {
        // 初始化底部视图
        _shopcartBottomView = [[HXMShopcartBottomView alloc] init];
        
        __weak typeof(self) ws = self;
        
        // 全选
        _shopcartBottomView.shopcartBottomViewAllSelectedBlock = ^(BOOL isSelected){
            [ws.shopcartFormat selectAllGoodsWithStatus:isSelected];
        };
        
        // 结算
        _shopcartBottomView.shopcartBottomViewSettledBlock = ^(){
            [ws.shopcartFormat settleSelectedGoods];
        };
        
        // 删除
        _shopcartBottomView.shopcartBottomViewDeletedBlock = ^(){
            [ws.shopcartFormat beginToDeleteSelectedGoods];
        };
    }
    return _shopcartBottomView;
}

/**
 添加视图
 */
- (void)addSubview
{
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnEdited];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.shopcartBottomView];
}

/**
 layoutSubview
 */
- (void)layoutSubview
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.shopcartBottomView.mas_top);
    }];
    
    [self.shopcartBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
}

#pragma mark - Method & Action

/**
 编辑按钮方法
 */
- (void)btnEditedAction
{
    self.btnEdited.selected = !self.btnEdited.isSelected;
    [self.shopcartBottomView changeShopcartBottomViewWithStatus:self.btnEdited.isSelected];
}

#pragma mark - DZNEmptyDataSetSource 实现方法

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -44;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"购物车空空如也 ^_^";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - UITableViewDelegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrShopModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HXMShopcartShopModel *shopModel = self.arrShopModels[section];
    NSArray *goodsArray = shopModel.goods;
    return goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXMShopcartTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMShopcartTBVCell"];
    HXMShopcartShopModel *shopModel = self.arrShopModels[indexPath.section];
    NSArray *goodsArray = shopModel.goods;
    
    if (goodsArray.count > indexPath.row) {
        cell.model = goodsArray[indexPath.row];
    }
    
    __weak typeof(self) ws = self;
    
    // 商品选择
    cell.shopcartCellSelectedBlock = ^(BOOL isSelected){
        [ws.shopcartFormat selectGoodsAtIndexPath:indexPath isSelected:isSelected];
    };
    
    // 商品数量编辑
    cell.shopcartCellCountEditBlock = ^(NSInteger count){
        [ws.shopcartFormat changeCountAtIndexPath:indexPath count:count];
    };
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HXMShopcartHeaderView *shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HXMShopcartHeaderView"];
    if (self.arrShopModels.count > section) {
        HXMShopcartShopModel *shopModel = self.arrShopModels[section];
        
        // 配置头视图的 名字 和 选择按钮的状态
        [shopcartHeaderView configureShopcartHeaderViewWithShopName:shopModel.shopName shopSelect:shopModel.isSelected];
    }
    
    __weak typeof(self) ws = self;
    
    // 点击section的全选按钮的block
    shopcartHeaderView.shopcartHeaderViewBtnAllSeclectedBlock = ^(BOOL isSelected){
        [ws.shopcartFormat selectShopAtSection:section isSelected:isSelected];
    };
    
    // 点击店铺的block
    shopcartHeaderView.shopcartBtnShopSelectedBlock = ^{
        HXMShopcartShopModel *shopModel = ws.arrShopModels[section];
        NSLog(@"-----%@",shopModel.shopURL);
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
    __weak typeof(self) ws = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要删除这个宝贝吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ws.shopcartFormat deleteGoodsAtIndexPath:indexPath];
        }]];
        [ws presentViewController:alert animated:YES completion:nil];
        
        }
    ];
    
    return @[deleteAction];
}

#pragma mark - HXMShopcartFormatDelegate

/**
 请求购物车列表成功之后的回调方法，将装有Model的数组回调到控制器；控制器将其赋给TableView的代理类HXMShopcartTBVProxy并刷新TableView
 
 @param dataArray 数组
 */
- (void)shopcartFormatGetShopcartListDidSuccessWithArray:(NSMutableArray *)dataArray
{
    self.arrShopModels = dataArray;
    [self.tableView reloadData];
}

/**
 用户在操作了单选、多选、全选、删除这些会改变底部结算视图里边的全选按钮状态、商品总价和商品数的统一回调方法，这条API会将用户操作之后的结果，也就是是否全选、商品总价和和商品总数回调给HXMShopcartController， 控制器拿着这些数据调用底部结算视图BottomView的configure方法并刷新TableView，就完成了UI更新
 
 @param totalPrice 总价
 @param totalCount 总数
 @param isAllSelected 是否全选
 */
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected
{
    [self.shopcartBottomView configureShopcartBottomViewWithTotalPrice:totalPrice
                                                            totalCount:totalCount
                                                         isAllselected:isAllSelected];
    [self.tableView reloadData];
}

/**
 结算
 
 @param selectedGoods 选中的商品数组
 */
- (void)shopcartFormatSettleForSelectedGoods:(NSArray *)selectedGoods
{
    NSLog(@"--- 结算选中的商品 ---");
    NSLog(@"-----%@",selectedGoods);
    
    for (HXMShopcartShopModel *model in selectedGoods ) {
        for (HXMShopcartGoodsModel *pModel in model.goods) {
            NSLog(@"%@",pModel.goodsName);
        }
    }
}

/**
 将要删除你选择的商品
 
 @param selectedGoods 选择的数组
 */
- (void)shopcartFormatWillDeleteSelectedGoods:(NSArray *)selectedGoods
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认将这%ld个宝贝删除？", (unsigned long)selectedGoods.count] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.shopcartFormat deleteSelectedGoods:selectedGoods];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 全部删除
 */
- (void)shopcartFormatHasDeletedAllGoods
{
    NSLog(@"-----全部删除----");
}

#pragma mark - Networking List

/**
 请求购物车数据源
 */
- (void)getShopcartListData
{
    [self.shopcartFormat getShopcartGoodsList];
}

@end
