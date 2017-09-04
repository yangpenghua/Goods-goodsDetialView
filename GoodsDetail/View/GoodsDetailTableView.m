//
//  GoodsDetailTableView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/3.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailTableView.h"

@implementation GoodsDetailTableView

/** 比如说UITableView 上面有个 scrollView, 实现了这个方法那么滑动手势都可以作用在这两个view上 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
