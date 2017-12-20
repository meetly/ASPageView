//
//  ASPageView.h
//  HeJiaKang
//
//  Created by OneForAll on 2017/12/18.
//  Copyright © 2017年 OneForAll. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ASpageViewDirection) {
    /** 小圆点横向布局 */
    ASpageViewDirectionHorizontal = 0,
    /** 小圆点纵向布局 */
    ASpageViewDirectionVertical,
};

@interface ASPageView : UIView

/** 小圆点个数 */
@property (nonatomic, assign, readonly) NSUInteger pageNumber;
/** 小圆点的布局方向 横向或纵向 */
@property (nonatomic, assign) ASpageViewDirection pageDirection;
/** 小圆点的尺寸  默认 ----（8，8）*/
@property (nonatomic, assign) CGSize pageSize;
/** 小圆点的间距  默认 ---- 10 */
@property (nonatomic, assign) CGFloat pageSpace;
/** 当前选中的第几个圆点 */
@property (nonatomic, assign) NSUInteger currentPage;
/** YES = 圆点  NO = 方形点  默认圆形*/
@property (nonatomic, assign) BOOL circularPage;
/** 小圆点的未选中颜色 默认 ------ */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/** 小圆点的选中状态颜色  默认 ---- */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 * 小圆点选中时的图片  传入多个图片名字，小圆点选中的样式就是对应下标的图片 传入一个默认选中样式一样，传入下标和pageNumber个数不匹配，默认和传入一个相同
 * 设置该属性后，小圆点颜色将不起作用
 */
@property (nonatomic, copy) NSArray *currentPageIndicatorArr;
/**
 *小圆点未选中时的图片  传入多个图片名字，小圆点未选中的样式就是对应下标的图片 传入一个默认未选中样式一样，传入下标和pageNumber个数不匹配，默认和传入一个相同
 * 设置该属性后，小圆点颜色将不起作用
 */
@property (nonatomic, copy) NSArray *pageIndicatorArr;

/**
 点击小圆点的回调
 */
@property (nonatomic, copy) void (^ClickASPageView)(NSUInteger currentPage);

/**
 初始化方法
 @param pageNumber 小圆点个数
 */
- (instancetype)initWithFrame:(CGRect)frame pageNumber:(NSUInteger)pageNumber ;


@end
