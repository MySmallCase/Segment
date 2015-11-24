//
//  SegmentView.m
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "SegmentView.h"


#define SINGLE_LINE_WIDTH   (1 / [UIScreen mainScreen].scale)

@interface SegmentView ()

@property (nonatomic,strong) NSMutableArray *segmentButtons; /**< 分段选择按钮数组*/

@property (nonatomic,strong) UIView *moveView; /**< 底部移动线*/

@property (nonatomic,strong) UIView *bottomView; /**< 底部分割线*/

@end

@implementation SegmentView

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        
        //初始化
        [self initializeWithTitles:titles];
        
        [self addSegmentButton];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initializeWithTitles:(NSArray *)titles{
    self.backgroundColor = [UIColor whiteColor];
    _segmentButtons = [[NSMutableArray alloc] init];
    _showBottomView = YES;
    _titles = titles;
    _selectedIndex = 0;
    _bottomLineHeight = 10;
    _normalTitleColor = [UIColor blueColor];
    _selectedTitleColor = [UIColor greenColor];
    _isSameTextWidth = YES;
    _bottomViewColor = [UIColor greenColor];
    _moveViewColor = [UIColor redColor];
}


- (void)addSegmentButton{
    if (self.titles.count > 0) {
        for (int i = 0; i < self.titles.count; i ++) {
            UIButton *segmentButton = [[UIButton alloc] init];
            [segmentButton setTitle:self.titles[i] forState:UIControlStateNormal];
            [segmentButton setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
            [segmentButton setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
            segmentButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            segmentButton.tag = i + 1;
            [segmentButton addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.segmentButtons addObject:segmentButton];
            [self addSubview:segmentButton];
        }
        
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = self.bottomViewColor;
        [self addSubview:self.bottomView];
        
        self.moveView = [[UIView alloc] init];
        self.moveView.backgroundColor = self.moveViewColor;
        [self addSubview:self.moveView];
        self.bottomView.hidden = !self.showBottomView;
        
        UIButton *segement = self.segmentButtons[self.selectedIndex];
        segement.selected = YES;
    }
}


- (void)segmentButtonClick:(UIButton *)sender{
    self.selectedIndex = sender.tag - 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:DidClickedSegmentButton:)]) {
        [self.delegate segmentView:self DidClickedSegmentButton:sender];
    }
    CGFloat width = self.bounds.size.width / self.titles.count;
    [self moveWithCGRect:sender withWidth:width];
}

- (void)moveWithCGRect:(UIButton *)sender withWidth:(CGFloat)width{
    [UIView animateWithDuration:0.3f animations:^{
        [self chageSegmentButtonState:sender];
        self.moveView.frame = [self changeMoveViewFrame:sender withWidth:width];
    }];
}

//改变底部横线的位置
- (CGRect)changeMoveViewFrame:(UIButton *)sender withWidth:(CGFloat)width{
    CGSize textSize = [self titleSize:sender];
    CGRect moveViewFrame = self.moveView.frame;
    if (self.isSameTextWidth) {
        moveViewFrame.origin.x = sender.frame.origin.x + (width - textSize.width) * 0.5;
        moveViewFrame.size.width = textSize.width;
    }else{
        moveViewFrame.origin.x = (sender.tag - 1) * width;
        moveViewFrame.size.width = width;
    }
    moveViewFrame.origin.y = self.frame.size.height - moveViewFrame.size.height;
    return moveViewFrame;
}

//改变segmentButton按钮状态
- (void)chageSegmentButtonState:(UIButton *)sender{
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segement = self.segmentButtons[i];
        if (i == sender.tag - 1) {
            segement.selected = YES;
        }else{
            segement.selected = NO;
        }
    }
}

//通过按钮计算对应title的CGSize
- (CGSize)titleSize:(UIButton *)segmentButton{
    NSDictionary *attr = @{NSFontAttributeName :segmentButton.titleLabel.font};
    return [segmentButton.titleLabel.text sizeWithAttributes:attr];
}

//重载
- (void)overload{
    for (UIView *child in self.subviews) {
        [child removeFromSuperview];
    }
    [self.segmentButtons removeAllObjects];
    [self addSegmentButton];
}


#pragma mark - getter and setter
- (void)setShowBottomView:(BOOL)showBottomView{
    _showBottomView = showBottomView;
    [self overload];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self overload];
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
    [self overload];
    
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    [self overload];
}

- (void)setBottomLineHeight:(NSInteger)bottomLineHeight{
    _bottomLineHeight = bottomLineHeight;
    [self overload];
}

- (void)setBottomViewColor:(UIColor *)bottomViewColor{
    _bottomViewColor = bottomViewColor;
    [self overload];
}

- (void)setMoveViewColor:(UIColor *)moveViewColor{
    _moveViewColor = moveViewColor;
    [self overload];
}

#pragma mark - 计算尺寸
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //计算segmentButton frame
    CGFloat boundsW = self.bounds.size.width;
    CGFloat boundsH = self.bounds.size.height;
    CGFloat segmentButtonW = boundsW / self.titles.count;
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segmentButton = self.segmentButtons[i];
        segmentButton.frame = CGRectMake(i * segmentButtonW, 0, segmentButtonW, boundsH - 1);
    }
    
    //计算showBottomView frame
    self.bottomView.frame = CGRectMake(0, boundsH - SINGLE_LINE_WIDTH * self.bottomLineHeight, boundsW, SINGLE_LINE_WIDTH * self.bottomLineHeight);
    
    //计算moveView  frame
    if (self.isSameTextWidth) {
        UIButton *segment = self.segmentButtons[self.selectedIndex];
        CGSize textSize = [self titleSize:segment];
        self.moveView.frame = CGRectMake(segment.frame.origin.x + (segmentButtonW - textSize.width) * 0.5, boundsH - SINGLE_LINE_WIDTH * self.bottomLineHeight, textSize.width, SINGLE_LINE_WIDTH * self.bottomLineHeight);
    }else{
        self.moveView.frame = CGRectMake(self.selectedIndex * segmentButtonW, boundsH - SINGLE_LINE_WIDTH * self.bottomLineHeight, segmentButtonW, SINGLE_LINE_WIDTH * self.bottomLineHeight);
    }
}

@end
