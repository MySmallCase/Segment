//
//  SegmentView.h
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentView : UIView

@property (nonatomic,strong) NSArray *titles; /**< 分段选择按钮文字数组*/

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL showBottomView; /**< 时候显示底部分割线*/








- (instancetype)initWithTitles:(NSArray *)titles;

//- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles;

@end
