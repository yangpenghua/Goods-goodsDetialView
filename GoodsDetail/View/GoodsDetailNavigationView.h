//
//  GoodsDetailNavigationView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GoodsDetailNavigationViewDelegate <NSObject>

/** 导航到商品图片详情 */
- (void)goodsDetailNavigationDetailImageView;
/** 导航到商品参数详情 */
- (void)goodsDetailNavigationDetailParamsView;
/** 导航到商品评价详情 */
- (void)goodsDetailNavigationDetailRemarkView;

@end

@interface GoodsDetailNavigationView : UIView

@property (nonatomic, weak) id<GoodsDetailNavigationViewDelegate> delegate;

@end
