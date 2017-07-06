//
//  HXMShopcartTBVCell.m
//  HXMShopcart
//
//  Created by HXM on 2017/7/5.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "HXMShopcartTBVCell.h"

@interface HXMShopcartTBVCell ()

/** 选择按钮*/
@property (nonatomic, strong) UIButton *btnGoodsSelected;
/** 图片*/
@property (nonatomic, strong) UIImageView *imageViewGoods;
/** 名字*/
@property (nonatomic, strong) UILabel *lblGoodsName;
/** 尺码*/
@property (nonatomic, strong) UILabel *lblGoodsSize;
/** 价钱*/
@property (nonatomic, strong) UILabel *lblGoodsPrice;
/** 库存*/
@property (nonatomic, strong) UILabel *lblGoodsStock;
/** 选择的数量*/
@property (nonatomic, strong) HXMShopcartCountView *viewShopcartCount;
/** 背景view*/
@property (nonatomic, strong) UIView *viewShopcartBg;
/** 上划线*/
@property (nonatomic, strong) UIView *viewTopline;

@end

@implementation HXMShopcartTBVCell

#pragma mark - lazy

/**
 商品选择按钮
 */
- (UIButton *)btnGoodsSelected
{
    if(_btnGoodsSelected == nil)
    {
        _btnGoodsSelected = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoodsSelected setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_btnGoodsSelected setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_btnGoodsSelected addTarget:self action:@selector(btnGoodsSelectedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGoodsSelected;
}

/**
 商品图片
 */
- (UIImageView *)imageViewGoods
{
    if (_imageViewGoods == nil){
        _imageViewGoods = [[UIImageView alloc] init];
    }
    return _imageViewGoods;
}

/**
 名字
 */
- (UILabel *)lblGoodsName
{
    if (_lblGoodsName == nil){
        _lblGoodsName = [[UILabel alloc] init];
        _lblGoodsName.font = [UIFont systemFontOfSize:14];
        _lblGoodsName.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _lblGoodsName.numberOfLines = 0;
        [_lblGoodsName sizeToFit];
    }
    return _lblGoodsName;
}

/**
 尺码
 */
- (UILabel *)lblGoodsSize
{
    if (_lblGoodsSize == nil){
        _lblGoodsSize = [[UILabel alloc] init];
        _lblGoodsSize.font = [UIFont systemFontOfSize:13];
        _lblGoodsSize.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _lblGoodsSize;
}

/**
 价钱
 */
- (UILabel *)lblGoodsPrice
{
    if (_lblGoodsPrice == nil){
        _lblGoodsPrice = [[UILabel alloc] init];
        _lblGoodsPrice.font = [UIFont systemFontOfSize:14];
        _lblGoodsPrice.textColor = [UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1];
    }
    return _lblGoodsPrice;
}

/**
 购买数量
 */
- (HXMShopcartCountView *)viewShopcartCount
{
    if (_viewShopcartCount == nil){
        _viewShopcartCount = [[HXMShopcartCountView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        
        // 商品数量编辑block
        _viewShopcartCount.shopcartCountViewEditBlock = ^(NSInteger count){
            if (weakSelf.shopcartCellCountEditBlock) {
                weakSelf.shopcartCellCountEditBlock(count);
            }
        };
    }
    return _viewShopcartCount;
}

/**
 库存数
 */
- (UILabel *)lblGoodsStock
{
    if (_lblGoodsStock == nil){
        _lblGoodsStock = [[UILabel alloc] init];
        _lblGoodsStock.font = [UIFont systemFontOfSize:13];
        _lblGoodsStock.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _lblGoodsStock;
}

/**
 背景图
 */
- (UIView *)viewShopcartBg
{
    if (_viewShopcartBg == nil){
        _viewShopcartBg = [[UIView alloc] init];
        _viewShopcartBg.backgroundColor = [UIColor whiteColor];
    }
    return _viewShopcartBg;
}

/**
 上划线
 */
- (UIView *)viewTopline
{
    if (_viewTopline == nil){
        _viewTopline = [[UIView alloc] init];
        _viewTopline.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _viewTopline;
}

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor yellowColor];
        [self setupViews];
    }
    return self;
}

/**
 创建视图
 */
- (void)setupViews
{
    [self.contentView addSubview:self.viewShopcartBg];
    [self.viewShopcartBg addSubview:self.btnGoodsSelected];
    [self.viewShopcartBg addSubview:self.imageViewGoods];
    [self.viewShopcartBg addSubview:self.lblGoodsName];
    [self.viewShopcartBg addSubview:self.lblGoodsSize];
    [self.viewShopcartBg addSubview:self.lblGoodsPrice];
    [self.viewShopcartBg addSubview:self.viewShopcartCount];
    [self.viewShopcartBg addSubview:self.lblGoodsStock];
    [self.viewShopcartBg addSubview:self.viewTopline];
}

#pragma mark - setter

- (void)setModel:(HXMShopcartGoodsModel *)model
{
    _model = model;
    
    NSURL *encodingURL = [NSURL URLWithString:[model.goodsPicUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    // 商品图片
    [self.imageViewGoods sd_setImageWithURL:encodingURL];
//    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:[model.goodsPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
    // 名字
    self.lblGoodsName.text = model.goodsName;
    // 尺码
    self.lblGoodsSize.text = model.goodsSize;
    // 价钱
    self.lblGoodsPrice.text = [NSString stringWithFormat:@"￥%ld", (long)model.goodsPrice];
    // 商品选择状态
    self.btnGoodsSelected.selected = model.isSelected;
    // 商品购买数量
    [self.viewShopcartCount configureShopcartCountViewWithGoodsCount:model.goodsNum goodsStock:model.goodsStocks];
    // 库存
    self.lblGoodsStock.text = [NSString stringWithFormat:@"库存:%ld", (long)model.goodsStocks];
}

#pragma mark - Action Method

/**
 商品选择按钮的方法
 */
- (void)btnGoodsSelectedAction
{
    self.btnGoodsSelected.selected = !self.btnGoodsSelected.isSelected;
    if (self.shopcartCellSelectedBlock) {
        self.shopcartCellSelectedBlock(self.btnGoodsSelected.selected);
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 上划线
    [self.viewTopline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewShopcartBg).offset(10);
        make.top.equalTo(self.viewShopcartBg);
        make.right.equalTo(self.viewShopcartBg).offset(-10);
        make.height.equalTo(@0.5);
    }];
    
    // 选择按钮
    [self.btnGoodsSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewShopcartBg).offset(10);
        make.centerY.equalTo(self.viewShopcartBg).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 图片
    [self.imageViewGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnGoodsSelected.mas_right).offset(5);
        make.top.equalTo(self.viewTopline).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    // 名字
    [self.lblGoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewGoods.mas_right).offset(5);
        make.top.equalTo(self.viewShopcartBg).offset(10);
        make.right.equalTo(self.viewShopcartBg).offset(-5);
        make.height.equalTo(@40);
    }];
    
    // 尺码
    [self.lblGoodsSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewGoods.mas_right).offset(5);
        make.top.equalTo(self.lblGoodsName.mas_bottom);
        make.right.equalTo(self.viewShopcartBg).offset(-5);
        make.height.equalTo(@20);
    }];
    
    // 价钱
    [self.lblGoodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewGoods.mas_right).offset(5);
        make.top.equalTo(self.lblGoodsSize.mas_bottom).offset(5);
        make.right.equalTo(self.viewShopcartBg).offset(-5);
        make.height.equalTo(@20);
    }];
    
    // 购买数量
    [self.viewShopcartCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewGoods.mas_right).offset(5);
        make.bottom.equalTo(self.viewShopcartBg).offset(-5);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    // 库存
    [self.lblGoodsStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewShopcartCount.mas_right).offset(20);
        make.centerY.equalTo(self.viewShopcartCount);
    }];
    
    // 背景图
    [self.viewShopcartBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
