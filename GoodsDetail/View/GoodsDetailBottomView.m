//
//  GoodsDetailBottomView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailBottomView.h"

@interface GoodsDetailBottomView ()
/** 购买按钮 */
@property (nonatomic, strong) UIButton          *purchaseButton;
/** 月供 */
@property (nonatomic, strong) UILabel           *monthPayLabel;

@end

@implementation GoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.purchaseButton];
    [self addSubview:self.monthPayLabel];
    self.monthPayLabel.text = @"月供: 198.0";
}

- (UILabel *)monthPayLabel{
    if (_monthPayLabel == nil) {
        _monthPayLabel = [[UILabel alloc] init];
        _monthPayLabel.textColor = [UIColor colorWithHexString:@"232323"];
        _monthPayLabel.font = [UIFont systemFontOfSize:14];
        _monthPayLabel.lineBreakMode = 0;
    }
    return _monthPayLabel;
}

- (UIButton *)purchaseButton{
    if (_purchaseButton == nil) {
        _purchaseButton = [UIButton setupButtonWithSuperView:self withTitle:@"立即购买" titleFont:17 corner:0 withObject:self action:@selector(submitPurchaseButtonAction)];
        _purchaseButton.backgroundColor = [UIColor colorWithHexString:@"ff6e34"];
        [_purchaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _purchaseButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.purchaseButton.frame = CGRectMake(viewWidth - 160.0, 0.0, 160.0, viewHeight);
    self.monthPayLabel.frame = CGRectMake(16.0, 0.0, viewWidth - 180.0, viewHeight);
}

//  立即购买按钮点击事件
- (void)submitPurchaseButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsDetailBottomViewClickPurchase)]) {
        [self.delegate goodsDetailBottomViewClickPurchase];
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
