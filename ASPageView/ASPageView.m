//
//  ASPageView.m
//  HeJiaKang
//
//  Created by OneForAll on 2017/12/18.
//  Copyright © 2017年 OneForAll. All rights reserved.
//

#import "ASPageView.h"

static NSUInteger pageTag = 1000;

@interface ASPageView (){
    ASpageViewDirection _pageDirection;
    CGSize _pageSize;
    CGFloat _pageSpace;
    NSUInteger _currentPage;
    BOOL _circularPage;
    UIColor *_pageIndicatorTintColor;
    UIColor *_currentPageIndicatorTintColor;
    NSArray *_currentPageIndicatorArr;
    NSArray *_pageIndicatorArr;
}


/**
 * 放小圆点
 */
@property (nonatomic, strong) UIView *btnFardageView;
/**
 * 当前选中的button
 */
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation ASPageView

- (instancetype)initWithFrame:(CGRect)frame pageNumber:(NSUInteger)pageNumber {
    self = [super initWithFrame:frame];
    if (self) {
        self->_pageNumber = pageNumber;
        [self initData];
        [self initView];
    }
    return self;
}
/** 初始化默认数据 */
- (void)initData {
    self.pageSize = CGSizeMake(8, 8);
    self.pageSpace = 10.0;
    self.currentPage = 0;
    self.circularPage = YES;
    self.pageDirection = ASpageViewDirectionHorizontal;
    self.pageIndicatorTintColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.9];
    self.currentPageIndicatorTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
    
}
/** 初始化view */
- (void)initView {
    //放置横向小圆点view
    self.btnFardageView.frame = CGRectMake((self.frame.size.width-(self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.frame.size.height/2-self.pageSize.height/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);

    [self addSubview:self.btnFardageView];
    
    //创建小圆点
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *pagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pagebtn.tag = pageTag + i;

        //圆点 宽高相等
        if (self.circularPage && self.pageSize.width == self.pageSize.height) {
            pagebtn.layer.cornerRadius = self.pageSize.width/2;
        }
        //未选中图片
        if (self.pageIndicatorArr.count >= self.pageNumber) {//每个圆点有对应的未选中图片
            [pagebtn setImage:[UIImage imageNamed:self.pageIndicatorArr[i]] forState:(UIControlStateNormal)];

        }else if (self.pageIndicatorArr.count < self.pageNumber && self.pageIndicatorArr.count>=1) {//小圆点未选中图片都用第一个
            [pagebtn setImage:[UIImage imageNamed:self.pageIndicatorArr.firstObject] forState:(UIControlStateNormal)];
        }
        //已选中图片
        if (self.currentPageIndicatorArr.count >= self.pageNumber) {//每个圆点有对应的选中图片
            [pagebtn setImage:[UIImage imageNamed:self.currentPageIndicatorArr[i]] forState:(UIControlStateSelected)];
            
        }else if (self.currentPageIndicatorArr.count < self.pageNumber && self.currentPageIndicatorArr.count>=1) {//小圆点选中图片都用第一个
            [pagebtn setImage:[UIImage imageNamed:self.currentPageIndicatorArr.firstObject] forState:(UIControlStateSelected)];
        }
        //背景色
        if (i == 0) {
            pagebtn.selected = YES;
            self.selectBtn = pagebtn;
            [pagebtn setBackgroundColor:self.self.currentPageIndicatorTintColor];
        } else {
            pagebtn.selected = NO;
            [pagebtn setBackgroundColor:self.self.pageIndicatorTintColor];
        }
        
        pagebtn.frame = CGRectMake(i*(self.pageSize.width+self.pageSpace), 0, self.pageSize.width, self.pageSize.height);

        [pagebtn addTarget:self action:@selector(pageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnFardageView addSubview:pagebtn];
    }
}
#pragma mark ------------  setter ------------------------
- (void)setPageDirection:(ASpageViewDirection)pageDirection {
    _pageDirection = pageDirection;
    switch (pageDirection) {
        case ASpageViewDirectionHorizontal:
            //放置横向小圆点view
            self.btnFardageView.frame = CGRectMake((self.frame.size.width-(self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.frame.size.height/2-self.pageSize.height/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);
            
            break;
            
        default:
            //放置纵向小圆点view
            self.btnFardageView.frame = CGRectMake(self.frame.size.width/2-self.pageSize.width/2,(self.frame.size.height-(self.pageSize.height * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);
            
            break;
    }
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        switch (self.pageDirection) {
            case ASpageViewDirectionHorizontal:
                button.frame = CGRectMake(i*(self.pageSize.width+self.pageSpace), 0, self.pageSize.width, self.pageSize.height);
                break;
                
            default:
                button.frame = CGRectMake(0, i*(self.pageSize.height+self.pageSpace), self.pageSize.width, self.pageSize.height);
                break;
        }
    }
    
}
- (void)setPageSize:(CGSize)pageSize {
    _pageSize = pageSize;
    switch (self.pageDirection) {
        case ASpageViewDirectionHorizontal:
            //放置横向小圆点view
            self.btnFardageView.frame = CGRectMake((self.frame.size.width-(self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.frame.size.height/2-self.pageSize.height/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);
            
            break;
            
        default:
            //放置纵向小圆点view
            self.btnFardageView.frame = CGRectMake(self.frame.size.width/2-self.pageSize.width/2,(self.frame.size.height-(self.pageSize.height * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);
            
            break;
    }
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        //圆点 宽高相等
        if (self.circularPage && self.pageSize.width == self.pageSize.height) {
            button.layer.cornerRadius = self.pageSize.width/2;
        }
        switch (self.pageDirection) {
            case ASpageViewDirectionHorizontal:
                button.frame = CGRectMake(i*(self.pageSize.width+self.pageSpace), 0, self.pageSize.width, self.pageSize.height);
                break;
                
            default:
                button.frame = CGRectMake(0, i*(self.pageSize.height+self.pageSpace), self.pageSize.width, self.pageSize.height);
                break;
        }
    }
    
}
- (void)setPageSpace:(CGFloat)pageSpace {
    _pageSpace = pageSpace;
    switch (self.pageDirection) {
        case ASpageViewDirectionHorizontal:
            //放置横向小圆点view
            self.btnFardageView.frame = CGRectMake((self.frame.size.width-(self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.frame.size.height/2-self.pageSize.height/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);
            
            break;
            
        default:
            //放置纵向小圆点view
            self.btnFardageView.frame = CGRectMake(self.frame.size.width/2-self.pageSize.width/2,(self.frame.size.height-(self.pageSize.height * self.pageNumber + (self.pageNumber-1) *self.pageSpace))/2, self.pageSize.width * self.pageNumber + (self.pageNumber-1) *self.pageSpace, self.pageSize.height);
            
            break;
    }
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        switch (self.pageDirection) {
            case ASpageViewDirectionHorizontal:
                button.frame = CGRectMake(i*(self.pageSize.width+self.pageSpace), 0, self.pageSize.width, self.pageSize.height);
                break;
                
            default:
                button.frame = CGRectMake(0, i*(self.pageSize.height+self.pageSpace), self.pageSize.width, self.pageSize.height);
                break;
        }
    }
}
- (void)setCurrentPage:(NSUInteger)currentPage {
    _currentPage = currentPage;
    self.selectBtn.selected = NO;
    [self.selectBtn setBackgroundColor:self.pageIndicatorTintColor];
    UIButton *button = [self.btnFardageView viewWithTag:pageTag+currentPage];
    button.selected = YES;
    [button setBackgroundColor:self.currentPageIndicatorTintColor];
    self.selectBtn = button;
    
}
- (void)setCircularPage:(BOOL)circularPage {
    _circularPage = circularPage;
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        button.layer.cornerRadius = 0;
    }
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        if(!button.selected)             [button setBackgroundColor:self.pageIndicatorTintColor];

    }
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        if(button.selected)             [button setBackgroundColor:self.currentPageIndicatorTintColor];
        
    }
}
- (void)setCurrentPageIndicatorArr:(NSArray *)currentPageIndicatorArr {
    _currentPageIndicatorArr = currentPageIndicatorArr;
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        //已选中图片
        if (currentPageIndicatorArr.count >= self.pageNumber) {//每个圆点有对应的选中图片
            [button setImage:[UIImage imageNamed:currentPageIndicatorArr[i]] forState:(UIControlStateSelected)];
            
        }else if (currentPageIndicatorArr.count < self.pageNumber && currentPageIndicatorArr.count>=1) {//小圆点选中图片都用第一个
            [button setImage:[UIImage imageNamed:currentPageIndicatorArr.firstObject] forState:(UIControlStateSelected)];
        }
    }
}
- (void)setPageIndicatorArr:(NSArray *)pageIndicatorArr {
    _pageIndicatorArr = pageIndicatorArr;
    for (int i = 0; i<self.pageNumber; i++) {
        UIButton *button = [self.btnFardageView viewWithTag:pageTag+i];
        //未选中图片
        if (pageIndicatorArr.count >= self.pageNumber) {//每个圆点有对应的未选中图片
            [button setImage:[UIImage imageNamed:pageIndicatorArr[i]] forState:(UIControlStateNormal)];
            
        }else if (pageIndicatorArr.count < self.pageNumber && self.pageIndicatorArr.count>=1) {//小圆点未选中图片都用第一个
            [button setImage:[UIImage imageNamed:pageIndicatorArr.firstObject] forState:(UIControlStateNormal)];
        }
    }
}
#pragma mark ------------   点击事件  -----------------------
/** 点击事件 */
- (void)pageBtnClick:(UIButton *)sender {
    sender.selected = YES;
    [sender setBackgroundColor:self.currentPageIndicatorTintColor];
    [self.selectBtn setBackgroundColor:self.pageIndicatorTintColor];
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.currentPage = sender.tag - pageTag;
    if (self.ClickASPageView) self.ClickASPageView(self.currentPage);
}
#pragma mark -------------   懒加载 --------------------------
- (UIView *)btnFardageView {
    if (!_btnFardageView) {
        _btnFardageView = [[UIView alloc] init];
    }
    return _btnFardageView;
}
@end
