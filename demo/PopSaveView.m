//
//  PopSaveView.m
//  IOSFinaCustomer
//
//  Created by wwt on 15/4/1.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "PopSaveView.h"
#import "PopSaveViewTableViewCell.h"


CGFloat headerHeight;
CGFloat footerHeight;
CGFloat cornerRadius = 15;

@implementation PopSaveView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PopSaveView" owner:self options:nil];
        if (arrayOfViews.count < 1) {
            return nil;
        }
        if (![arrayOfViews[0] isKindOfClass:[PopSaveView class]]) {
            return nil;
        }
        self = arrayOfViews[0];
        
    }
    return self;
}


- (void)setFrame:(CGRect)frame nameArr:(NSArray *)names values:(NSMutableArray *)values{
    
    NSLog(@"frame = %@",NSStringFromCGRect(frame));
    
    self.frame = frame;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    
    self.names = names;
    self.values = values;
    
    footerHeight = 50;
    if (iPhone4) {
        headerHeight = 55;
    }else{
        headerHeight = 60;
    }
    
    CGFloat spaceLeft = 20;
    
    CGFloat width = (kScreenWidth - 2*spaceLeft)/2;
    CGFloat heigth = 2*width*5.0/4.0;
    
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(spaceLeft,(frame.size.height - heigth)/2, 2*width, heigth)];
    _backGroundView.layer.cornerRadius = cornerRadius;
    [self addSubview:_backGroundView];
    
    UIImage *closeImage = [UIImage imageNamed:@"closeImg"];
    
    _hideViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _hideViewBtn.frame = CGRectMake(spaceLeft + _backGroundView.frame.size.width - closeImage.size.width/2 - 2, (frame.size.height - heigth)/2 - closeImage.size.height/2, closeImage.size.width, closeImage.size.height);
    [_hideViewBtn setImage:closeImage forState:UIControlStateNormal];
    
    self.contentTableView.frame = CGRectMake(0, 0, 2*width, heigth - 20);
    self.contentTableView.layer.cornerRadius = cornerRadius;
    self.contentTableView.backgroundColor = [UIColor whiteColor];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.showsVerticalScrollIndicator = NO;
    self.contentTableView.showsHorizontalScrollIndicator = NO;
    
    [_backGroundView addSubview:self.contentTableView];
    [self addSubview:_hideViewBtn];
    [self.contentTableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.names.count - 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *PopSaveViewTableViewCellID = @"PopSaveViewTableViewCellID";
    //去除复用机制，滑动时容易错误
 
    PopSaveViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PopSaveViewTableViewCellID];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PopSaveViewTableViewCell" owner:self options:nil][0];
    }
   
//    PopSaveViewTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"PopSaveViewTableViewCell" owner:self options:nil][0];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.namelabel.text = self.names[indexPath.row + 1];
    cell.editTextField.delegate = self;
    cell.editTextField.tag = indexPath.row + 1;
    cell.editTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.editTextField.keyboardType = UIKeyboardTypeDefault;
    cell.editTextField.returnKeyType = UIReturnKeyNext;
    
    if (indexPath.row == 2 || indexPath.row == 3) {
        cell.editTextField.placeholder = @"YYYY-MM-DD";
    }else{
        cell.editTextField.placeholder = [NSString stringWithFormat:@"请输入%@",cell.namelabel.text];
    }
    
    if (self.values) {
        
        cell.editTextField.text = self.values[indexPath.row + 1] && ![self.values[indexPath.row + 1] isEqualToString:@"(null)"]?self.values[indexPath.row + 1]:@"未填写";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _backGroundView.frame.size.width, headerHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:backView.frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.names[0];
    label.font = [UIFont systemFontOfSize:23];
    label.textColor = [UIColor blackColor];
    /*
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, label.frame.origin.x + label.frame.size.height, backView.frame.size.width, 1)];
    lineView.backgroundColor = COLOR(224, 224, 224, 1.0f);
    [backView addSubview:lineView];
    */
    [backView addSubview:label];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return footerHeight;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _backGroundView.frame.size.width, footerHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    [backView addGestureRecognizer:tap];
    [_backGroundView addGestureRecognizer:tap];
    
    CGFloat width = 170;
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake((_backGroundView.frame.size.width - width)/2, 10, width, backView.frame.size.height - 5);
    saveBtn.backgroundColor = COLOR(34, 150, 243, 1.0f);
    saveBtn.layer.cornerRadius = 24;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:saveBtn];
    return backView;
}

- (void)saveBtnClick{
    
    [self resignAllResponder];
    
    if (_delegete && [_delegete respondsToSelector:@selector(saveData:)]) {
        [_delegete performSelector:@selector(saveData:) withObject:self.values];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (!iPhone4 && !iPhone5) {
            return 55;
        }
        return 45;
    }
    if (!iPhone4 && !iPhone5) {
        return 55;
    }
    return 40;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag< self.names.count - 1) {
        PopSaveViewTableViewCell *cell = (PopSaveViewTableViewCell *)[self.contentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
        [cell.editTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self.contentTableView setContentOffset:CGPointMake(0,0) animated:YES];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.contentTableView setContentOffset:CGPointMake(0,textField.tag * 30) animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.values replaceObjectAtIndex:textField.tag withObject:textField.text];
}

- (void)tapGes:(UITapGestureRecognizer *)tap{
    [self resignAllResponder];
    [self.contentTableView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)resignAllResponder{
    for (int i = 0; i < self.names.count - 1; i ++ ) {
        PopSaveViewTableViewCell *cell = (PopSaveViewTableViewCell *)[self.contentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.editTextField resignFirstResponder];
    }
}



@end
