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
        _segment = [[SegmentView alloc] init];
        _segment.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50);
        _segment.titles = titles;
        _segment.showBottomView = YES;
        _segment.isSameTextWidth = NO;
        _segment.selectedIndex = 3 < titles.count ? 3 : 0;  /**< 注意前后的数值要相同*/
        _segment.selectedTitleColor = [UIColor blueColor];
        _segment.normalTitleColor = [UIColor redColor];
        _segment.bottomLineHeight = 10 ;
        _segment.delegate = self;
        _segment.moveViewColor = [UIColor yellowColor];
        _segment.bottomViewColor = [UIColor redColor];
    }
    return _segment;
}

- (void)segmentView:(SegmentView *)segmentView DidClickedSegmentButton:(UIButton *)segmentButton{
//    NSLog(@"%@==",segmentButton.titleLabel.text);
}





@end
