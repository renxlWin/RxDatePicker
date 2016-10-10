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

@property (nonatomic, strong) NSArray *dayArr;

@property (nonatomic, strong) NSMutableArray *todayMinutesArr;

@property (nonatomic, strong) NSMutableArray *lastdayMinutesArr;

@property (nonatomic, strong) NSMutableArray *torrowMinutesArr;

@property (nonatomic, strong) NSMutableArray *otherHourArr;

@property (nonatomic, strong) NSMutableArray *otherMinArr;

@property (nonatomic, strong) NSMutableArray *minutesArr;

@property (nonatomic, strong) NSMutableArray *hourArr;

@property (nonatomic, strong) UIButton *confilmBtn;

@property (nonatomic, assign) NSInteger selectOne;

@property (nonatomic, assign) NSInteger selectTwo;

@property (nonatomic, assign) NSInteger selectThree;

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minutes;

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
    [self defalutValue];
    
}

-(void)defalutValue{
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    [formater setDateFormat:@"yyyy"];
    self.year = [formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
    
    [formater setDateFormat:@"MM"];
    self.month = [formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
    
    [formater setDateFormat:@"dd"];
    self.day = [formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
    
    [formater setDateFormat:@"HH"];
    self.hour = [formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
    
    [formater setDateFormat:@"mm"];
    self.minutes = [formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
    
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
-(void)confilmBtnClick:(UIButton *)button{
    
    self.choiceTime([self showSelectDate]);
}

-(NSString *)showSelectDate{
    
    NSString *SelectedDate = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.year,self.month,self.day,self.hour,self.minutes];
    
    return SelectedDate;
}

#pragma mark - 数据源以及代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.dayArr.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //判断哪一组
    if (component == 0) {
        return 3;
    }else if (component == 1){
        //第0组选择的哪一行
        NSInteger indexRow = [self.pickerView selectedRowInComponent:0];
        NSArray *tempArr = self.hourArr[indexRow];
        
        return tempArr.count;
        
    }else if (component == 2){
        
        //第0组选择的哪一行
        NSInteger indexRow1 = [self.pickerView selectedRowInComponent:0];
        //第一组选择的哪一行
        NSInteger selectRow2 = [self.pickerView selectedRowInComponent:1];
        
        NSArray *tempArr= self.minutesArr[indexRow1];
        NSArray *tempArr2 = tempArr[selectRow2];
        
        return tempArr2.count;
        
    }
    return 0;
}



-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.dayArr[row];
    }else if (component == 1){
        
        
        NSArray *tempArr = self.hourArr[self.selectOne];
        
        if (tempArr.count > row) {
            return self.hourArr[self.selectOne][row];
        }
        
        
    }else if (component == 2){

        
        NSArray *dayArr = self.minutesArr[self.selectOne];
        
        if ( dayArr.count > self.selectTwo ) {
            
            NSArray *minArr = dayArr[self.selectTwo];
            
            if (minArr.count > row ) {
                
                return minArr[row];
                
            }
        }
    }
    
    
    return nil;
}




-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    if (component == 0) {
        
        self.selectOne = row;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
        
        [formater setDateFormat:@"yyyy"];
        
        //判断选择的时间
        NSInteger choiceDay = [pickerView selectedRowInComponent:0];
        
        //判断年份
        if([[formater stringFromDate:[NSDate date]] isEqualToString:[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:choiceDay * 24 * 60 * 60]]]){
            
            self.year = [formater stringFromDate:[NSDate date]];
            
        }else{
            
            self.year =[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:choiceDay * 24 * 60 * 60]];
            
        };
        
        //判断月份
        [formater setDateFormat:@"MM"];
        
        if([[formater stringFromDate:[NSDate date]] isEqualToString:[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:choiceDay * 24 * 60 * 60]]]){
            
            self.month = [formater stringFromDate:[NSDate date]];
            
        }else{
            
            self.month =[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:choiceDay * 24 * 60 * 60]];
            
        };
        
        //判断日期
        [formater setDateFormat:@"dd"];
        
        if([[formater stringFromDate:[NSDate date]] isEqualToString:[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:choiceDay * 24 * 60 * 60]]]){
            
            self.day = [formater stringFromDate:[NSDate date]];
            
        }else{
            
            self.day =[formater stringFromDate:[NSDate dateWithTimeIntervalSinceNow:choiceDay * 24 * 60 * 60]];
            
        };
        
    }else if (component == 1){
        
        [pickerView reloadComponent:2];
        
        //判断几点
        [formater setDateFormat:@"HH"];
        
        NSString *hourTitle = [self pickerView:pickerView titleForRow:self.selectTwo forComponent:1];
        
        self.hour = [hourTitle substringToIndex:[hourTitle length]-1];
        
        self.selectTwo = row;
        
        
    }else{
        
        self.selectThree = row;
        
        //判断分钟
        [formater setDateFormat:@"mm"];
        
        NSString *minTitle = [self pickerView:pickerView titleForRow:self.selectThree forComponent:2];
        
        self.minutes = [minTitle substringToIndex:[minTitle length]-1];
        
    }

}

#pragma mark - 懒加载

