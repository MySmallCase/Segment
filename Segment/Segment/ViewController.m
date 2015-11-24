//
//  ViewController.m
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "SegmentView.h"

@interface ViewController ()<SegmentViewDelegate>

@property (nonatomic,strong) SegmentView *segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.segment];
    
}

- (SegmentView *)segment{
    if (!_segment) {
        
        NSArray *titles = @[@"年",@"月",@"日111",@"天",@"秒"];
        _segment = [[SegmentView alloc] initWithTitles:titles];
//        _segment.showBottomView = NO;
        _segment.selectedIndex = 2 < titles.count ? 2 : 0;  /**< 注意前后的数值要相同*/
        _segment.selectedTitleColor = [UIColor blueColor];
        _segment.normalTitleColor = [UIColor blackColor];
        _segment.delegate = self;
    }
    return _segment;
}

- (void)segmentView:(SegmentView *)segmentView DidClickedSegmentButton:(UIButton *)segmentButton{
//    NSLog(@"%@==",segmentButton.titleLabel.text);
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.segment.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50);
    
}




@end
