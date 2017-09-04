//
//  ALAThirdGoodsDetailViewController.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/1.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "ALAThirdGoodsDetailViewController.h"
#import "GoodsDetailHeaderScrollView.h"
#import "ALAGoodsInfoModel.h"
#import "GoodsChoiseView.h"
#import "ALAPrivateConfirmOrderViewController.h"
#import "ALALoginUISwitchModel.h"
#import "PrivateGoodsInfoModel.h"
#import "GoodsDetailFooterScrollView.h"
#import "GoodsNavBarView.h"
#import "GoodsParamsModel.h"
#import "UIScrollView+JYPaging.h"
#import "GoodsDetailNavigationView.h"
#import "GoodsDetailBottomView.h"
#import "GoodsDetailTableView.h"

#define kGoodsBottomHeight      50.0
#define kGoodsNavigationHeight  44.0
#define kAnimationDuration      0.45

@interface ALAThirdGoodsDetailViewController ()<GoodsChoiseViewDelegate, GoodsDetailHeaderScrollViewDelegate, GoodsNavBarViewDelegate, GoodsDetailNavigationViewDelegate, GoodsDetailBottomViewDelegate,UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

/** scrollView */
@property (nonatomic, strong) GoodsDetailTableView          *tableView;
/** 导航栏view */
@property (nonatomic, strong) GoodsNavBarView               *navBarView;
/** headerView */
@property (nonatomic, strong) GoodsDetailHeaderScrollView   *goodsHeaderView;
/** goods Navigation View */
@property (nonatomic, strong) GoodsDetailNavigationView     *goodsNavigationView;
/** footerView */
@property (nonatomic, strong) GoodsDetailFooterScrollView   *goodsFooterView;
/** goodsDetail BottomView */
@property (nonatomic, strong) GoodsDetailBottomView         *goodsBottomView;

/** 商品详情model */
@property (nonatomic, strong) ALAGoodsInfoModel             *goodsInfoModel;
/** 自营商品规格属性model */
@property (nonatomic, strong) PrivateGoodsInfoModel         *privateGoodsInfoModel;


@property (nonatomic, assign) BOOL goodsNavigationViewStayTop;
@property (nonatomic, assign) BOOL goodsNavigationViewStayTopPrevious;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) CGFloat goodsDetailHeaderViewHeight;

@end

@implementation ALAThirdGoodsDetailViewController

#pragma mark - 视图控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.goodsID = @"121734";
    [self navigationTitle:@"商品详情"];
    [self setupViews];
    //  获取商品详情
    [self getGoodsDetailInfo];
    //  获取商品规格属性
    [self getGoodsSpecification];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Native Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0;
    if (indexPath.section == 0) {
        cellHeight = SCREEN_HEIGHT - 80.0;
        if (self.goodsDetailHeaderViewHeight > 0.0) {
            cellHeight = self.goodsDetailHeaderViewHeight;
        }
    } else if (indexPath.section == 1) {
        cellHeight = kGoodsNavigationHeight;
    } else if (indexPath.section == 2) {
        cellHeight = SCREEN_HEIGHT - NAVBAR_HEIGHT - kGoodsNavigationHeight - kGoodsBottomHeight;
    }
    return cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        CGFloat goodsHeaderViewHeight = SCREEN_HEIGHT - 80.0;
        if (self.goodsDetailHeaderViewHeight > 0) {
            goodsHeaderViewHeight = self.goodsDetailHeaderViewHeight;
        }
        self.goodsHeaderView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, goodsHeaderViewHeight);
        [cell.contentView addSubview:self.goodsHeaderView];
    } else if (indexPath.section == 1) {
        self.goodsNavigationView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, kGoodsNavigationHeight);
        [cell.contentView addSubview:self.goodsNavigationView];
    } else if (indexPath.section == 2) {
        self.goodsFooterView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - kGoodsNavigationHeight - kGoodsBottomHeight);
        [cell.contentView addSubview:self.goodsFooterView];
    }
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //  设置导航栏透明度(因为当滑动顶部是商品导航栏的偏移量比ScrollView的偏移量高)
    CGFloat contentOffsetY = scrollView.contentOffset.y + 5.0;
    if (contentOffsetY <= 300.0) {
        [self hiddenNavBarViewWithScrollView:scrollView];
    }else{
        [self showNavBarView];
    }
    
    //  设置滑动手势
    CGFloat goodsNavigationViewOffsetY = [_tableView rectForSection:1].origin.y - NAVBAR_HEIGHT;
    _goodsNavigationViewStayTopPrevious = _goodsNavigationViewStayTop;
    if (contentOffsetY >= goodsNavigationViewOffsetY) {
        scrollView.contentOffset = CGPointMake(0, goodsNavigationViewOffsetY);
        _goodsNavigationViewStayTop = YES;
    }else{
        _goodsNavigationViewStayTop = NO;
    }
    if (_goodsNavigationViewStayTop != _goodsNavigationViewStayTopPrevious) {
        if (!_goodsNavigationViewStayTopPrevious && _goodsNavigationViewStayTop) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_goodsNavigationViewStayTopPrevious && !_goodsNavigationViewStayTop){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, goodsNavigationViewOffsetY);
            }
        }
    }
    
    //  设置状态栏颜色
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)showNavBarView{
    self.navBarView.headBackView.alpha = 1.0;
    self.navBarView.left_bt_Image = @"nav_return";
    self.navBarView.color = [UIColor colorWithHexString:@"222222"];
    self.navBarView.title = @"商品详情";
    self.navBarView.bottomLine.alpha = 1.0;
}

