//
//  OCSegmentSliderConfigure.m
//  LBzzz
//
//  Created by 张晓光 on 2021/7/9.
//  Copyright © 2021 labi. All rights reserved.
//

#import "OCSegmentSliderConfigure.h"

@implementation OCSegmentSliderConfigure

- (instancetype)init {
    
    if (self = [super init])
    {
        self.showLine = YES;
        self.normalFont = [UIFont systemFontOfSize:14];
        self.selectedFont = [UIFont systemFontOfSize:15];
        self.padding = 15.0;
        self.spacing = 20.0;
        self.lineHeight = 2.0;
        self.useLineWidth = NO;
        self.maxWidth = [UIScreen mainScreen].bounds.size.width;
        self.maxHeight = [UIScreen mainScreen].bounds.size.height;
        self.titleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor redColor];
    }
    return self;
}

// 标题颜色  默认：灰色 gray
- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
}

// 标题选中颜色 默认：红色  red
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    
    _selectedTitleColor = selectedTitleColor;
}

// 小线条颜色 默认：红色  red  小线条的视图为UIImageView，所以可以给其添加图片
- (void)setDownLineColor:(UIColor *)downLineColor {
    
    _downLineColor = downLineColor;
}

//是否显示下方的线 默认显示
- (void)setShowLine:(BOOL)showLine {
    
    _showLine = showLine;
}

//正常的字体大小
- (void)setNormalFont:(UIFont *)normalFont {
    
    _normalFont = normalFont;
}

//选择的字体大小
- (void)setSelectedFont:(UIFont *)selectedFont {
    
    _selectedFont = selectedFont;
}

//最大的宽度   默认是屏幕的宽度
- (void)setMaxWidth:(float)maxWidth {
    
    _maxWidth = maxWidth;
}

//第一个按钮到左边的距离
- (void)setPadding:(float)padding {
    
    _padding = padding;
}

//两个按钮间的距离
- (void)setSpacing:(float)spacing {
    
    _spacing = spacing;
}

//线的宽度
- (void)setLineWidth:(float)lineWidth {
    
    _lineWidth = lineWidth;
}

//线的高度
- (void)setLineHeight:(float)lineHeight {
    
    _lineHeight = lineHeight;
}

//控制器的数组
- (void)setVCArray:(NSArray *)VCArray {
    
    _VCArray = VCArray;
    
}

//view 的数组
- (void)setViewArray:(NSArray *)viewArray {
    
    _viewArray = viewArray;
}

@end
