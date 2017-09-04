//
//  GoodsDetailImageTableViewCell.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailImageTableViewCell.h"
#import "ALAGoodsInfoModel.h"

@interface GoodsDetailImageTableViewCell ()

@property (nonatomic, strong) UIImageView *goodsDetailImageView;

@end

@implementation GoodsDetailImageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GoodsDetailImageTableViewCell";
    GoodsDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[GoodsDetailImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    self.goodsDetailImageView = [[UIImageView alloc] init];
    self.goodsDetailImageView.backgroundColor = [UIColor whiteColor];
    self.goodsDetailImageView.userInteractionEnabled = YES;
    self.goodsDetailImageView.contentMode = UIViewContentModeScaleToFill;
    self.goodsDetailImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.goodsDetailImageView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.goodsDetailImageView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
}

- (void)setGoodsDetailImageModel:(GoodsDetailImageModel *)goodsDetailImageModel{
    if (_goodsDetailImageModel != goodsDetailImageModel) {
        _goodsDetailImageModel = goodsDetailImageModel;
        [self.goodsDetailImageView sd_setImageWithURL:[NSURL URLWithString:_goodsDetailImageModel.picUrl]];
    }
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
