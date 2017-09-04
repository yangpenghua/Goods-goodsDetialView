//
//  GoodRemark.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodRemark : NSObject

/** 头像url */
@property (nonatomic, copy) NSString  *commentorAvata;
/** 评论昵称 */
@property (nonatomic, copy) NSString  *commentorNick;
/** 评论时间 */
@property (nonatomic, assign) long   gmtCreate;
/** 评论内容 */
@property (nonatomic, copy) NSString  *comment;

/** 物流评级 */
@property (nonatomic, copy) NSString  *deliverScore;
/** 商品评分 */
@property (nonatomic, assign) NSInteger  goodsScore;
/** 服务评分 */
@property (nonatomic, assign) NSInteger  serviceScore;

/** 评论图片,多个Url,以逗号分隔 */
@property (nonatomic, copy) NSString  *imgUrls;

@end
