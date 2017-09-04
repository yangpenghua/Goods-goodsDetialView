//
//  GoodsRemarkTableViewCell.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodsRemarkTableViewCell.h"
#import "GoodsRemarkPhotosView.h"
#import "GoodRemarkFrame.h"
#import "GoodRemark.h"

@interface GoodsRemarkTableViewCell ()

@property (nonatomic, strong) UIImageView  *iconImageView;
@property (nonatomic, strong) UILabel      *userNameLabel;
@property (nonatomic, strong) UILabel      *dateLabel;
@property (nonatomic, strong) UILabel      *detailRemarkLabel;

@property (nonatomic, strong) GoodsRemarkPhotosView  *photosView;

@property (nonatomic, strong) UIView       *lineView;

@end


@implementation GoodsRemarkTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GoodsRemarkTableViewCell";
    GoodsRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[GoodsRemarkTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    iconImageView.userInteractionEnabled = YES;
    //  设置图片显示样式
    iconImageView.contentMode = UIViewContentModeScaleToFill;
    iconImageView.layer.cornerRadius = 15.0;
    iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.backgroundColor = [UIColor clearColor];
    // 设置字体大小
    userNameLabel.font = [UIFont systemFontOfSize:14];
    // 设置字体颜色
    userNameLabel.textColor = [UIColor colorWithHexString:@"111111"];
    //  设置对齐方式
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    // 设置换行
    userNameLabel.numberOfLines = 0;
//    userNameLabel.text = @"绿色快谈满铺定制欧式我是床边谈客厅茶几沙发谈快谈";
    [self.contentView addSubview:userNameLabel];
    self.userNameLabel = userNameLabel;
    
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.backgroundColor = [UIColor clearColor];
    // 设置字体大小
    dateLabel.font = [UIFont systemFontOfSize:13];
    // 设置字体颜色
    dateLabel.textColor = [UIColor colorWithHexString:@"999999"];
    //  设置对齐方式
    dateLabel.textAlignment = NSTextAlignmentRight;
    // 设置换行
    dateLabel.numberOfLines = 0;
//    dateLabel.text = @"279元起/块";
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;

    
    UILabel *detailRemarkLabel = [[UILabel alloc] init];
    detailRemarkLabel.backgroundColor = [UIColor clearColor];
    // 设置字体大小
    detailRemarkLabel.font = [UIFont systemFontOfSize:14];
    // 设置字体颜色
    detailRemarkLabel.textColor = [UIColor colorWithHexString:@"111111"];
    //  设置对齐方式
    detailRemarkLabel.textAlignment = NSTextAlignmentLeft;
    // 设置换行
    detailRemarkLabel.numberOfLines = 0;
//    detailRemarkLabel.text = @"这里是评价，地毯很好，虽然厚度只有0.7cm,这里是评价，地毯很好，虽然厚度只有0.7cm,这里是评价，地毯很好，虽然厚度只有0.7cm这里是评价，地毯很好，虽然厚度只有0.7cm这里是评价，地毯很好，虽然厚度只有0.7cm这里是评价，地毯很好，虽然厚度只有0.7cm";
    [self.contentView addSubview:detailRemarkLabel];
    self.detailRemarkLabel = detailRemarkLabel;

    
    /** 配图 */
    GoodsRemarkPhotosView *photosView = [[GoodsRemarkPhotosView alloc] init];
    [self.contentView addSubview:photosView];
    self.photosView = photosView;
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"dedede"];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

//   设置控件frame
- (void)setGoodRemarkFrame:(GoodRemarkFrame *)goodRemarkFrame
{
    _goodRemarkFrame = goodRemarkFrame;
    GoodRemark *goodRemark = _goodRemarkFrame.goodRemark;

    self.iconImageView.frame = self.goodRemarkFrame.iconImageViewF;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:goodRemark.commentorAvata] placeholderImage:[UIImage imageNamed:@"b3touxiang"]];
    
    self.userNameLabel.frame = self.goodRemarkFrame.userNameLabelF;
    self.userNameLabel.text = goodRemark.commentorNick;
    
    self.dateLabel.frame = self.goodRemarkFrame.dateLabelF;
    self.dateLabel.text = [self dateStringFromLongDate:goodRemark.gmtCreate];
    
    self.detailRemarkLabel.frame = self.goodRemarkFrame.detailRemarkLabelF;
    self.detailRemarkLabel.text = goodRemark.comment;
    
    self.photosView.frame = self.goodRemarkFrame.photosViewF;
    if (goodRemark.imgUrls.length > 1) {
        NSArray *imageUrlsArray = [goodRemark.imgUrls componentsSeparatedByString:@","];
        NSMutableArray *filterImageArray = [NSMutableArray array];
        for (NSString *imageUrl in imageUrlsArray) {
            if (imageUrl.length > 2) {
                [filterImageArray addObject:imageUrl];
            }
        }
        if (filterImageArray.count > 0) {
            self.photosView.photos = filterImageArray;
        } else {
            self.photosView.photos = nil;
        }
    } else {
        self.photosView.photos = nil;
    }
    
    self.lineView.frame = self.goodRemarkFrame.lineViewF;
}


- (NSString *)dateStringFromLongDate:(long)dateLong{
    long long date = (long long)dateLong / 1000;
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date1];
    return dateString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
