//
//  GoodsDetailBottomView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsDetailBottomViewDelegate <NSObject>

/** 点击购买 */
- (void)goodsDetailBottomViewClickPurchase;

@end

@interface GoodsDetailBottomView : UIView

@property (nonatomic, weak) id<GoodsDetailBottomViewDelegate> delegate;

@end
