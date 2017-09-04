//
//  GoodsDetailFooterScrollView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/1.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailFooterScrollView : UIScrollView

/** 商品详情图片Model数组 */
@property (nonatomic, strong) NSArray *goodsDetailImageModelArray;
/** 商品参数model数组 */
@property (nonatomic, strong) NSArray *goodsParamsModelArray;
/** 商品评价Frame Model 数组 */
@property (nonatomic, strong) NSArray *goodsRemarkFrameArray;

/** 切换到商品详情图片 */
- (void)switchToGoodsDetailImagesView;
/** 切换到商品详情图片 */
- (void)switchToGoodsDetailParamsView;
/** 切换到商品详情图片 */
- (void)switchToGoodsDetailRemarkView;


@end
