//
//  HXMShopcartCountView.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartCountView.h"

@interface HXMShopcartCountView ()<
UITextFieldDelegate>

/** 增加按钮*/
@property (nonatomic, strong) UIButton *btnIncrease;
/** 减少按钮*/
@property (nonatomic, strong) UIButton *btnDecrease;
/** 编辑区域textfield*/
@property (nonatomic, strong) UITextField *textfieldEdited;

@end

@implementation HXMShopcartCountView

#pragma mark - lazy

/**
 编辑区域
 */
- (UITextField *)textfieldEdited
{
    if(_textfieldEdited == nil) {
        _textfieldEdited = [[UITextField alloc] init];
        _textfieldEdited.textAlignment = NSTextAlignmentCenter;
        _textfieldEdited.keyboardType = UIKeyboardTypeNumberPad;
        _textfieldEdited.clipsToBounds = YES;
        _textfieldEdited.layer.borderColor = [[UIColor colorWithRed:0.776  green:0.780  blue:0.789 alpha:1] CGColor];
        _textfieldEdited.layer.borderWidth = 0.5;
        _textfieldEdited.delegate = self;
        _textfieldEdited.font = [UIFont systemFontOfSize:13];
        _textfieldEdited.backgroundColor = [UIColor whiteColor];
    }
    return _textfieldEdited;
}

/**
 减少按钮
 */
- (UIButton *)btnDecrease
{
    if(_btnDecrease == nil) {
        _btnDecrease = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDecrease setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:UIControlStateNormal];
        [_btnDecrease setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
        [_btnDecrease addTarget:self action:@selector(btnDecreaseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDecrease;
}

/**
 增加按钮
 */
- (UIButton *)btnIncrease
{
    if(_btnIncrease == nil)
    {
        _btnIncrease = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnIncrease setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:UIControlStateNormal];
        [_btnIncrease setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
        [_btnIncrease addTarget:self action:@selector(btnIncreaseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnIncrease;
}

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

/**
 创建视图
 */
- (void)setupView
{
    [self addSubview:self.btnIncrease];
    [self addSubview:self.btnDecrease];
    [self addSubview:self.textfieldEdited];
}

/**
 根据商品数 与 库存数 判断,可以购买的数量
 
 @param goodsCount 商品数
 @param goodsStock 库存数
 */
- (void)configureShopcartCountViewWithGoodsCount:(NSInteger)goodsCount
                                      goodsStock:(NSInteger)goodsStock
{
    if (goodsCount == 1) {
        self.btnDecrease.enabled = NO;
        self.btnIncrease.enabled = YES;
    } else if (goodsCount == goodsStock) {
        self.btnDecrease.enabled = YES;
        self.btnIncrease.enabled = NO;
    } else {
        self.btnDecrease.enabled = YES;
        self.btnIncrease.enabled = YES;
    }
    
    // 赋值:购买数量
    self.textfieldEdited.text = [NSString stringWithFormat:@"%ld", (long)goodsCount];
}

#pragma mark - Action

/**
 减少
 */
- (void)btnDecreaseAction
{
    NSInteger count = self.textfieldEdited.text.integerValue;
    if (self.shopcartCountViewEditBlock) {
        self.shopcartCountViewEditBlock(-- count);
    }
}

/**
 增加
 */
- (void)btnIncreaseAction
{
    NSInteger count = self.textfieldEdited.text.integerValue;
    if (self.shopcartCountViewEditBlock) {
        self.shopcartCountViewEditBlock(++ count);
    }
}

/**
 textfield结束编辑
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.shopcartCountViewEditBlock) {
        self.shopcartCountViewEditBlock(self.textfieldEdited.text.integerValue);
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 减少按钮
    [self.btnDecrease mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    // 增加按钮
    [self.btnIncrease mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    // 编辑textfield
    [self.textfieldEdited mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.btnDecrease.mas_right);
        make.right.equalTo(self.btnIncrease.mas_left);
    }];
}

@end
