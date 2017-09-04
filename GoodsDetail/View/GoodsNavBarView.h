//
//  GoodsNavBarView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/1.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsNavBarViewDelegate <NSObject>

- (void)goodsNavBarClickLeft;

@end

@interface GoodsNavBarView : UIView

@property(nonatomic, strong) UIImageView    * headBackView;
@property (nonatomic, strong) UIView        *bottomLine;
@property(nonatomic, strong) NSString       * title;
@property(nonatomic, strong) UIColor        * color;
@property(nonatomic, strong) NSString       * left_bt_Image;
@property(nonatomic, strong) NSString       * right_bt_Image;

@property(nonatomic, assign) id<GoodsNavBarViewDelegate> delegate;

@end
