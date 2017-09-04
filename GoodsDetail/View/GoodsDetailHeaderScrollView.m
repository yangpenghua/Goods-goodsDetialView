//
//  GoodsDetailHeaderScrollView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailHeaderScrollView.h"
#import "SDCycleScrollView.h"
#import "CustomTool.h"
#import "ALAGoodsInfoModel.h"
#import "ALATitleValueCellView.h"

@interface GoodsDetailHeaderScrollView ()
/** 轮播图片数组 */
@property (nonatomic, strong) NSMutableArray      *cycleImageModelArray;

@end

@implementation GoodsDetailHeaderScrollView

- (NSMutableArray *)cycleImageModelArray
{
    if (_cycleImageModelArray == nil) {
        _cycleImageModelArray = [NSMutableArray array];
    }
    return _cycleImageModelArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    //  添加轮播图
    [self addSubview:self.cycleScrollView];
    
    //  商品名称
    self.goodsNameLabel = [CustomTool setupLabelWithSuperView:self textColor:@"222222" textFont:14 textAlignment:NSTextAlignmentLeft];
    self.goodsNameLabel.text = @"OPPO R11 plus 金色充电五分钟通话两小时, 金色充电五分钟通话2小时";
    self.goodsNameLabel.backgroundColor = [UIColor whiteColor];
    self.goodsNameLabel.frame = CGRectMake(16.0, CGRectGetMaxY(self.cycleScrollView.frame) + 15.0, SCREEN_WIDTH - 32.0, 40.0);
    
    /** 商品价格 市场价格 的背景view */
    self.priceBackgroundView = [CustomTool setupViewWithSuperView:self withBGColor:WhiteTextColor];
    self.priceBackgroundView.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + 15.0, SCREEN_WIDTH, 24.0);
    self.priceBackgroundView.backgroundColor = [UIColor whiteColor];
    
    /** 售价 */
    self.soldPriceLabel = [UILabel labelWithTitleColorStr:RedTextColor fontSize:17 alignment:NSTextAlignmentLeft];
    self.soldPriceLabel.frame = CGRectMake(12.0, 0.0, 120.0, CGRectGetHeight(self.priceBackgroundView.frame));
    [self.priceBackgroundView addSubview:self.soldPriceLabel];
    self.soldPriceLabel.text = @"3600.00";
    
    /** 原价 */
    self.originPriceLabel = [UILabel labelWithTitleColorStr:RedTextColor fontSize:14 alignment:NSTextAlignmentLeft];
    self.originPriceLabel.frame = CGRectMake(CGRectGetMaxX(self.soldPriceLabel.frame), 0.0, 120.0, CGRectGetHeight(self.priceBackgroundView.frame));
    [self.priceBackgroundView addSubview:self.originPriceLabel];
    self.originPriceLabel.text = @"4200.00";
    
    /** 已售数量 */
    self.soldCountLabel = [UILabel labelWithTitleColorStr:DeepTextColor fontSize:14 alignment:NSTextAlignmentRight];
    self.soldCountLabel.frame = CGRectMake(SCREEN_WIDTH - 200.0, 0.0, 188.0, CGRectGetHeight(self.priceBackgroundView.frame));
    [self.priceBackgroundView addSubview:self.soldCountLabel];
    self.soldCountLabel.text = @"已售: 333";
    
    /** 标识背景view */
    self.markBgView = [[UIView alloc] init];
    self.markBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.priceBackgroundView.frame) + 12.0, SCREEN_WIDTH, 44.0);
    [self addSubview:self.markBgView];
    
    UIView *markLineView = [[UIView alloc] init];
    markLineView.backgroundColor = [UIColor colorWithHexString:BorderColor];
    markLineView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 0.5);
    [self.markBgView addSubview:markLineView];
    
    
    /** 选择规格背景view */
    self.propertyBgView = [UIView setupViewWithSuperView:self withBGColor:@"f6f6f6"];
    self.propertyBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.markBgView.frame), SCREEN_WIDTH, 68.0);
    [self addSubview:self.propertyBgView];
    
    //  选择规格数量页面
    self.propertyView = [[ALATitleValueCellView alloc] initWithTitle:@"规格数量选择" value:@"" target:self action:@selector(propertyViewAction)];
    self.propertyView.frame = CGRectMake(0.0, 10.0, SCREEN_WIDTH, 48.0);
    self.propertyView.backgroundColor = [UIColor whiteColor];
    self.propertyView.showBottomLineView = NO;
    [self.propertyBgView addSubview:self.propertyView];
    
}

-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect rect = CGRectMake(0.0 ,0.0,SCREEN_WIDTH, 375.0);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:nil placeholderImage:nil];
        [_cycleScrollView setBackgroundColor:[UIColor whiteColor]];
        //设置图片视图显示类型
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        //设置轮播视图的分页控件的显示
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //其他分页控件小圆标图片
        _cycleScrollView.pageControlDotSize = CGSizeMake(8, 8);
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"first_qiu"];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"first_qiushi"];
    }
    return _cycleScrollView;
}


/** 设置商品详情数据model */
- (void)setGoodsInfoModel:(ALAGoodsInfoModel *)goodsInfoModel
{
    _goodsInfoModel = goodsInfoModel;
    
    //  轮播图的数据
    NSArray *cycleImageArray = _goodsInfoModel.goodsPics;
    [self.cycleImageModelArray removeAllObjects];
    for (NSString *urlStr in cycleImageArray) {
        [self.cycleImageModelArray addObject:urlStr];
    }
    self.cycleScrollView.imageURLStringsGroup = self.cycleImageModelArray;

    [self addRemarkLabel];
    
    self.goodsNameLabel.text = _goodsInfoModel.goodsName;
    CGFloat goodsNameLabelH = [self.goodsNameLabel.text sizeWithFont:self.goodsNameLabel.font maxW:(SCREEN_WIDTH - 24.0)].height + 20.0;
    self.goodsNameLabel.frame = CGRectMake(16.0, CGRectGetMaxY(self.cycleScrollView.frame) + 15.0, SCREEN_WIDTH - 32.0, goodsNameLabelH);
    self.priceBackgroundView.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + 15.0, SCREEN_WIDTH, 24.0);
    self.markBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.priceBackgroundView.frame) + 12.0, SCREEN_WIDTH, 44.0);
    self.propertyBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.markBgView.frame), SCREEN_WIDTH, 68.0);
    
    //  设置总的高度
    self.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, CGRectGetMaxY(self.propertyBgView.frame));
}

- (void)addRemarkLabel{
    UILabel *remarkLabel = [UILabel labelWithTitleColorStr:@"ff5546" fontSize:12 alignment:NSTextAlignmentCenter];
    remarkLabel.layer.borderColor = [UIColor colorWithHexString:@"ff5546"].CGColor;
    remarkLabel.layer.borderWidth = 1.0;
    remarkLabel.text = @"返利200";
    remarkLabel.frame = CGRectMake(16, 10.0, 70.0, 24);
    [self.markBgView addSubview:remarkLabel];
}

#pragma mark - 按钮点击事件
/** 选择规格数量按钮点击 */
- (void)propertyViewAction{
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(goodsDetailHeaderScrollViewClickChoiseProperty)]) {
        [self.headerDelegate goodsDetailHeaderScrollViewClickChoiseProperty];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
