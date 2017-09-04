//
//  GoodsDetailParamTableViewCell.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsParamsModel;

@interface GoodsDetailParamTableViewCell : UITableViewCell

@property (nonatomic, strong) GoodsParamsModel *goodsParamsModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