-(NSMutableArray *)hourArr{
    if (_hourArr == nil) {
        _hourArr = [NSMutableArray array];
        
        for (int i = 0; i < 3; ++i) {
            
            if (i == 0) {
                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                
                [dateFormatter setDateFormat:@"HH"];
                
                NSString *Str=[dateFormatter stringFromDate:[NSDate date]];
                
                NSMutableArray *tempArr = [NSMutableArray array];
                
                for (int i = [Str intValue]; i < 24; ++i) {
                    
                    [tempArr addObject:[NSString stringWithFormat:@"%02d点",i]];
                    
                }
                
                [_hourArr addObject:tempArr];
                
                
            }else if (i == 1){
                
                [_hourArr addObject:self.otherHourArr];
                
            }else{
                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                
                [dateFormatter setDateFormat:@"HH"];
                
                NSString *Str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
                
                NSMutableArray *tempArr = [NSMutableArray array];
                
                for (int i = 0; i < [Str intValue]; ++i) {
                    
                    [tempArr addObject:[NSString stringWithFormat:@"%02d点",i]];
                }
                
                [_hourArr addObject:tempArr];
            }
            
            
        }
        
    }
    
    
    return _hourArr;
}


-(NSArray *)dayArr{
    if (_dayArr == nil) {
        _dayArr = @[@"今天",@"明天",@"后天"];
    }
    return _dayArr;
}


-(NSMutableArray *)minutesArr{
    if (_minutesArr == nil) {
        _minutesArr = [NSMutableArray arrayWithCapacity:3];
        
        [_minutesArr addObject:self.todayMinutesArr];
        [_minutesArr addObject:self.torrowMinutesArr];
        [_minutesArr addObject:self.lastdayMinutesArr];
        
        
    }
    return _minutesArr;
}


/**
 对应的今天的分钟数据结构
 */
-(NSMutableArray *)todayMinutesArr{
    if (_todayMinutesArr == nil) {
        _todayMinutesArr = [NSMutableArray array];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        [dateFormatter setDateFormat:@"HH"];
        
        NSString *Str=[dateFormatter stringFromDate:[NSDate date]];
        
        for (int i = [Str intValue]; i < 24; ++i) {
            
            NSMutableArray *perHourArr = [NSMutableArray array];
            
            if (i == [Str intValue]) {
                
                NSDateFormatter *minutesFormatter=[[NSDateFormatter alloc]init];
                
                [minutesFormatter setDateFormat:@"mm"];
                
                NSString *minutes=[minutesFormatter stringFromDate:[NSDate date]];
                
                
                
                for (int j = [minutes intValue]; j < 60; ++j) {
                    
                    NSString *minStr = [NSString stringWithFormat:@"%02d分",j];
                    
                    [perHourArr addObject:minStr];
                    
                }
                
                [_todayMinutesArr addObject:perHourArr];
                
            }else{
                
                [_todayMinutesArr addObject:self.otherMinArr];
                
            }
            
        }
        
        
    }
    
    return _todayMinutesArr;
}


/**
 对应的后天的分钟数据结构
 */
-(NSMutableArray *)lastdayMinutesArr{
    if (_lastdayMinutesArr == nil) {
        _lastdayMinutesArr = [NSMutableArray array];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        [dateFormatter setDateFormat:@"HH"];
        
        NSString *Str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
        
        for (int i = 0; i < [Str intValue]; ++i) {
            
            NSMutableArray *perHourArr = [NSMutableArray array];
            
            if (i == [Str intValue] - 1) {
                
                NSDateFormatter *minutesFormatter=[[NSDateFormatter alloc]init];
                
                [minutesFormatter setDateFormat:@"mm"];
                
                NSString *minutes=[minutesFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:48 * 60 * 60]];
                
                //                NSMutableArray *minutesArr = [NSMutableArray array];
                
                for (int j = 0; j < [minutes intValue]; ++j) {
                    
                    NSString *minStr = [NSString stringWithFormat:@"%002d分",j];
                    
                    [perHourArr addObject:minStr];
                    
                }
                
                [_lastdayMinutesArr addObject:perHourArr];
                
                
            }else{
                
                [_lastdayMinutesArr addObject:self.otherMinArr];
                
            }
        }
    }
    
    return _lastdayMinutesArr;
}


/**
 对应的明天的分钟数据结构
 */
-(NSMutableArray *)torrowMinutesArr{
    if (_torrowMinutesArr == nil) {
        _torrowMinutesArr = [NSMutableArray arrayWithCapacity:24];
        
        for (int i = 0; i < 24; ++i) {
            
            [_torrowMinutesArr addObject:self.otherMinArr];
            
        }
        
    }
    return _torrowMinutesArr;
}


-(NSMutableArray *)otherMinArr{
    if (_otherMinArr == nil) {
        
        _otherMinArr = [NSMutableArray arrayWithCapacity:60];
        
        for (int i = 0; i < 60; ++i) {
            
            [_otherMinArr addObject:[NSString stringWithFormat:@"%02d分",i]];
            
        }
    }
    return _otherMinArr;
}

-(NSMutableArray *)otherHourArr{
    _otherHourArr = [NSMutableArray arrayWithCapacity:60];
    
    for (int i = 0; i < 24; ++i) {
        
        [_otherHourArr addObject:[NSString stringWithFormat:@"%02d点",i]];
        
    }
    
    return _otherHourArr;
}

-(UIToolbar *)toolBar{
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] init];
        
        UIBarButtonItem *confilmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(confilmBtnClick:)];
        
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
