//
//  OCSegmentSliderConfigure.m
//  LBzzz
//
//  Created by 张晓光 on 2021/7/9.
//  Copyright © 2021 labi. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OCSegmentSliderConfigure.h"

@interface OCSegmentSliderView : UIView

@property (nonatomic, strong) NSArray      *titleArr;
@property (nonatomic, strong) UIImageView  *lineImgView;
@property (nonatomic, strong) UIButton     *currentBtn;
@property (nonatomic, strong) UIScrollView *showScroll;
@property (nonatomic, strong) UIScrollView *itemScroll;
@property (nonatomic, strong) OCSegmentSliderConfigure *configure;

@property (nonatomic, copy) void(^didSelectItemBlock)(NSInteger index);


- (void)showSliderSwitchItemButton:(NSArray <NSString *> *)titleArray;

@end