- (void)hiddenNavBarViewWithScrollView:(UIScrollView *)scrollView{
    self.navBarView.headBackView.alpha = scrollView.contentOffset.y / 300.0;
    self.navBarView.left_bt_Image = @"goodsDetail_returnBack";
    self.navBarView.title = @"";
    self.navBarView.bottomLine.alpha = 0.0;
}


#pragma mark - Custom Delegate
#pragma mark GoodsDetailHeaderScrollViewDelegate点击规格选择
- (void)goodsDetailHeaderScrollViewClickChoiseProperty{
    [self popupGoodsChoiseView];
}

#pragma mark GoodsDetailBottomViewDelegate点击底部立即购买
- (void)goodsDetailBottomViewClickPurchase{
    [self popupGoodsChoiseView];
}

#pragma mark 点击立即购买
- (void)goodsChoiseViewBuyNowWithDataDict:(NSDictionary *)dataDict{
    ALAPrivateConfirmOrderViewController *VC = [[ALAPrivateConfirmOrderViewController alloc] init];
    VC.goodsModel = self.goodsInfoModel;
    NSInteger goodsCount = [dataDict[kGoodsChoiseViewGoodsName] integerValue];
    VC.goodsCount = goodsCount;
    ALANperInfoModel *nperInfoModel = (ALANperInfoModel *)dataDict[kGoodsChoiseViewByStageModel];
    if (nperInfoModel) {
        VC.selectedNperInfoModel = nperInfoModel;
    }
    GoodsPriceInfoModel *goodsInfoModel = dataDict[kGoodsChoiseViewGoodsPriceInfoModel];
    if (goodsInfoModel) {
        VC.goodsPriceInfoModel = goodsInfoModel;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 导航栏点击返回按钮事件
- (void)goodsNavBarClickLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 商品详情导航
- (void)goodsDetailNavigationDetailImageView{
    [self.goodsFooterView switchToGoodsDetailImagesView];
}

- (void)goodsDetailNavigationDetailParamsView{
    [self.goodsFooterView switchToGoodsDetailParamsView];
}

- (void)goodsDetailNavigationDetailRemarkView{
    [self.goodsFooterView switchToGoodsDetailRemarkView];
}

#pragma mark - Event Response(按钮, 手势点击事件)
#pragma mark 弹出规格选择框
- (void)popupGoodsChoiseView{
    //  先登录
    if (![ALALoginUISwitchModel gainLoginState]){
        [ALALoginUISwitchModel showLoginWithDelegate:self andIsBackFirst:NO];
        return;
    }
    //  如果没有规格属性去重新请求
    if (self.privateGoodsInfoModel.propertyData.count <= 0) {
        [self getGoodsSpecification];
    }
    //  弹出规格现则框
    GoodsChoiseView *choiseView = [GoodsChoiseView popGoodsChoiseView];
    choiseView.goodsInfoModel = self.goodsInfoModel;
    choiseView.delegate = self;
    choiseView.goodsPropertyModelArray = self.privateGoodsInfoModel.propertyData;
    choiseView.goodsPriceModelArray = self.privateGoodsInfoModel.priceData;
}

#pragma mark - 监听是否可以滑动
-(void)acceptMsg:(NSNotification *)notification{
    //  NSLog(@"%@",notification);
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

#pragma mark - 接口Api请求
#pragma mark 获取商品详情接口(如果从消费账单详情过来需要请求数据)
- (void)getGoodsDetailInfo{
//    [ALALoadingView showLoadingTitle:@"加载中..."];
    NSMutableDictionary * dicRequest = [[NSMutableDictionary alloc]init];
    /** 商品id */
    [dicRequest setValue:self.goodsID forKey:@"goodsId"];
    [ALAKit_HttpsRequestDate goodsGetGoodsDetailInfo:dicRequest successBlock:^(NSDictionary *backDictionary) {
        [ALALoadingView dismiss];
        NSString * codeStr = [backDictionary[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            self.goodsInfoModel = [ALAGoodsInfoModel mj_objectWithKeyValues:backDictionary[@"data"]];
            self.goodsHeaderView.goodsInfoModel = self.goodsInfoModel;
            if (self.goodsHeaderView.height > 0.0) {
                self.goodsDetailHeaderViewHeight = self.goodsHeaderView.height;
                [self.tableView reloadData];
            }
            
            self.goodsFooterView.goodsDetailImageModelArray = self.goodsInfoModel.goodsDetail;
            GoodsParamsModel *paramModel = [[GoodsParamsModel alloc] init];
            paramModel.paramName = @"CPU型号";
            paramModel.paramValue = @"麒麟444";

            GoodsParamsModel *paramModel1 = [[GoodsParamsModel alloc] init];
            paramModel1.paramName = @"CPU型号";
            paramModel1.paramValue = @"麒麟444";

            GoodsParamsModel *paramModel2 = [[GoodsParamsModel alloc] init];
            paramModel2.paramName = @"CPU型号";
            paramModel2.paramValue = @"麒麟444";

            
            GoodsParamsModel *paramModel3 = [[GoodsParamsModel alloc] init];
            paramModel3.paramName = @"CPU型号";
            paramModel3.paramValue = @"麒麟444";

            GoodsParamsModel *paramModel4 = [[GoodsParamsModel alloc] init];
            paramModel4.paramName = @"CPU型号";
            paramModel4.paramValue = @"麒麟444";

            NSArray *paramArray = @[paramModel, paramModel1, paramModel2, paramModel3, paramModel4];
            self.goodsFooterView.goodsParamsModelArray = paramArray;
            
        } else {
            NSString * msgStr = [backDictionary[@"msg"] description];
            [SVProgressHUD showErrorWithStatus:msgStr];
        }
    } failureBlock:^(BOOL failure) {
        [ALALoadingView dismiss];
        [SVProgressHUD showErrorWithStatus:Request_Failure];
    }];
}

#pragma mark 获取商品规格属性
- (void)getGoodsSpecification{
    NSMutableDictionary * dicRequest = [[NSMutableDictionary alloc] init];
    /** 商品id */
    [dicRequest setValue:self.goodsID forKey:@"goodsId"];
    [ALAKit_HttpsRequestDate goodsSpecification:dicRequest successBlock:^(NSDictionary *backDictionary) {
        NSString * codeStr = [backDictionary[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            self.privateGoodsInfoModel = [PrivateGoodsInfoModel mj_objectWithKeyValues:backDictionary[@"data"]];
        }
    } failureBlock:^(BOOL failure) {
        [SVProgressHUD showErrorWithStatus:Request_Failure];
    }];
}

#pragma mark - 添加子控件
- (void)setupViews{
    //  添加UITableView
    [self.view addSubview:self.tableView];
    //  添加底部购买按钮
    [self.view addSubview:self.goodsBottomView];
    //  添加导航栏
    [self.view addSubview:self.navBarView];

    self.tableView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - kGoodsBottomHeight);
    self.goodsBottomView.frame = CGRectMake(0.0, SCREEN_HEIGHT - kGoodsBottomHeight , SCREEN_WIDTH, kGoodsBottomHeight);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
}

#pragma mark - setters和getters
- (GoodsDetailTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[GoodsDetailTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - kGoodsBottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (GoodsDetailHeaderScrollView *)goodsHeaderView{
    if (_goodsHeaderView == nil) {
        _goodsHeaderView = [[GoodsDetailHeaderScrollView alloc] init];
        _goodsHeaderView.backgroundColor = [UIColor whiteColor];
        _goodsHeaderView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - kGoodsBottomHeight);
        _goodsHeaderView.headerDelegate = self;
        _goodsHeaderView.scrollEnabled = NO;
    }
    return _goodsHeaderView;
 
}

- (GoodsDetailNavigationView *)goodsNavigationView{
    if (_goodsNavigationView == nil) {
        _goodsNavigationView = [[GoodsDetailNavigationView alloc] init];
        _goodsNavigationView.backgroundColor = [UIColor whiteColor];
        _goodsNavigationView.delegate = self;
    }
    return _goodsNavigationView;
}

- (GoodsDetailFooterScrollView *)goodsFooterView{
    if (_goodsFooterView == nil) {
        _goodsFooterView = [[GoodsDetailFooterScrollView alloc] init];
        _goodsFooterView.backgroundColor = [UIColor whiteColor];
        _goodsFooterView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - kGoodsBottomHeight);
        _goodsFooterView.decelerationRate = 0.3;
    }
    return _goodsFooterView;
}


- (GoodsNavBarView *)navBarView{
    if (_navBarView == nil) {
        _navBarView = [[GoodsNavBarView alloc] init];
        _navBarView.title = @"";
        _navBarView.color = [UIColor colorWithHexString:@"222222"];
        _navBarView.left_bt_Image = @"goodsDetail_returnBack";
        _navBarView.delegate = self;
        _navBarView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, NAVBAR_HEIGHT);
    }
    return _navBarView;
}

- (GoodsDetailBottomView *)goodsBottomView{
    if (_goodsBottomView == nil) {
        _goodsBottomView = [[GoodsDetailBottomView alloc] init];
        _goodsBottomView.backgroundColor = [UIColor whiteColor];
        _goodsBottomView.delegate = self;
    }
    return _goodsBottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
