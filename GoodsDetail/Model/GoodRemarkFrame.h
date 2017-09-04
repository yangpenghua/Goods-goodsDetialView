//
//  GoodRemarkFrame.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodRemark;
@class GoodsRemarkPhotosView;
@interface GoodRemarkFrame : NSObject

/** 头像 */
@property (nonatomic, assign) CGRect  iconImageViewF;
/** 用户名 */
@property (nonatomic, assign) CGRect  userNameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect  dateLabelF;
/** 评价详情 */
@property (nonatomic, assign) CGRect  detailRemarkLabelF;
/** 评价图片 */
@property (nonatomic, assign) CGRect  photosViewF;
/** 细线 */
@property (nonatomic, assign) CGRect  lineViewF;

/** 商品评价 */
@property (nonatomic, strong) GoodRemark *goodRemark;
@property (nonatomic, assign) CGFloat     cellHeight;

@end
