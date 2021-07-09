//
//  OCSegmentSliderConfigure.h
//  LBzzz
//
//  Created by 张晓光 on 2021/7/9.
//  Copyright © 2021 labi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCSegmentSliderConfigure : NSObject

// 标题颜色  默认：灰色 gray
@property (nonatomic, strong) UIColor *titleColor;

// 标题选中颜色 默认：红色  red
@property (nonatomic, strong) UIColor *selectedTitleColor;

// 小线条颜色 默认：红色  red  小线条的视图为UIImageView，所以可以给其添加图片
@property (nonatomic, strong) UIColor * downLineColor;

//是否显示下方的线 默认显示
@property (nonatomic, assign) BOOL  showLine;

//正常的字体大小
@property (nonatomic, strong) UIFont  *normalFont;

//选择的字体大小
@property (nonatomic, strong) UIFont  *selectedFont;

//最大的宽度   默认是屏幕的宽度
@property (nonatomic, assign) float maxWidth;

//最大的高度   默认是屏幕的高度 设置view 或 VC 的时候设置此值
@property (nonatomic, assign) float maxHeight;

//第一个按钮到左边的距离
@property (nonatomic, assign) float padding;

//两个按钮间的距离
@property (nonatomic, assign) float spacing;

//线的高度
@property (nonatomic, assign) float  lineHeight;

//使用线的宽度 默认NO
@property (nonatomic, assign) BOOL   useLineWidth;

//线的宽度 结合 useLineWidth使用设置为YES
@property (nonatomic, assign) float lineWidth;

//控制器的数组
@property (nonatomic, strong) NSArray      *VCArray;

//view 的数组
@property (nonatomic, strong) NSArray      *viewArray;


@end

NS_ASSUME_NONNULL_END
