//
//  OCSegmentSliderConfigure.m
//  LBzzz
//
//  Created by 张晓光 on 2021/7/9.
//  Copyright © 2021 labi. All rights reserved.
//

#import "OCSegmentSliderView.h"

@interface OCSegmentSliderView ()<UIScrollViewDelegate>

@end

@implementation OCSegmentSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame])
    {
        self.configure = [[OCSegmentSliderConfigure alloc] init];
    }
    return self;
}


#pragma mark -- private method

//创建button
- (void)showSliderSwitchItemButton:(NSArray <NSString *> *)titleArray {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        self.configure.maxWidth = self.frame.size.width;
        [self addSubview:self.itemScroll];

        self.titleArr = [NSArray arrayWithArray:titleArray];
        
        for (UIButton *btn in self.itemScroll.subviews)
        {
            if ([btn isKindOfClass:[UIButton class]])
            {
                [btn removeFromSuperview];
            }
        }

        NSInteger btnOffset = 0;
        for (int i = 0; i < self.titleArr.count; i++)
        {
            //添加上面的小标题按钮
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:self.configure.titleColor forState:UIControlStateNormal];
            [btn setTitleColor:self.configure.selectedTitleColor forState:UIControlStateSelected];
            btn.titleLabel.font = self.configure.normalFont;
            
            CGSize size = [self sizeOfLabelWithCustomMaxWidth:self.configure.maxWidth fontSize:self.configure.selectedFont andFilledTextString:self.titleArr[i]];
            
            float originX =  i ? self.configure.spacing + btnOffset:self.configure.padding;
        
            btn.frame = CGRectMake(originX, 0, size.width, self.frame.size.height - self.configure.lineHeight);
            btnOffset = CGRectGetMaxX(btn.frame);
            [btn addTarget:self action:@selector(changeSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 111 + i;
            [self.itemScroll addSubview:btn];
            
            if (self.configure.showLine)
            {
                [self.itemScroll addSubview:self.lineImgView];
            }
        
            //默认选中第一个按钮
            if (i == 0)
            {
                self.currentBtn = btn;
                btn.selected = YES;
                btn.titleLabel.font = self.configure.selectedFont;
                self.configure.lineWidth = self.configure.useLineWidth ? self.configure.lineWidth : btn.frame.size.width;
                self.lineImgView.frame = CGRectMake(0, 0, self.configure.lineWidth, self.configure.lineHeight);
                
                self.lineImgView.center = CGPointMake(btn.center.x, self.frame.size.height - self.configure.lineHeight/2);
            }
            
            //添加下面的显示View
            UIView * view = nil;
            if (self.configure.VCArray)
            {
                UIViewController * vc = self.configure.VCArray[i];
                view = vc.view;
            }
            if (self.configure.viewArray)
            {
                view= self.self.configure.viewArray[i];
            }
            
            if (self.configure.VCArray.count > 0 || self.configure.viewArray.count > 0)
            {
                view.frame = CGRectMake(i * self.configure.maxWidth, 0, self.configure.maxWidth, self.configure.maxHeight - self.frame.origin.y - self.itemScroll.frame.size.height);
                [[self currentViewController].view addSubview:self.showScroll];
                [self.showScroll addSubview:view];
            }
        }
        
        self.itemScroll.contentSize = CGSizeMake(btnOffset + self.configure.padding, self.frame.size.height);
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = scrollView.contentOffset.x / self.configure.maxWidth;
    UIButton * currentButton = [self viewWithTag:111 + index];
    self.currentBtn.selected = NO;//上一个
    currentButton.selected = YES;
    self.currentBtn = currentButton;
    [self didSelectItem:index currentButton:currentButton];
    
    if (self.didSelectItemBlock)
    {
        self.didSelectItemBlock(index);
    }
}

#pragma  mark - event - 选项卡点击事件

/* 选项卡的点击 */
-(void)changeSelectedItem:(UIButton *)currentButton{
    
    self.currentBtn.selected = NO;//上一个
    currentButton.selected = YES;
    self.currentBtn = currentButton;
    NSInteger flag = currentButton.tag - 111;
    
    self.showScroll.contentOffset = CGPointMake(flag * self.configure.maxWidth, 0);
    
    [self didSelectItem:flag currentButton:currentButton];
    
    if (self.didSelectItemBlock)
    {
        self.didSelectItemBlock(flag);
    }
}

- (void)didSelectItem:(NSInteger)index currentButton:(UIButton *)currentButton {
    
    for (UIButton *btn in self.itemScroll.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]])
        {
            btn.titleLabel.font = self.configure.normalFont;
        }
    }
    currentButton.titleLabel.font = self.configure.selectedFont;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (index == 0)
        {
            self.configure.lineWidth = self.configure.useLineWidth ? self.configure.lineWidth : currentButton.frame.size.width;
            
            self.lineImgView.frame = CGRectMake(0, 0,self.configure.lineWidth, self.configure.lineHeight);
            self.lineImgView.center = CGPointMake(currentButton.center.x, self.frame.size.height - self.configure.lineHeight/2);
        }
        else
        {
            if (self.itemScroll.contentSize.width > self.frame.size.width)
            {
                float offsetX = CGRectGetMinX(currentButton.frame);
                if (offsetX < self.configure.maxWidth/2)
                {
                    self.itemScroll.contentOffset = CGPointMake(0, 0);
                }
                else if (offsetX >= self.configure.maxWidth/2 && offsetX <= self.itemScroll.contentSize.width - self.configure.maxWidth/2)
                {
                    self.itemScroll.contentOffset = CGPointMake(offsetX - self.configure.maxWidth/2 + self.configure.padding, 0);
                }
                else
                {
                    self.itemScroll.contentOffset = CGPointMake(self.itemScroll.contentSize.width - self.configure.maxWidth, 0);
                }
            }
        
            self.configure.lineWidth = self.configure.useLineWidth ? self.configure.lineWidth : currentButton.frame.size.width;
            self.lineImgView.frame = CGRectMake(0, 0, self.configure.lineWidth, self.configure.lineHeight);
            self.lineImgView.center = CGPointMake(currentButton.center.x, self.frame.size.height - self.configure.lineHeight/2);
        }
    }];
}

