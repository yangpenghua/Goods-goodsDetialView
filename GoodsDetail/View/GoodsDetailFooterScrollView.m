//
//  GoodsDetailFooterScrollView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/1.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailFooterScrollView.h"
#import "GoodsDetailImageView.h"
#import "GoodsDetailParamsView.h"
#import "GoodsDetailRemarkView.h"

@interface GoodsDetailFooterScrollView ()

/** 商品详情TableView */
@property (nonatomic, strong) GoodsDetailImageView *goodsDetailImageView;

/** 商品参数TableView */
@property (nonatomic, strong) GoodsDetailParamsView *goodsDetailParamsView;

/** 商品评价TableView */
@property (nonatomic, strong) GoodsDetailRemarkView  *goodsDetailRemarkView;


@end

@implementation GoodsDetailFooterScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    
    /** 商品详情图片 */
    self.goodsDetailImageView = [[GoodsDetailImageView alloc] init];
    [self addSubview:self.goodsDetailImageView];

    /** 商品参数 */
    self.goodsDetailParamsView = [[GoodsDetailParamsView alloc] init];
    [self addSubview:self.goodsDetailParamsView];

    
    /** 商品评价 */
    self.goodsDetailRemarkView = [[GoodsDetailRemarkView alloc] init];
    [self addSubview:self.goodsDetailRemarkView];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeigh = self.bounds.size.height;
    
    self.goodsDetailImageView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeigh);
    self.goodsDetailParamsView.frame = CGRectMake(viewWidth, 0.0, viewWidth, viewHeigh);
    self.goodsDetailRemarkView.frame = CGRectMake(viewWidth * 2, 0.0, viewWidth, viewHeigh);
}

#pragma mark - Event Response
- (void)switchToGoodsDetailImagesView{
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeigh = self.bounds.size.height;
    
    self.goodsDetailImageView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeigh);
    self.goodsDetailParamsView.frame = CGRectMake(viewWidth, 0.0, viewWidth, viewHeigh);
    self.goodsDetailRemarkView.frame = CGRectMake(viewWidth * 2, 0.0, viewWidth, viewHeigh);
}

- (void)switchToGoodsDetailParamsView{
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeigh = self.bounds.size.height;
    
    self.goodsDetailImageView.frame = CGRectMake(-viewWidth, 0.0, viewWidth, viewHeigh);
    self.goodsDetailParamsView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeigh);
    self.goodsDetailRemarkView.frame = CGRectMake(viewWidth * 2, 0.0, viewWidth, viewHeigh);
}

- (void)switchToGoodsDetailRemarkView{
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeigh = self.bounds.size.height;
    
    self.goodsDetailImageView.frame = CGRectMake(-(viewWidth * 2), 0.0, viewWidth, viewHeigh);
    self.goodsDetailParamsView.frame = CGRectMake(-viewWidth, 0.0, viewWidth, viewHeigh);
    self.goodsDetailRemarkView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeigh);

}

//  设置商品详情图片数据
- (void)setGoodsDetailImageModelArray:(NSArray *)goodsDetailImageModelArray{
    if (_goodsDetailImageModelArray != goodsDetailImageModelArray) {
        _goodsDetailImageModelArray = goodsDetailImageModelArray;
        if (_goodsDetailImageModelArray.count > 0) {
            self.goodsDetailImageView.imageModelArray = _goodsDetailImageModelArray;
        }
    }
}

//  设置商品参数数据
- (void)setGoodsParamsModelArray:(NSArray *)goodsParamsModelArray{
    if (_goodsParamsModelArray != goodsParamsModelArray) {
        _goodsParamsModelArray = goodsParamsModelArray;
        if (_goodsParamsModelArray.count > 0) {
            self.goodsDetailParamsView.paramsModelArray = _goodsParamsModelArray;
        }
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
