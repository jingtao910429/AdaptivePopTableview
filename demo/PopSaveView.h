//
//  PopSaveView.h
//  IOSFinaCustomer
//
//  Created by wwt on 15/4/1.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@protocol NaturalViewControllerDelegate <NSObject>

- (void)saveData:(NSArray *)myValues;

@end

@interface PopSaveView : UIView <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UIButton *hideViewBtn;

@property (nonatomic, assign) id<NaturalViewControllerDelegate> delegete;

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

- (void)setFrame:(CGRect)frame nameArr:(NSArray *)names values:(NSMutableArray *)values;

@end