//获取当前视图控制器
- (UIViewController *)currentViewController
{
    UIViewController *viewController = [[UIApplication sharedApplication].windows firstObject].rootViewController;
    while (viewController.presentedViewController)
    {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

//根据文字长度返回size
- (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width fontSize:(UIFont *)fontSize andFilledTextString:(NSString *)str{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = str;
    label.numberOfLines = 0;
    label.font = fontSize;
    //让label通过文字设置size
    [label sizeToFit];
    //获取label 的size
    CGSize size = label.frame.size;
    //返回出去
    return size;
}

#pragma mark -- lazy

- (UIScrollView *)itemScroll
{
    if (_itemScroll == nil)
    {
        _itemScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.configure.maxWidth, self.frame.size.height)];
//        _itemScroll = [[UIScrollView alloc] init];
        _itemScroll.showsHorizontalScrollIndicator = NO;
        _itemScroll.showsVerticalScrollIndicator = NO;
        _itemScroll.alwaysBounceHorizontal = NO;
        _itemScroll.alwaysBounceVertical = YES;
        _itemScroll.bounces = NO;
    }
    return _itemScroll;
}

- (UIScrollView *)showScroll
{
    if (_showScroll == nil)
    {
        _showScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.frame.origin.y + self.itemScroll.frame.size.height, self.configure.maxWidth, self.configure.maxHeight - self.frame.origin.y + self.itemScroll.frame.size.height)];
        _showScroll.contentSize = CGSizeMake(self.configure.maxWidth * self.titleArr.count , self.configure.maxHeight - self.frame.origin.y + self.itemScroll.frame.size.height);
        _showScroll.showsHorizontalScrollIndicator = NO;
        _showScroll.showsVerticalScrollIndicator = NO;
        _showScroll.alwaysBounceHorizontal = NO;
        _showScroll.alwaysBounceVertical = YES;
        _showScroll.bounces = NO;
        _showScroll.pagingEnabled = YES;
        _showScroll.delegate = self;
    }
    return _showScroll;
}

//初始化操作
- (UIImageView *)lineImgView {
    
    if (!_lineImgView)
    {
        _lineImgView = [[UIImageView alloc] init];
        //_lineImgView.image = [UIImage imageNamed:@"nar_bgbg"];
        if (self.configure.downLineColor)
        {
            _lineImgView.backgroundColor = self.configure.downLineColor;
        }
        else
        {
            _lineImgView.backgroundColor = [UIColor redColor];
        }
    }
    return _lineImgView;
}

@end
