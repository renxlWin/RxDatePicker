//
//  ViewController.m
//  RxDatePicker
//
//  Created by RXL on 16/10/10.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "ViewController.h"
#import "RxDatePickView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *choiceDateBtn;
@property (nonatomic, strong) RxDatePickView *datePickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - 点击事件
- (IBAction)choiceDateBtnClick:(id)sender {
    
    [self.view addSubview:self.datePickerView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.datePickerView.transform = CGAffineTransformMakeTranslation(0, -300);
    }];
    
    
}


#pragma mark - 懒加载
-(RxDatePickView *)datePickerView{
    if (_datePickerView == nil) {
        _datePickerView = [[RxDatePickView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height , [UIScreen mainScreen].bounds.size.width, 300)];
    }
    return _datePickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
