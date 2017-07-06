//
//  HXMShopcartHeaderView.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartHeaderView.h"

@interface HXMShopcartHeaderView ()

/** 背景图 */
@property (nonatomic, strong) UIView *viewShopcartHeaderBg;
/** 全选按钮 */
@property (nonatomic, strong) UIButton *btnAllSelected;
/** 店铺按钮 */
@property (nonatomic, strong) UIButton *btnShop;
/** 店铺logo */
@property (nonatomic, strong) UIButton *btnShopLogo;
/** 可以点击的箭头 */
@property (nonatomic, strong) UIButton *btnArrow;

@end

@implementation HXMShopcartHeaderView

#pragma mark - lazy

/**
 背景图
 */
- (UIView *)viewShopcartHeaderBg
{
    if (_viewShopcartHeaderBg == nil){
        _viewShopcartHeaderBg = [[UIView alloc] init];
        _viewShopcartHeaderBg.backgroundColor = [UIColor whiteColor];
    }
    return _viewShopcartHeaderBg;
}

/**
 店铺的全选按钮
 */
- (UIButton *)btnAllSelected
{
    if (_btnAllSelected == nil){
        _btnAllSelected = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAllSelected setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_btnAllSelected setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_btnAllSelected addTarget:self action:@selector(btnAllSelectedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAllSelected;
}

/**
 店铺按钮
 */
- (UIButton *)btnShop
{
    if (_btnShop == nil){
        _btnShop = [[UIButton alloc] init];
        _btnShop.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnShop setTitleColor:[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1] forState:UIControlStateNormal];
        [_btnShop addTarget:self action:@selector(btnShopAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnShop;
}

/**
 店铺logo按钮
 */
- (UIButton *)btnShopLogo
{
    if (_btnShopLogo == nil) {
        _btnShopLogo = [[UIButton alloc] init];
        [_btnShopLogo setImage:[UIImage imageNamed:@"huyuan_dadian"] forState:UIControlStateNormal];
        [_btnShopLogo addTarget:self action:@selector(btnShopAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnShopLogo;
}

/**
 箭头按钮
 */
- (UIButton *)btnArrow
{
    if (_btnArrow == nil) {
        _btnArrow = [[UIButton alloc] init];
        [_btnArrow setImage:[UIImage imageNamed:@"Member-Center_binding_icon_more.png"] forState:UIControlStateNormal];
        [_btnArrow addTarget:self action:@selector(btnShopAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnArrow;
}

#pragma mark - init

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

/**
 创建视图
 */
- (void)setupView
{
    [self addSubview:self.viewShopcartHeaderBg];
    [self.viewShopcartHeaderBg addSubview:self.btnAllSelected];
    [self.viewShopcartHeaderBg addSubview:self.btnShopLogo];
    [self.viewShopcartHeaderBg addSubview:self.btnShop];
    [self.viewShopcartHeaderBg addSubview:self.btnArrow];
}

/**
 配置头视图 (店铺名字,店铺的选择状态)
 
 @param shopName 店铺名字
 @param shopSelect 店铺的选择状态
 */
- (void)configureShopcartHeaderViewWithShopName:(NSString *)shopName
                                    shopSelect:(BOOL)shopSelect
{
    self.btnAllSelected.selected = shopSelect;
    [self.btnShop setTitle:shopName forState:UIControlStateNormal];
}

#pragma mark - Method & Action

/**
 header的全选按钮的点击方法
 */
- (void)btnAllSelectedAction
{
    self.btnAllSelected.selected = !self.btnAllSelected.isSelected;
    
    if (self.shopcartHeaderViewBtnAllSeclectedBlock) {
        self.shopcartHeaderViewBtnAllSeclectedBlock(self.btnAllSelected.selected);
    }
}

/**
 品牌按钮的点击方法
 */
- (void)btnShopAction
{
    if (self.shopcartBtnShopSelectedBlock) {
        self.shopcartBtnShopSelectedBlock();
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 背景图
    [self.viewShopcartHeaderBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 全选按钮
    [self.btnAllSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewShopcartHeaderBg).offset(10);
        make.centerY.equalTo(self.viewShopcartHeaderBg);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 店铺logo
    [self.btnShopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAllSelected.mas_right).offset(10);
        make.centerY.equalTo(self.viewShopcartHeaderBg);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    // 店铺按钮
    [self.btnShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnShopLogo.mas_right).offset(10);
        make.top.bottom.equalTo(self.viewShopcartHeaderBg);
    }];
    
    // 用户点击的标识箭头
    [self.btnArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnShop.mas_right).with.offset(5);
        make.centerY.equalTo(self.viewShopcartHeaderBg);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}


@end
