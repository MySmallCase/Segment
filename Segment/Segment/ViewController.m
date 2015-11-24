//
//  ViewController.m
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "SegmentView.h"

@interface ViewController ()

@property (nonatomic,strong) SegmentView *segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.segment];
    
}

- (SegmentView *)segment{
    if (!_segment) {
        
        NSArray *titles = @[@"年",@"月",@"日",@"天",@"秒"];
        _segment = [[SegmentView alloc] initWithTitles:titles];
//        _segment.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50);
//        _segment.showBottomView = NO;
        _segment.selectedIndex = 1 < titles.count ? 1 : 0;
    }
    return _segment;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.segment.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50);
    
}




@end
