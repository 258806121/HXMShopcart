//
//  HXMShopcartBottomView.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartBottomView.h"

@interface HXMShopcartBottomView ()

/** 全选按钮*/
@property (nonatomic, strong) UIButton *btnAllSelect;
/** 总价钱*/
@property (nonatomic, strong) UILabel *lblTotalPrice;
/** 结算按钮*/
@property (nonatomic, strong) UIButton *btnSettle;
/** 删除按钮*/
@property (nonatomic, strong) UIButton *btnDelete;
/** 分割线*/
@property (nonatomic, strong) UIView *viewSeparateLine;

@end

@implementation HXMShopcartBottomView

#pragma mark - lazy

/**
 全选按钮
 */
- (UIButton *)btnAllSelect
{
    if (_btnAllSelect == nil){
        _btnAllSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAllSelect setTitle:@"全选" forState:UIControlStateNormal];
        [_btnAllSelect setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
        _btnAllSelect.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnAllSelect setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_btnAllSelect setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_btnAllSelect setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_btnAllSelect addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAllSelect;
}

/**
 总价钱lbl
 */
- (UILabel *)lblTotalPrice
{
    if (_lblTotalPrice == nil){
        _lblTotalPrice = [[UILabel alloc] init];
        _lblTotalPrice.font = [UIFont systemFontOfSize:14];
        _lblTotalPrice.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _lblTotalPrice.numberOfLines = 2;
        // 默认价钱
        _lblTotalPrice.text = @"合计：￥0\n不含运费";
    }
    return _lblTotalPrice;
}

/**
 结算按钮
 */
- (UIButton *)btnSettle
{
    if (_btnSettle == nil){
        _btnSettle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSettle setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_btnSettle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSettle.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnSettle setBackgroundColor:[UIColor lightGrayColor]];
        [_btnSettle addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _btnSettle.enabled = NO;
    }
    return _btnSettle;
}

/**
 删除按钮
 */
- (UIButton *)btnDelete
{
    if (_btnDelete == nil){
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnDelete.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnDelete setBackgroundColor:[UIColor lightGrayColor]];
        [_btnDelete addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.enabled = NO;
        _btnDelete.hidden = YES;
    }
    return _btnDelete;
}

/**
 分割线view
 */
- (UIView *)viewSeparateLine
{
    if (_viewSeparateLine == nil){
        _viewSeparateLine = [[UIView alloc] init];
        _viewSeparateLine.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _viewSeparateLine;
}

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

/**
 创建视图
 */
- (void)setupView
{
    [self addSubview:self.btnAllSelect];
    [self addSubview:self.lblTotalPrice];
    [self renderWithTotalPrice:@"￥0"];
    [self addSubview:self.btnSettle];
    [self addSubview:self.btnDelete];
    [self addSubview:self.viewSeparateLine];
}

#pragma mark - 自定义方法

/**
 改变bottomView的状态
 
 @param status status
 */
- (void)changeShopcartBottomViewWithStatus:(BOOL)status
{
    self.btnDelete.hidden = !status;
}

/**
 根据 总价钱,总数,是否全选,配置bottomView
 
 @param totalPrice 总价钱
 @param totalCount 总数
 @param isAllSelected 是否全选
 */
- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected
{
    self.btnAllSelect.selected = isAllSelected;
    
    self.lblTotalPrice.text = [NSString stringWithFormat:@"合计：￥%.2f\n不含运费", totalPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"￥%.2f", totalPrice]];
    
    [self.btnSettle setTitle:[NSString stringWithFormat:@"结算(%ld)", (long)totalCount] forState:UIControlStateNormal];
    self.btnSettle.enabled = totalCount && totalPrice;
    self.btnDelete.enabled = totalCount && totalPrice;
    
    if (self.btnSettle.isEnabled) {
        [self.btnSettle setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        [self.btnDelete setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
    } else {
        [self.btnSettle setBackgroundColor:[UIColor lightGrayColor]];
        [self.btnDelete setBackgroundColor:[UIColor lightGrayColor]];
    }
}

/**
 交纳金额
 
 @param totalPrice totalPrice
 */
- (void)renderWithTotalPrice:(NSString *)totalPrice
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.lblTotalPrice.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:210/255.0 green:50/255.0 blue:50/255.0 alpha:1]} range:[self.lblTotalPrice.text rangeOfString:totalPrice]];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[self.lblTotalPrice.text rangeOfString:@"不含运费"]];
    self.lblTotalPrice.attributedText = attributedString;
    self.lblTotalPrice.textAlignment = NSTextAlignmentRight;
}

#pragma mark - Action

/**
 全选按钮的方法
 */
- (void)allSelectButtonAction
{
    self.btnAllSelect.selected = !self.btnAllSelect.isSelected;
    
    if (self.shopcartBottomViewAllSelectedBlock) {
        self.shopcartBottomViewAllSelectedBlock(self.btnAllSelect.isSelected);
    }
}

/**
 结算按钮的方法
 */
- (void)settleButtonAction
{
    if (self.shopcartBottomViewSettledBlock) {
        self.shopcartBottomViewSettledBlock();
    }
}

/**
 删除按钮的方法
 */
- (void)deleteButtonAction
{
    if (self.shopcartBottomViewDeletedBlock) {
        self.shopcartBottomViewDeletedBlock();
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 全选
    [self.btnAllSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    // 结算
    [self.btnSettle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    // 删除
    [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    // 总价钱
    [self.lblTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.btnAllSelect.mas_right);
        make.right.equalTo(self.btnSettle.mas_left).offset(-5);
    }];
    
    // 分割线
    [self.viewSeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.3);
    }];
}


@end
