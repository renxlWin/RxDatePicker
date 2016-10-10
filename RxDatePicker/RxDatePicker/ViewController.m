//
//  ViewController.m
//  RxDatePicker
//
//  Created by RXL on 16/10/10.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "ViewController.h"
#import "RxDatePickView.h"

#define pickViewHigh 200

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *choiceDateBtn;
@property (nonatomic, strong) RxDatePickView *datePickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    [self.choiceDateBtn setTitle:[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]] forState:UIControlStateNormal];
    
}


#pragma mark - 点击事件
- (IBAction)choiceDateBtnClick:(id)sender {
    
    [self.view addSubview:self.datePickerView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.datePickerView.transform = CGAffineTransformMakeTranslation(0, -pickViewHigh);
    }];
    
}


#pragma mark - 懒加载
-(RxDatePickView *)datePickerView{
    
    if (_datePickerView == nil) {
        
        _datePickerView = [[RxDatePickView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height , [UIScreen mainScreen].bounds.size.width, pickViewHigh)];
        
        __weak typeof(self) weakSelf = self;
        
        _datePickerView.choiceTime = ^(NSString *selectedDate){
            
            [weakSelf.choiceDateBtn setTitle:selectedDate forState:UIControlStateNormal];
          
            [UIView animateWithDuration:0.5 animations:^{
                
                weakSelf.datePickerView.transform = CGAffineTransformIdentity;
                
            }completion:^(BOOL finished) {
                
                [weakSelf.datePickerView removeFromSuperview];
                
            }];
            
        };
    }
    return _datePickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
