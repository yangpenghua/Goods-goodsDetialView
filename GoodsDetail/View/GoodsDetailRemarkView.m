//
//  GoodsDetailRemarkView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailRemarkView.h"
#import "GoodsRemarkTableViewCell.h"
#import "GoodRemarkFrame.h"

@interface GoodsDetailRemarkView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL          canScroll;

@end


@implementation GoodsDetailRemarkView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLeaveTopNotificationName object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];//其中一个TAB离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0

    }
    return self;
}

-(void)acceptMsg : (NSNotification *)notification{
    //NSLog(@"%@",notification);
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kGoTopNotificationName]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
        }
    }else if([notificationName isEqualToString:kLeaveTopNotificationName]){
        self.tableView.contentOffset = CGPointZero;
        self.canScroll = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
    }
}

- (void)setupViews{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    [self addSubview:tableView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.tableView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsRemarkFrameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodRemarkFrame *goodRemarkFrame = self.goodsRemarkFrameArray[indexPath.row];
    return goodRemarkFrame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得cell
    GoodsRemarkTableViewCell *cell = [GoodsRemarkTableViewCell cellWithTableView:tableView];
    // 给cell传递模型数据
    cell.goodRemarkFrame = self.goodsRemarkFrameArray[indexPath.row];
    return cell;
}

- (void)setGoodsRemarkFrameArray:(NSArray *)goodsRemarkFrameArray{
    if (_goodsRemarkFrameArray != goodsRemarkFrameArray) {
        _goodsRemarkFrameArray = goodsRemarkFrameArray;
        
        [self.tableView reloadData];
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
