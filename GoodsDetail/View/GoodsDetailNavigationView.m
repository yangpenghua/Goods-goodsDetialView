//
//  GoodsDetailNavigationView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailNavigationView.h"

@interface GoodsDetailNavigationView ()

/** 商品详情按钮 */
@property (nonatomic, strong) UIButton *detailImagesButton;
/** 商品参数按钮 */
@property (nonatomic, strong) UIButton *goodsParamsButton;
/** 商品评价 */
@property (nonatomic, strong) UIButton *goodsRemarkButton;

/** 移动横线 */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation GoodsDetailNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 按钮切换 */
    self.detailImagesButton = [self setupButtonWithTitle:@"商品详情"];
    [self.detailImagesButton addTarget:self action:@selector(detailImagesButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.goodsParamsButton = [self setupButtonWithTitle:@"产品参数"];
    [self.goodsParamsButton addTarget:self action:@selector(goodsParamsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.goodsRemarkButton = [self setupButtonWithTitle:@"用户评价"];
    [self.goodsRemarkButton addTarget:self action:@selector(goodsRemarkButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    /** 按钮底部细线 */
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = [UIColor colorWithHexString:@"ff6e34"];
    [self addSubview:self.bottomLineView];

}

- (UIButton *)setupButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"222222"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.backgroundColor = [UIColor whiteColor];
    [self addSubview:button];
    return button;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeigh = self.bounds.size.height;
    
    CGFloat buttonWidth = viewWidth / 3.0;
    CGFloat buttonHeight = viewHeigh;
    self.detailImagesButton.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonHeight);
    self.goodsParamsButton.frame = CGRectMake(CGRectGetMaxX(self.detailImagesButton.frame), 0.0, buttonWidth, buttonHeight);
    self.goodsRemarkButton.frame = CGRectMake(CGRectGetMaxX(self.goodsParamsButton.frame), 0.0, buttonWidth, buttonHeight);
    
    CGFloat lineWidth = 36.0;
    CGFloat lineHeight = 2.0;
    self.bottomLineView.frame = CGRectMake((buttonWidth - lineWidth) / 2.0, buttonHeight - lineHeight, lineWidth, lineHeight);
    
}

#pragma mark - Event Response
- (void)detailImagesButtonAction{
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat buttonWidth = viewWidth / 3.0;
    
    CGRect lineRect = self.bottomLineView.frame;
    lineRect.origin.x = (buttonWidth - CGRectGetWidth(lineRect)) / 2.0;
    [UIView animateWithDuration:0.38 animations:^{
        self.bottomLineView.frame = lineRect;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsDetailNavigationDetailImageView)]) {
        [self.delegate goodsDetailNavigationDetailImageView];
    }
}

- (void)goodsParamsButtonAction{
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat buttonWidth = viewWidth / 3.0;
    
    CGRect lineRect = self.bottomLineView.frame;
    lineRect.origin.x = buttonWidth + (buttonWidth - CGRectGetWidth(lineRect)) / 2.0;
    [UIView animateWithDuration:0.38 animations:^{
        self.bottomLineView.frame = lineRect;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsDetailNavigationDetailParamsView)]) {
        [self.delegate goodsDetailNavigationDetailParamsView];
    }
}

- (void)goodsRemarkButtonAction{
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat buttonWidth = viewWidth / 3.0;
    
    CGRect lineRect = self.bottomLineView.frame;
    lineRect.origin.x = buttonWidth * 2 + (buttonWidth - CGRectGetWidth(lineRect)) / 2.0;
    [UIView animateWithDuration:0.38 animations:^{
        self.bottomLineView.frame = lineRect;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsDetailNavigationDetailRemarkView)]) {
        [self.delegate goodsDetailNavigationDetailRemarkView];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
