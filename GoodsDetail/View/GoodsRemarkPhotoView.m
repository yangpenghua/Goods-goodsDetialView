//
//  GoodsRemarkPhotoView.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodsRemarkPhotoView.h"
#import "RemarkPhoto.h"
@implementation GoodsRemarkPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhotoUrl:(NSString *)photoUrl
{
    _photoUrl = photoUrl;
    [self sd_setImageWithURL:[NSURL URLWithString:_photoUrl] placeholderImage:[UIImage imageNamed:@"pingluan_no"]];
}

//- (void)setPhoto:(RemarkPhoto *)photo
//{
//    _photo = photo;
//    
//    // 设置图片
//    [self sd_setImageWithURL:[NSURL URLWithString:photo.photoUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    
//}



@end
