//
//  GoodsRemarkTableViewCell.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodRemarkFrame;
@interface GoodsRemarkTableViewCell : UITableViewCell

@property (nonatomic, strong)  GoodRemarkFrame *goodRemarkFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
