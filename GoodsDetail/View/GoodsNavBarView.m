//
//  GoodsNavBarView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/1.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsNavBarView.h"

@interface GoodsNavBarView ()

@property(nonatomic, strong) UILabel  *label;
@property(nonatomic, strong) UIButton *leftBt;
@property(nonatomic, strong) UIButton *rightBt;

@end

@implementation GoodsNavBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];

        self.headBackView=[[UIImageView alloc] init];
        self.headBackView.backgroundColor=[UIColor whiteColor];
        self.headBackView.alpha = 0.0;
        [self addSubview:self.headBackView];
        
        self.leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBt.backgroundColor=[UIColor clearColor];
        [self.leftBt addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftBt];
        
        self.label=[[UILabel alloc] init];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.label];
        
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.backgroundColor = [UIColor clearColor];
        [self.rightBt addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBt];
        
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.backgroundColor = [UIColor colorWithHexString:BorderColor];
        self.bottomLine.alpha = 0.0;
        [self addSubview:self.bottomLine];
    }
    return self;
}
-(void)setLeft_bt_Image:(NSString *)left_bt_Image
{
    _left_bt_Image = left_bt_Image;
    [self.leftBt setImage:[UIImage imageNamed:_left_bt_Image] forState:UIControlStateNormal];
}
-(void)setRight_bt_Image:(NSString *)right_bt_Image
{
    _right_bt_Image = right_bt_Image;
    [self.rightBt setImage:[UIImage imageNamed:_right_bt_Image] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    _title=title;
    self.label.text=title;
}
-(void)setColor:(UIColor *)color{
    _color=color;
    self.label.textColor=color;
}

//  点击左边按钮
-(void)leftClick{
    if ([_delegate respondsToSelector:@selector(goodsNavBarClickLeft)] ) {
        [_delegate goodsNavBarClickLeft];
    }
}

//  点击右边按钮
- (void)rightClick{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.headBackView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    self.leftBt.frame=CGRectMake(5, 20, 44, 44);
    self.label.frame = CGRectMake(60.0, 20, viewWidth - 120.0, 44.0);
    self.rightBt.frame = CGRectMake(viewWidth - 49.0, 20, 44.0, 44.0);
    self.bottomLine.frame = CGRectMake(0.0, viewHeight - 0.5, viewWidth, 0.5);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
