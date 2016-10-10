//
//  RxDatePickView.m
//  RxDatePicker
//
//  Created by RXL on 16/10/10.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "RxDatePickView.h"

@interface RxDatePickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UIPickerView *pickerView;

@end


@implementation RxDatePickView

#pragma mark - Init

-(instancetype)init
{
    if (self = [super init])
    {
        [self loadDefaultsParameters];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self loadDefaultsParameters];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self loadDefaultsParameters];
    
}

/**
 初始化
 */
-(void)loadDefaultsParameters{
    [self setup];
    
}

-(void)setup{
    [self addSubview:self.toolBar];
    [self addSubview:self.pickerView];
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.leading.trailing.top.equalTo(self);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.toolBar.mas_bottom);
        
    }];
}

#pragma mark - 按钮点击响应事件
-(void)confilmBtnClick{
    
    NSLog(@"hahah");
}

#pragma mark - 数据源以及代理方法

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"hahh";
}

#pragma mark - 懒加载
-(UIToolbar *)toolBar{
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] init];
        
        UIBarButtonItem *confilmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(confilmBtnClick)];
        
        UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:NULL];
        
        _toolBar.items = @[flexibleSpaceItem,confilmBtn];
        
    }
    return _toolBar;
}

-(UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        
    }
    return _pickerView;
}

@end
