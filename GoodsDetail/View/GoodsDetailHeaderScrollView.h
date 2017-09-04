//
//  GoodsDetailHeaderScrollView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;
@class ALATitleValueCellView;
@class ALAGoodsInfoModel;

@protocol GoodsDetailHeaderScrollViewDelegate <NSObject>

/** 点击选择规格框 */
- (void)goodsDetailHeaderScrollViewClickChoiseProperty;

@end

@interface GoodsDetailHeaderScrollView : UIScrollView

//  轮播图
@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView;
/** 商品名 */
@property (nonatomic, strong) UILabel           *goodsNameLabel;

/** 商品价格 市场价格 收藏按钮 的背景view */
@property (nonatomic, strong) UIView        *priceBackgroundView;
/** 销售价格 */
@property (nonatomic, strong) UILabel       *soldPriceLabel;
/** 原价 */
@property (nonatomic, strong) UILabel       *originPriceLabel;
/** 已售label */
@property (nonatomic, strong) UILabel       *soldCountLabel;

/** 商品标识背景view */
@property (nonatomic, strong) UIView        *markBgView;

/** 规格view */
@property (nonatomic, strong) UIView        *propertyBgView;
/** 选择规格及数量背景view */
@property (nonatomic, strong) ALATitleValueCellView *propertyView;

/** 商品详情数据model */
@property (nonatomic, strong) ALAGoodsInfoModel  *goodsInfoModel;

@property (nonatomic, weak) id<GoodsDetailHeaderScrollViewDelegate> headerDelegate;

@end
