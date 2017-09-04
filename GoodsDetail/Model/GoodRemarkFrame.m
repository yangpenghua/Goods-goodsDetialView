//
//  GoodRemarkFrame.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodRemarkFrame.h"
#import "GoodRemark.h"
#import "GoodsRemarkPhotosView.h"

@implementation GoodRemarkFrame

- (void)setGoodRemark:(GoodRemark *)goodRemark
{
    _goodRemark = goodRemark;
    
    /** 头像 */
    CGFloat iconImageViewX = 10.0;
    CGFloat iconImageViewY = 10.0;
    CGFloat iconImageViewW = 30.0;
    CGFloat iconImageViewH = 30.0;
    self.iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    /** 用户名 */
    CGFloat userNameLabelX = CGRectGetMaxX(self.iconImageViewF) + 15.0;
    CGFloat userNameLabelY = CGRectGetMinY(self.iconImageViewF);
    CGFloat userNameLabelW = 160.0;
    CGFloat userNameLabelH = CGRectGetHeight(self.iconImageViewF);
    self.userNameLabelF = CGRectMake(userNameLabelX, userNameLabelY, userNameLabelW, userNameLabelH);

    /** 时间 */
    CGFloat dateLabelX = SCREEN_WIDTH - 10.0 - 120.0;
    CGFloat dateLabelY = CGRectGetMinY(self.userNameLabelF);
    CGFloat dateLabelW = 120.0;
    CGFloat dateLabelH = CGRectGetHeight(self.userNameLabelF);
    self.dateLabelF = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);

    /** 评价详情 */
    CGFloat detailRemarkLabelX = 10.0;
    CGFloat detailRemarkLabelY = CGRectGetMaxY(self.iconImageViewF) + 10.0;
    CGFloat detailRemarkLabelW = SCREEN_WIDTH - 20.0;
    CGFloat detailRemarkLabelH = [_goodRemark.comment sizeWithFont:[UIFont systemFontOfSize:14] maxW:(SCREEN_WIDTH - 20.0)].height;
    self.detailRemarkLabelF = CGRectMake(detailRemarkLabelX, detailRemarkLabelY, detailRemarkLabelW, detailRemarkLabelH);

    /** 评价图片 */
    CGFloat photoViewH = 0.0;
    
    NSInteger photoCount = 0.0;
    if (goodRemark.imgUrls.length > 1) {
        NSArray *imageUrlsArray = [goodRemark.imgUrls componentsSeparatedByString:@","];
        NSMutableArray *filterImageArray = [NSMutableArray array];
        for (NSString *imageUrl in imageUrlsArray) {
            if (imageUrl.length > 2) {
                [filterImageArray addObject:imageUrl];
            }
        }
        if (filterImageArray.count > 0) {
            photoCount = filterImageArray.count;
        } else {
            photoCount = 0;
        }
    } else {
        photoCount = 0;
    }
    
    if (photoCount > 0) {
        CGFloat photosViewX = 10.0;
        CGFloat photosViewY = CGRectGetMaxY(self.detailRemarkLabelF) + 10.0;
        CGFloat photosViewW = SCREEN_WIDTH - 20.0;
        CGFloat photosViewH = [GoodsRemarkPhotosView sizeWithCount:photoCount].height;
        self.photosViewF = CGRectMake(photosViewX, photosViewY, photosViewW, photosViewH);
        
        photoViewH = CGRectGetMaxY(self.photosViewF) + 10.0;
    } else {
        photoViewH = CGRectGetMaxY(self.detailRemarkLabelF) + 10.0;
    }
    
    /** 细线 */
    CGFloat lineViewX = 0.0;
    CGFloat lineViewY = photoViewH - 0.5;
    CGFloat lineViewW = SCREEN_WIDTH;
    CGFloat lineViewH = 0.5;
    self.lineViewF = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    
    self.cellHeight = photoViewH;
}

@end
