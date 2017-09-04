//
//  GoodsRemarkPhotosView.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodsRemarkPhotosView.h"
#import "GoodsRemarkPhotoView.h"
#define imagePadding 10.0
#define imageMargin  5.0
#define imageWidth   (SCREEN_WIDTH - (imageMargin + imagePadding)*2)/3.0

@implementation GoodsRemarkPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        GoodsRemarkPhotoView *photoView = [[GoodsRemarkPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        GoodsRemarkPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photoUrl = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = 3;
    for (int i = 0; i<photosCount; i++) {
        GoodsRemarkPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.mj_x = col * (imageWidth + imageMargin);
        
        int row = i / maxCol;
        photoView.mj_y = row * (imageWidth + imageMargin);


        photoView.width = imageWidth;
        photoView.height = imageWidth;
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    
    CGFloat photosW = SCREEN_WIDTH - 2*imagePadding;
    // 行数
    NSUInteger rows = (count + 3 - 1) / 3;
    CGFloat photosH = rows * imageWidth + (rows - 1) * imageMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
