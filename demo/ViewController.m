//
//  ViewController.m
//  demo
//
//  Created by wwt on 15/4/9.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "ViewController.h"
#import "PopSaveView.h"



@interface ViewController ()

@property (nonatomic, strong) PopSaveView *popSaveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _popSaveView = [[NSBundle mainBundle] loadNibNamed:@"PopSaveView" owner:self options:nil][0];
    [_popSaveView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) nameArr:[NSArray arrayWithObjects:@"添加新的荣誉资质",@"证书编号",@"颁发机构",@"颁发日期",@"有效日期",@"备注", nil] values:nil];
    
    [_popSaveView.hideViewBtn addTarget:self action:@selector(hideViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:1 animations:^{
        
        [self.view addSubview:_popSaveView];
        
    } completion:^(BOOL finished) {}];
}


- (void)hideViewBtnClick{
    
    [UIView animateWithDuration:1 animations:^{
        
        [_popSaveView removeFromSuperview];
        
    } completion:^(BOOL finished) {}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
