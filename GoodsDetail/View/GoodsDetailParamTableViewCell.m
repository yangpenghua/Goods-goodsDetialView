//
//  GoodsDetailParamTableViewCell.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailParamTableViewCell.h"
#import "GoodsParamsModel.h"

@interface GoodsDetailParamTableViewCell ()

/** 参数名 */
@property (nonatomic, strong) UILabel *paramsNameLabel;
/** 参数值 */
@property (nonatomic, strong) UILabel *paramsValueLabel;

@end

@implementation GoodsDetailParamTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GoodsDetailParamTableViewCell";
    GoodsDetailParamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[GoodsDetailParamTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    self.paramsNameLabel = [UILabel labelWithTitleColorStr:@"646464" fontSize:12 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.paramsNameLabel];
    self.paramsNameLabel.backgroundColor = [UIColor whiteColor];

    self.paramsValueLabel = [UILabel labelWithTitleColorStr:@"222222" fontSize:12 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.paramsValueLabel];
    self.paramsValueLabel.backgroundColor = [UIColor whiteColor];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.paramsNameLabel.frame = CGRectMake(16.0, 0.0, 68.0, viewHeight);
    self.paramsValueLabel.frame = CGRectMake(CGRectGetMaxX(self.paramsNameLabel.frame), 0.0, viewWidth - CGRectGetMaxX(self.paramsNameLabel.frame) - 20.0, viewHeight);
}

- (void)setGoodsParamsModel:(GoodsParamsModel *)goodsParamsModel{
    if (_goodsParamsModel != goodsParamsModel) {
        _goodsParamsModel = goodsParamsModel;
        
        self.paramsNameLabel.text = _goodsParamsModel.paramName;
        self.paramsValueLabel.text = _goodsParamsModel.paramValue;
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
