//
//  SegmentView.m
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "SegmentView.h"

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
//    _selectedIndex = 0;
    _selectedIndex = 0;
}


- (void)addSegmentButton{
    
    
    
    if (self.titles.count > 0) {
        for (int i = 0; i < self.titles.count; i ++) {
            UIButton *segmentButton = [[UIButton alloc] init];
            [segmentButton setTitle:self.titles[i] forState:UIControlStateNormal];
            [segmentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [segmentButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            segmentButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            segmentButton.tag = i + 1;
            [segmentButton addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.segmentButtons addObject:segmentButton];
            [self addSubview:segmentButton];
        }
        
        if (_showBottomView) {
            [self addSubview:self.bottomView];
            
            [self addSubview:self.moveView];
            
            
        }
        
        UIButton *segement = self.segmentButtons[self.selectedIndex];
        segement.selected = YES;
        
        
        
    }
}


- (void)segmentButtonClick:(UIButton *)sender{
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
    CGRect moveViewFrame = self.moveView.frame;
    
    moveViewFrame.origin.x = (sender.tag - 1) * width;
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


#pragma mark - getter and setter
//底部分割线
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor grayColor];
    }
    return _bottomView;
}

//底部移动线
- (UIView *)moveView{
    if (!_moveView) {
        _moveView = [[UIView alloc] init];
        _moveView.backgroundColor = [UIColor orangeColor];
    }
    return _moveView;
}


- (void)setShowBottomView:(BOOL)showBottomView{
    _showBottomView = showBottomView;
    self.bottomView.hidden = !showBottomView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segement = self.segmentButtons[i];
        if (i == selectedIndex) {
            segement.selected = YES;
        }else{
            segement.selected = NO;
        }
    }
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
    self.bottomView.frame = CGRectMake(0, boundsH - 1, boundsW, 1);
    
    //计算moveView  frame
    self.moveView.frame = CGRectMake(self.selectedIndex * segmentButtonW, boundsH - 1, segmentButtonW, 1);
    
}

@end
